use formula1;

ALTER TABLE CIRCUIT ADD CONSTRAINT CK_CircuitLengthKm_Positive CHECK (CircuitLengthKm > 0);

ALTER TABLE SEASON ADD CONSTRAINT CK_SeasonDates CHECK (SeasonEndDate >= SeasonStartDate);

ALTER TABLE GRAND_PRIX ADD CONSTRAINT CK_GrandPrixLaps CHECK (NumberOfRaceLaps > 0);

ALTER TABLE RACE_RESULT ADD CONSTRAINT CK_FinishingPosition_Positive CHECK (FinishingPosition IS NULL OR FinishingPosition > 0);

ALTER TABLE RACE_RESULT ADD CONSTRAINT CK_ClassificationStatus CHECK (ClassificationStatus IN ('classified', 'DNF', 'DSQ'));

ALTER TABLE RACE_RESULT ADD CONSTRAINT CK_FastestLapFlag CHECK (FastestLapFlag IN (0,1));

ALTER TABLE PENALTY ADD CONSTRAINT CK_PenaltyTime_Positive CHECK (PenaltyTimeSeconds IS NULL OR PenaltyTimeSeconds >= 0);

ALTER TABLE DRIVER_SEASON_STANDING ADD CONSTRAINT CK_DriverSeasonPoints_Positive CHECK (DriverSeasonPointsTotal >= 0);

ALTER TABLE TEAM_SEASON_STANDING ADD CONSTRAINT CK_TeamSeasonPoints_Positive CHECK (TeamSeasonPointsTotal >= 0);

ALTER TABLE SCORING_RULE ADD CONSTRAINT CK_ScoringPoints_Positive CHECK (PointsValue >= 0 AND FinishingPosition > 0);
