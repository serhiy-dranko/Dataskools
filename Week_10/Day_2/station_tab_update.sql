--- It creates a table called "stations". Table where we have capacity by station where we combain it with Neighborhood data Washington DC.

INSTALL spatial;
LOAD spatial;

CREATE OR REPLACE TABLE station AS
WITH dc_neighborhoods AS (
    SELECT * FROM ST_Read('C:\Users\User\Documents\Dataskools\week_10\day_1\neighborhood_data\Neighborhood_Clusters.geojson')
),
station_raw AS (
    SELECT 
        station.station_id,
        station.short_name,
        station.name,
        station.lat,
        station.lon,
        station.capacity
    FROM (
        SELECT unnest(data.stations) AS station
        FROM read_json_auto('https://gbfs.lyft.com/gbfs/2.3/dca-cabi/en/station_information.json')
    )
)
SELECT 
    s.station_id,
    s.short_name,
    s.name,
    s.lat,
    s.lon,
    s.capacity,
    COALESCE(n.NAME || ' - ' || n.NBH_NAMES, 'Cluster Other - Outside DC (VA/MD)') AS neighborhood
FROM station_raw AS s
LEFT JOIN dc_neighborhoods AS n
    ON ST_Contains(n.geom, ST_Point(s.lon, s.lat));

--- It creates a table called "stations_summary". Table where we have Summury by station where total_rides over 100.

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
                AVG(COALESCE(s.capacity,'0'))                                                                AS station_capacity -- show actual capacity
                                
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
