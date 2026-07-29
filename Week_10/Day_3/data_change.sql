CREATE OR REPLACE TABLE stations_summary AS
              SELECT
                t.start_station_id                                                                           AS ID_station,
                t.start_station                                                                              AS station_name,
                COALESCE(s.neighborhood,'Cluster history - Without geomarks')                                AS neighborhood,
                COALESCE(s.lat,'00.00')                                                                      AS latitude,
                COALESCE(s.lon,'00.00')                                                                      AS longitude,
                COUNT(t.bike_id)                                                                             AS total_rides, -- count total rides
                ROUND((SUM(CASE WHEN t.rider_type = 'casual' THEN 1 ELSE 0 END) / COUNT(t.bike_id) *100),0)  AS casual_rides_percentage, -- count casual rider's % to Total
                ROUND((SUM(CASE WHEN t.rider_type = 'member' THEN 1 ELSE 0 END) / COUNT(t.bike_id) *100),0)  AS member_rides_percentage, -- count member rider's % to Total
                ROUND(AVG(date_part('epoch', t.end_time - t.start_time) / 60),0)                             AS average_ride_duration_min, -- calculate average duration
                AVG(s.capacity)                                                                              AS station_capacity -- show actual capacity
                                
              FROM trips                                                                                     AS t 
              -- Connecting to the Capacity data ---
              Left JOIN station                                                                              AS s
                ON t.start_station_id = s.short_name

                    -- Choose data only with station filled --
              WHERE t.start_station is not null 
                   -- Filter only possitive Duration's --
                   AND t.end_time > t.start_time
                   -- Filter Duration Between 1 min and 24 hours --                 
                   AND (date_part('epoch', t.end_time - t.start_time) / 60) < 1440
                   AND (date_part('epoch', t.end_time - t.start_time) / 60) >= 1
                   -- Filter suspicios stations ---
                   AND t.start_station_id NOT IN ('00000', 'MTL-ECO5-03')
                   
                                   
              GROUP BY ID_station, station_name, latitude, longitude, neighborhood
              -- Filter capacity equal or over 100 redes per 7 years --
              HAVING total_rides >= 100
              -- Sort by quantity of rides --   
              ORDER BY total_rides DESC;

CREATE OR REPLACE TABLE trips AS
  SELECT
    bike_id,
    start_time,
    end_time,
    start_station_id,
    start_station,
    end_station_id,
    end_station,
    rider_type,
    bike_type,
    ROUND(SUM(date_part('epoch', end_time - start_time) / 60),2) AS duration
  FROM trips_legacy
  GROUP BY 
    bike_id,
    start_time,
    end_time,
    start_station_id,
    start_station,
    end_station_id,
    end_station,
    rider_type,
    bike_type
  
UNION ALL
  SELECT 
    bike_id,
    start_time,
    end_time,
    start_station_id,
    start_station,
    end_station_id,
    end_station,
    rider_type,
    bike_type,
    ROUND(SUM(date_part('epoch', end_time - start_time) / 60),2) AS duration
  FROM trips_modern
  GROUP BY 
    bike_id,
    start_time,
    end_time,
    start_station_id,
    start_station,
    end_station_id,
    end_station,
    rider_type,
    bike_type
   ;




CREATE OR REPLACE TABLE trips AS
  SELECT
   *
  FROM trips_legacy

UNION ALL
  SELECT 
   *
  FROM trips_modern
;

--COUNT 31937071
--------31937007
