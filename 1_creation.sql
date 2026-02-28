use formula1;

CREATE TABLE CIRCUIT(
   CircuitName VARCHAR(50),
   CircuitCity VARCHAR(50),
   CircuitCountry VARCHAR(50),
   CircuitLengthKm DECIMAL(5,2),
   PRIMARY KEY(CircuitName)
);

CREATE TABLE TEAM(
   TeamID VARCHAR(50),
   TeamName VARCHAR(50),
   TeamNationality VARCHAR(50),
   PRIMARY KEY(TeamID)
);

CREATE TABLE DRIVER(
   DriverNumber INT,
   DriverLastName VARCHAR(50),
   DriverFirstName VARCHAR(50),
   DriverDateOfBirth DATE,
   DriverNationality VARCHAR(50),
   PRIMARY KEY(DriverNumber)
);

CREATE TABLE SCORING_SYSTEM(
   ScoringSystemID VARCHAR(50),
   PRIMARY KEY(ScoringSystemID)
);

CREATE TABLE SEASON(
   SeasonYear INT,
   SeasonStartDate DATE,
   SeasonEndDate DATE,
   SeasonYear_1 INT,
   ScoringSystemID VARCHAR(50) NOT NULL,
   PRIMARY KEY(SeasonYear),
   UNIQUE(SeasonYear_1),
   FOREIGN KEY(SeasonYear_1) REFERENCES SEASON(SeasonYear),
   FOREIGN KEY(ScoringSystemID) REFERENCES SCORING_SYSTEM(ScoringSystemID)
);

CREATE TABLE GRAND_PRIX(
   GrandPrixID VARCHAR(50),
   GrandPrixName VARCHAR(50),
   GrandPrixDate DATE,
   WeatherCondition VARCHAR(50),
   NumberOfRaceLaps INT,
   CircuitName VARCHAR(50) NOT NULL,
   SeasonYear INT NOT NULL,
   PRIMARY KEY(GrandPrixID),
   FOREIGN KEY(CircuitName) REFERENCES CIRCUIT(CircuitName),
   FOREIGN KEY(SeasonYear) REFERENCES SEASON(SeasonYear)
);

CREATE TABLE SESSION(
   SessionID VARCHAR(50),
   SessionType VARCHAR(50),
   SessionDate DATE,
   SessionStartTime TIME,
   GrandPrixID VARCHAR(50) NOT NULL,
   PRIMARY KEY(SessionID),
   FOREIGN KEY(GrandPrixID) REFERENCES GRAND_PRIX(GrandPrixID)
);

CREATE TABLE RACE_RESULT(
   RaceResultID VARCHAR(50),
   FinishingPosition INT,
   GridPosition INT,
   FastestLapTime TIME,
   FastestLapFlag BOOLEAN,
   ClassificationStatus VARCHAR(50),
   DriverNumber INT NOT NULL,
   GrandPrixID VARCHAR(50) NOT NULL,
   PRIMARY KEY(RaceResultID),
   FOREIGN KEY(DriverNumber) REFERENCES DRIVER(DriverNumber),
   FOREIGN KEY(GrandPrixID) REFERENCES GRAND_PRIX(GrandPrixID)
);

CREATE TABLE PENALTY(
   PenaltyID VARCHAR(50),
   PenaltyType VARCHAR(50),
   PenaltyTimeSeconds TIME,
   RaceResultID VARCHAR(50) NOT NULL,
   PRIMARY KEY(PenaltyID),
   FOREIGN KEY(RaceResultID) REFERENCES RACE_RESULT(RaceResultID)
);

CREATE TABLE DRIVER_SEASON_STANDING(
   DriverSeasonStandingID VARCHAR(50),
   DriverSeasonPointsTotal INT,
   SeasonYear INT NOT NULL,
   DriverNumber INT NOT NULL,
   PRIMARY KEY(DriverSeasonStandingID),
   FOREIGN KEY(SeasonYear) REFERENCES SEASON(SeasonYear),
   FOREIGN KEY(DriverNumber) REFERENCES DRIVER(DriverNumber)
);

CREATE TABLE TEAM_SEASON_STANDING(
   TeamSeasonStandingID VARCHAR(50),
   TeamSeasonPointsTotal INT,
   SeasonYear INT NOT NULL,
   TeamID VARCHAR(50) NOT NULL,
   PRIMARY KEY(TeamSeasonStandingID),
   FOREIGN KEY(SeasonYear) REFERENCES SEASON(SeasonYear),
   FOREIGN KEY(TeamID) REFERENCES TEAM(TeamID)
);

CREATE TABLE SCORING_RULE(
   ScoringRuleID VARCHAR(50),
   FinishingPosition INT NOT NULL,
   PointsValue INT,
   ScoringSystemID VARCHAR(50) NOT NULL,
   PRIMARY KEY(ScoringRuleID),
   FOREIGN KEY(ScoringSystemID) REFERENCES SCORING_SYSTEM(ScoringSystemID)
);

CREATE TABLE contract(
   SeasonYear INT,
   TeamID VARCHAR(50),
   DriverNumber INT,
   PRIMARY KEY(SeasonYear, TeamID, DriverNumber),
   FOREIGN KEY(SeasonYear) REFERENCES SEASON(SeasonYear),
   FOREIGN KEY(TeamID) REFERENCES TEAM(TeamID),
   FOREIGN KEY(DriverNumber) REFERENCES DRIVER(DriverNumber)
);