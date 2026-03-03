-- 1. List drivers of a specific team (Mclaren for example) with their total season points
SELECT D.DriverFirstName, D.DriverLastName, DSS.DriverSeasonPointsTotal
FROM DRIVER D
JOIN DRIVER_SEASON_STANDING DSS ON D.DriverNumber = DSS.DriverNumber
JOIN contract C ON D.DriverNumber = C.DriverNumber
WHERE C.TeamID = 'T1' AND DSS.SeasonYear = 2024
ORDER BY DSS.DriverSeasonPointsTotal DESC;


-- 2. Final classification of Grand Prix GP1
SELECT D.DriverFirstName, D.DriverLastName, RR.FinishingPosition
FROM RACE_RESULT RR
JOIN DRIVER D ON RR.DriverNumber = D.DriverNumber
WHERE RR.GrandPrixID = 'GP1'
ORDER BY RR.FinishingPosition;


-- 3. Drivers who achieved at least one fastest lap
SELECT DISTINCT D.DriverFirstName, D.DriverLastName
FROM RACE_RESULT RR
JOIN DRIVER D ON RR.DriverNumber = D.DriverNumber
WHERE RR.FastestLapFlag = 1;


-- 4. Grand Prix races held under rainy weather conditions
SELECT GP.GrandPrixName, GP.GrandPrixDate
FROM GRAND_PRIX GP
WHERE GP.WeatherCondition LIKE '%Rain%';


-- 5. Drivers who finished in the top 5 at least once
SELECT DISTINCT D.DriverFirstName, D.DriverLastName
FROM RACE_RESULT RR
JOIN DRIVER D ON RR.DriverNumber = D.DriverNumber
WHERE RR.FinishingPosition BETWEEN 1 AND 5;



-- =====================================================
-- B. AGGREGATION QUERIES (GROUP BY / HAVING)
-- =====================================================

-- 6. Number of races participated in by each driver
SELECT D.DriverFirstName, D.DriverLastName, COUNT(RR.RaceResultID) AS RacesCount
FROM DRIVER D
JOIN RACE_RESULT RR ON D.DriverNumber = RR.DriverNumber
GROUP BY D.DriverNumber
ORDER BY RacesCount DESC;


-- 7. Average season points per driver (only drivers above 150 points)
SELECT D.DriverFirstName, D.DriverLastName, AVG(DSS.DriverSeasonPointsTotal) AS AvgPoints
FROM DRIVER D
JOIN DRIVER_SEASON_STANDING DSS ON D.DriverNumber = DSS.DriverNumber
GROUP BY D.DriverNumber
HAVING AVG(DSS.DriverSeasonPointsTotal) > 150;


-- 8. Number of penalties per penalty type
SELECT PenaltyType, COUNT(PenaltyID) AS TotalPenalties
FROM PENALTY
GROUP BY PenaltyType;


-- 9. Number of DNF and DSQ per driver
SELECT D.DriverFirstName, D.DriverLastName,
       SUM(CASE WHEN RR.ClassificationStatus='DNF' THEN 1 ELSE 0 END) AS DNF_Count,
       SUM(CASE WHEN RR.ClassificationStatus='DSQ' THEN 1 ELSE 0 END) AS DSQ_Count
FROM DRIVER D
JOIN RACE_RESULT RR ON D.DriverNumber = RR.DriverNumber
GROUP BY D.DriverNumber
ORDER BY DNF_Count DESC;


-- 10. Total points per team
SELECT T.TeamName, SUM(TSS.TeamSeasonPointsTotal) AS TeamPoints
FROM TEAM T
JOIN TEAM_SEASON_STANDING TSS ON T.TeamID = TSS.TeamID
GROUP BY T.TeamID
ORDER BY TeamPoints DESC;



-- =====================================================
-- C. JOIN QUERIES (INNER, LEFT, MULTIPLE JOINS)
-- =====================================================

-- 11. List all drivers and their contractual team (including drivers without a contract)
SELECT D.DriverFirstName, D.DriverLastName, C.TeamID
FROM DRIVER D
LEFT JOIN contract C ON D.DriverNumber = C.DriverNumber;


-- 12. List all Grand Prix races with their corresponding circuits
SELECT GP.GrandPrixName, C.CircuitName, C.CircuitCity, C.CircuitCountry
FROM GRAND_PRIX GP
INNER JOIN CIRCUIT C ON GP.CircuitName = C.CircuitName;


-- 13. Complete race results of GP1 including team information
SELECT D.DriverFirstName, D.DriverLastName, RR.FinishingPosition, C.TeamID
FROM RACE_RESULT RR
JOIN DRIVER D ON RR.DriverNumber = D.DriverNumber
JOIN contract C ON D.DriverNumber = C.DriverNumber AND C.SeasonYear = 2024
WHERE RR.GrandPrixID='GP1'
ORDER BY RR.FinishingPosition;


-- 14. Drivers and their penalties (including drivers without penalties)
SELECT D.DriverFirstName, D.DriverLastName, P.PenaltyType, P.PenaltyTimeSeconds
FROM DRIVER D
LEFT JOIN RACE_RESULT RR ON D.DriverNumber = RR.DriverNumber
LEFT JOIN PENALTY P ON RR.RaceResultID = P.RaceResultID;


-- 15. Number of classified drivers per Grand Prix
SELECT GP.GrandPrixName, COUNT(RR.RaceResultID) AS ClassifiedDrivers
FROM GRAND_PRIX GP
LEFT JOIN RACE_RESULT RR 
       ON GP.GrandPrixID = RR.GrandPrixID 
       AND RR.ClassificationStatus = 'classified'
GROUP BY GP.GrandPrixID;



-- =====================================================
-- D. NESTED QUERIES (IN, NOT IN, EXISTS, etc.)
-- =====================================================

-- 16. Drivers who have never finished outside the top 10
SELECT D.DriverFirstName, D.DriverLastName
FROM DRIVER D
WHERE D.DriverNumber NOT IN (
    SELECT RR.DriverNumber
    FROM RACE_RESULT RR
    WHERE RR.FinishingPosition > 10
);


-- 17. Grand Prix races where a specific driver achieved fastest lap
SELECT GP.GrandPrixName
FROM GRAND_PRIX GP
WHERE GP.GrandPrixID IN (
    SELECT RR.GrandPrixID
    FROM RACE_RESULT RR
    JOIN DRIVER D ON RR.DriverNumber = D.DriverNumber
    WHERE D.DriverLastName='Schneider' AND RR.FastestLapFlag=1
);


-- 18. Drivers with more than two penalties
SELECT D.DriverFirstName, D.DriverLastName
FROM DRIVER D
WHERE D.DriverNumber IN (
    SELECT RR.DriverNumber
    FROM RACE_RESULT RR
    JOIN PENALTY P ON RR.RaceResultID = P.RaceResultID
    GROUP BY RR.DriverNumber
    HAVING COUNT(P.PenaltyID) > 2
);


-- 19. Drivers who have never been disqualified (DSQ)
SELECT D.DriverFirstName, D.DriverLastName
FROM DRIVER D
WHERE NOT EXISTS (
    SELECT 1
    FROM RACE_RESULT RR
    WHERE RR.DriverNumber = D.DriverNumber
    AND RR.ClassificationStatus = 'DSQ'
);


-- 20. Grand Prix races with fewer than 15 classified drivers
SELECT GP.GrandPrixName
FROM GRAND_PRIX GP
WHERE (
    SELECT COUNT(*)
    FROM RACE_RESULT RR
    WHERE RR.GrandPrixID = GP.GrandPrixID
    AND RR.ClassificationStatus = 'classified'
) < 15;