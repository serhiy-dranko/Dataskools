INSTALL spatial;
LOAD spatial;

CREATE OR REPLACE TABLE dc_neighborhoods AS
  
SELECT * FROM ST_Read('C:\Users\User\Documents\Dataskools\week_10\day_1\neighborhood_data\Neighborhood_Clusters.geojson');

CREATE OR REPLACE TABLE station_and_neighborhoods AS
              SELECT 
                  s.station_id,
                  s.short_name,
                  s.name,
                  s.lat,
                  s.lon,
                  s.capacity,
                  COALESCE(n.NAME || ' - ' || n.NBH_NAMES, 'Cluster Other - Outside DC (VA/MD)') AS neighborhood
              FROM station                                                                       AS s
                LEFT JOIN dc_neighborhoods                                                       AS n
                  ON ST_Contains(n.geom, ST_Point(s.lon, s.lat));

CREATE OR REPLACE TABLE neighborhoods_summary AS
              SELECT
                t.start_station_id                                                                           AS ID_station,
                t.start_station                                                                              AS station_name,
                COALESCE(s.lat,'00.00')                                                                      AS latitude,
                COALESCE(s.lon,'00.00')                                                                      AS longitude,
                COALESCE(s.neighborhood, 'Cluster history - Without geomarks')                               AS neighborhood,
                COUNT(t.bike_id)                                                                             AS total_rides,               -- count total rides
                ROUND((SUM(CASE WHEN t.rider_type = 'casual' THEN 1 ELSE 0 END) / COUNT(t.bike_id) *100),0)  AS casual_rides_percentage,   -- count casual rider's % to Total
                ROUND((SUM(CASE WHEN t.rider_type = 'member' THEN 1 ELSE 0 END) / COUNT(t.bike_id) *100),0)  AS member_rides_percentage,   -- count member rider's % to Total
                ROUND(AVG(date_part('epoch', t.end_time - t.start_time) / 60),0)                             AS average_ride_duration_min, -- calculate average duration
                AVG(COALESCE(s.capacity,'0'))                                                                AS station_capacity           -- show actual capacity
                                
              FROM trips                                                                                     AS t 
              -- Connecting to the Capacity data ---
              Left JOIN station_and_neighborhoods                                                             AS s
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
