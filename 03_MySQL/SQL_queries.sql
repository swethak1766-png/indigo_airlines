CREATE DATABASE indigo_database;

USE indigo_database;

SHOW TABLES;
SELECT *
FROM flight_data
LIMIT 10;

SELECT `ï»¿`, QUARTER, MONTH, DAY_OF_MONTH
FROM flight_data
LIMIT 10;

USE indigo_database;

ALTER TABLE flight_data
RENAME COLUMN `ï»¿` TO row_id;

SHOW COLUMNS FROM flight_data;

USE indigo_database;

SELECT COUNT(*) AS total_records FROM flight_data;
SELECT COUNT(DISTINCT CONCAT(ORIGIN, '-', DEST)) AS total_routes FROM flight_data;
SELECT COUNT(DISTINCT ORIGIN) AS origin_airports,COUNT(DISTINCT DEST) AS destination_airports FROM flight_data;
SELECT
    SUM(ORIGIN IS NULL OR ORIGIN = '') AS missing_origins,
    SUM(DEST IS NULL OR DEST = '') AS missing_destinations,
    SUM(CRS_DEP_DATETIME IS NULL OR CRS_DEP_DATETIME = '') AS missing_departure_times,
    SUM(CRS_ARR_DATETIME IS NULL OR CRS_ARR_DATETIME = '') AS missing_arrival_times
FROM flight_data;

SELECT COUNT(*) AS total_records,COUNT(DISTINCT CONCAT(ORIGIN, '|',DEST, '|', CRS_DEP_DATETIME, '|',CRS_ARR_DATETIME 
    )) AS unique_flight_combinations
FROM flight_data;

SELECT
    ORIGIN,
    DEST,
    COUNT(*) AS total_flights
FROM flight_data
GROUP BY ORIGIN, DEST
ORDER BY total_flights DESC
LIMIT 10;

SELECT
    MONTH,
    COUNT(*) AS total_flights
FROM flight_data
GROUP BY MONTH
ORDER BY MONTH;

SELECT
    ORIGIN,
    COUNT(*) AS total_flights
FROM flight_data
GROUP BY ORIGIN
ORDER BY total_flights DESC
LIMIT 10;

SELECT
    ORIGIN,
    DEST,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                STR_TO_DATE(CRS_DEP_DATETIME, '%Y-%m-%d %H:%i:%s'),
                STR_TO_DATE(CRS_ARR_DATETIME, '%Y-%m-%d %H:%i:%s')
            )
        ) / 60,
        2
    ) AS avg_duration_hours
FROM flight_data
GROUP BY ORIGIN, DEST
ORDER BY avg_duration_hours DESC
LIMIT 10;

SELECT
    COUNT(*) AS total_records,
    COUNT(ARR_DELAY_NEW) AS records_with_delay,
    MIN(ARR_DELAY_NEW) AS minimum_delay,
    MAX(ARR_DELAY_NEW) AS maximum_delay,
    ROUND(AVG(ARR_DELAY_NEW), 2) AS average_delay
FROM flight_data;

SELECT
    ORIGIN,
    DEST,
    ARR_DELAY_NEW
FROM flight_data
ORDER BY ARR_DELAY_NEW DESC
LIMIT 10;

SELECT
    ORIGIN,
    DEST,
    CRS_DEP_DATETIME,
    CRS_ARR_DATETIME,
    ARR_DELAY_NEW
FROM flight_data
ORDER BY ARR_DELAY_NEW DESC
LIMIT 10;

SELECT
    COUNT(*) AS total_records,
    SUM(
        TIMESTAMPDIFF(
            MINUTE,
            STR_TO_DATE(CRS_DEP_DATETIME, '%Y-%m-%d %H:%i:%s'),
            STR_TO_DATE(CRS_ARR_DATETIME, '%Y-%m-%d %H:%i:%s')
        ) > 0
    ) AS positive_duration_records,
    SUM(
        TIMESTAMPDIFF(
            MINUTE,
            STR_TO_DATE(CRS_DEP_DATETIME, '%Y-%m-%d %H:%i:%s'),
            STR_TO_DATE(CRS_ARR_DATETIME, '%Y-%m-%d %H:%i:%s')
        ) <= 0
    ) AS zero_or_negative_duration_records
FROM flight_data;

USE indigo_database;

SELECT COUNT(*) FROM flight_data;

