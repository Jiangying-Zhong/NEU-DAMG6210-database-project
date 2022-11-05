USE "Team 9";
-- Create Tables
CREATE TABLE [Contract]
(ContractID VARCHAR(20) PRIMARY KEY,
 TeamID VARCHAR(20) REFERENCES Team(TeamID),
 ClubJoined Date,
 ContractUntil Date,
 ReleaseClause MONEY
 );

CREATE TABLE Country
(
CountryID VARCHAR(20) PRIMARY KEY,
CountryName VARCHAR(30)
);

CREATE TABLE GK
(
PlayerID VARCHAR(20) PRIMARY KEY,
GK_Position int,
GK_Diving int,
GK_Kicking int,
GK_Handing int,
GK_Reflexes int,
GK_Rating int
);

CREATE TABLE League
(LeagueID VARCHAR(20) PRIMARY KEY,
 [Name] VARCHAR(50));

CREATE TABLE Matches
(
MatchID VARCHAR(20) PRIMARY KEY,
HomeID VARCHAR(20) REFERENCES Country(CountryID),
AwayID VARCHAR(20) REFERENCES Country(CountryID),
HomeScore int,
AwayScore int,
City VARCHAR(30),
Tournament varchar(300)
)

CREATE TABLE [Physic_Fitness]
(PlayerID VARCHAR(20) PRIMARY KEY REFERENCES Player(PlayerID),
 DateOfBirth Date,
 Age INT,
 Height FLOAT,
 [Weight] FLOAT,
 PhysicalityScore INT
 );

CREATE TABLE Player
(
PlayerID VARCHAR(20) PRIMARY KEY,
PlayerFirstName VARCHAR(30),
PlayerLastName VARCHAR(30),
Potential int,
BestPosition VARCHAR(20),
Wage int,
Nationality varchar(20),
ContractID varchar(20) REFERENCES Contract(ContractID),
CountryID varchar(20) REFERENCES Country(CountryID)
)

CREATE TABLE Player_Position
(
PlayerID VARCHAR(20) REFERENCES Player(PlayerID),
PositionID VARCHAR(20) REFERENCES Positions(PositionID)
)

CREATE TABLE Positions
(
PositionID VARCHAR(20) PRIMARY KEY,
PositionName VARCHAR(30)
);

Create table [Professional Skills] 
(PlayerID varchar(20) references Player(PlayerID) Primary key,
Pace int,
Shotting int,
Passing int,
Dribbling int,
Defending int)

CREATE TABLE Team
(TeamID VARCHAR(20) PRIMARY KEY,
 [Name] VARCHAR(50),
 LeagueID VARCHAR(20) REFERENCES League(LeagueID),
 TransferBudget MONEY,
 DomesticPrestige INT,
 IntPrestige INT);

CREATE TABLE [Team_Ability]
(TeamID VARCHAR(20) PRIMARY KEY REFERENCES Team(TeamID),
 Overall INT,
 Attack INT,
 Midfield INT,
 Defence INT);

-- Insert Data Using "Insert" Function
INSERT INTO Positions (PositionID ,PositionName)
VALUES ('P01','RW'),('P02','ST'),('P03','CAM'),('P04','CB'),('P05','CDM'),('P06','CF'),('P07','CM'),
		('P08','GK'),('P09','LB'),('P10','LM'),('P11','LW'),('P12','LWB'),('P13','RB'),('P14','RM'),
		('P15','RWB');

INSERT INTO League (LeagueID ,Name)
VALUES ('13','English Premier League (1)'),('16','French Ligue 1 (1)'),('19','German 1. Bundesliga (1)'),
		('31','Italian Serie A (1)'),('53','Spain Primera Division (1)'),('353','Argentina Primera División  (1)'),
		('351','Australian Hyundai A-League (1)'),('80','Austrian Football Bundesliga (1)'),('4','Belgian Jupiler Pro League (1)'),
		('7','Campeonato Brasileiro Série A (1)'),('335','Chilian Campeonato Nacional (1)'),('2012','Chinese Super League (1)'),
		('336','Colombian Liga Postobón (1)'),('317','Croatian Prva HNL (1)'),('319','Czech Republic Gambrinus Liga (1)'),
		('1','Danish Superliga (1)'),('2018','Ecuadorian Serie A (1)'),('14','English League Championship (2)'),
		('60','English League One (3)'),('61','English League Two (4)'),('322','Finnish Veikkausliiga (1)'),
		('17','French Ligue 2 (2)'),('20','German 2. Bundesliga (2)'),('2076','German 3. Bundesliga (3)'),
		('63','Greek Super League (1)'),('10','Holland Eredivisie (1)'),('78','International'),
		('32','Italian Serie B (2)'),('349','Japanese J. League Division 1 (1)'),('83','Korean K League 1 (1)'),
		('2017','Liga de Fútbol Profesional Boliviano (1)'),('341','Mexican Liga MX (1)'),('41','Norwegian Eliteserien (1)'),
		('337','Paraguayan Primera División (1)'),('2020','Peruvian Primera División (1)'),('66','Polish T-Mobile Ekstraklasa (1)'),
		('308','Portuguese Liga ZON SAGRES (1)'),('65','Rep. Ireland Airtricity League (1)'),('330','Romanian Liga I (1)'),
		('67','Russian Premier League (1)'),('350','Saudi Abdul L. Jameel League (1)'),('50','Scottish Premiership (1)'),
		('347','South African Premier Division (1)'),('54','Spanish Segunda División (2)'),('56','Swedish Allsvenskan (1)'),
		('189','Swiss Super League (1)'),('68','Turkish Süper Lig (1)'),('2013','UAE Arabian Gulf League (1)'),
		('39','USA Major League Soccer (1)'),('332','Ukrainian Premier League (1)'),('338','Uruguayan Primera División (1)'),
		('2019','Venezuelan Primera División (1)');

INSERT INTO Country (CountryID,CountryName) VALUES ('C01','Argentina'),
                                              ('C02','Portugal'),
											  ('C03','Poland'),
									   	      ('C04','Brazil'),
										      ('C05','Belgium'),
											  ('C06','Slovenia'),
											  ('C07','France'),
											  ('C08','Netherlands'),
										      ('C09','Germany'),
											  ('C10','Egypt'),
											  ('C11','Korea Republic'),
											  ('C12','Spain'),
											  ('C13','Costa Rica'),
											  ('C14','England'),
											  ('C15','Senegal'),
											  ('C16','Slovenia')
UPDATE Country SET CountryName = 'Italy' WHERE CountryID = 'C16'

INSERT INTO Contract (ContractID,TeamID,ClubJoined,ContractUntil,ReleaseClause)
VALUES ('Con31','45','2017-01-01','2024-01-01','87500000');

INSERT INTO Player (PlayerID,PlayerFirstName,PlayerLastName,Potential,BestPosition,Wage,Nationality,ContractID,CountryID)
VALUES ('186153','Wojciech','Szczęsny',87,'GK',105000,'Poland','Con31','C03');

INSERT INTO [Professional Skills] (PlayerID,Pace,Shooting,Passing,Dribbling,Defending)
VALUES ('186153',86,82,73,88,49);

INSERT INTO Player_Position (PlayerID,PositionID)
VALUES ('186153','P08');

ALTER TABLE Contract DROP Column Column7;
ALTER TABLE GK DROP Column GK_Position;
ALTER TABLE GK ADD Column GK_Position int;

DROP TABLE GK;
DELETE FROM GK ;
DELETE FROM Physic_Fitness ;

-- Insert Data by Using Stored Procedure
CREATE OR ALTER PROCEDURE addMatches
	@MatchID VARCHAR(20),
	@HomeID VARCHAR(20),
	@AwayID VARCHAR(20),
	@HomeScore int,
	@AwayScore int,
	@City VARCHAR(100),
	@Tournament VARCHAR(150)
AS
BEGIN
	INSERT INTO dbo.Matches  
	VALUES (@MatchID,@HomeID,@AwayID,@HomeScore,@AwayScore,@City,@Tournament);
END

EXECUTE addMatches 'M01','C04','C01',0,1,'Rio de Janeiro','Copa AmÃcrica';
EXECUTE addMatches 'M02','C01','C04',0,0,'San Juan','FIFA World Cup qualification';
EXECUTE addMatches 'M03','C12','C02',0,0,'Madrid','Friendly';
EXECUTE addMatches 'M04','C09','C02',4,2,'Munich','UEFA Euro';
EXECUTE addMatches 'M05','C02','C07',2,2,'Budapest','UEFA Euro';
EXECUTE addMatches 'M06','C05','C02',1,0,'Seville','UEFA Euro';
EXECUTE addMatches 'M07','C05','C07',2,3,'Turin','UEFA Nations League';
EXECUTE addMatches 'M08','C09','C07',0,1,'Munich','UEFA Euro';
EXECUTE addMatches 'M09','C12','C07',1,2,'Milan','UEFA Nations League';
EXECUTE addMatches 'M10','C14','C09',2,0,'London','UEFA Euro';
EXECUTE addMatches 'M11','C12','C03',1,1,'Seville','UEFA Euro';
EXECUTE addMatches 'M12','C14','C03',2,1,'London','FIFA World Cup qualification';
EXECUTE addMatches 'M13','C03','C14',1,1,'Warsaw','FIFA World Cup qualification';
EXECUTE addMatches 'M14','C05','C16',1,2,'Munich','UEFA Euro';
EXECUTE addMatches 'M15','C16','C12',1,1,'London','UEFA Euro';
EXECUTE addMatches 'M16','C14','C16',1,1,'London','UEFA Euro';
EXECUTE addMatches 'M17','C16','C12',1,2,'Milan','UEFA Nations League';
EXECUTE addMatches 'M18','C16','C05',2,1,'Turin','UEFA Nations League';

-- Computed Columns based on a function
-- Calculate Age From DataOfBirth
CREATE FUNCTION Age_Calculation(@DOB date)
RETURNS int
AS BEGIN
	DECLARE @age int;
	SET @age = DATEDIFF(hour,@DOB,GETDATE())/8766;
	RETURN @age
END;
ALTER TABLE Physic_Fitness ADD Age AS dbo.Age_Calculation(DateOfBirth);

-- Table-level CHECK Constraints based on a function
CREATE FUNCTION CheckPosition (@PID varchar(20))
RETURNS smallint
AS
BEGIN
   DECLARE @Count smallint=0;
   SELECT @Count = COUNT(PlayerID) 
          FROM Player
          WHERE PlayerID = @PID
          AND [Bestposition] != 'GK';
   RETURN @Count;
END;

DROP function CheckPosition

ALTER TABLE GK ADD CONSTRAINT BanBestPosition CHECK (dbo.CheckPosition(PlayerID) = 0);
--Test Check Level Constraint
INSERT GK(PlayerID,GK_Diving,GK_Handing,GK_Kicking,GK_Position,GK_Rating,GK_Reflexes) 
VALUES (20801,11,15,14,11,10,10);

-- Column Data Encryption
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'Team9 Test Certificate',
EXPIRY_DATE = '2026-10-31';
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

ALTER TABLE Contract
ALTER COLUMN ReleaseClause VARCHAR(250);
-- Use CONVERT to convert the plain data to VARBINARY
INSERT
INTO Contract
(
ContractID,
TeamID ,
ClubJoined ,
ContractUntil ,
ReleaseClause 
)
VALUES
('Con32' , 240,'2020-01-01','2022-01-01',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, '104600000')));
INSERT
INTO Contract
(
ContractID,
TeamID ,
ClubJoined ,
ContractUntil ,
ReleaseClause 
)
VALUES
('Con33' , 243,'2012-01-01','2022-01-01',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 
'74800000')));
SELECT * FROM Contract;
-- Use DecryptByKey to decrypt the encrypted data and see what we have in the table
select ContractID, TeamID ,ClubJoined ,ContractUntil ,convert(varchar,DecryptByKey(ReleaseClause)) FROM Contract WHERE ContractID = 'Con32';
select ContractID, TeamID ,ClubJoined ,ContractUntil ,convert(varchar,DecryptByKey(ReleaseClause)) FROM Contract WHERE ContractID = 'Con33';

CLOSE SYMMETRIC KEY TestSymmetricKey;
DROP SYMMETRIC KEY TestSymmetricKey;
DROP CERTIFICATE TestCertificate;
DROP MASTER KEY;

-- Create View 1
-- create view to see the most 15 valuable player's nationality and belonged team
CREATE VIEW ValuablePlayerInTeam
      AS
      SELECT FullName,Nationality,Name AS TeamName,ReleaseClause
      FROM
      (SELECT p.PlayerFirstName +' '+p.PlayerLastName as FullName, p.Nationality,t.TeamID,t.Name,ReleaseClause,
      		Rank() OVER (ORDER BY CAST(c.ReleaseClause AS money) DESC) AS [Ranking]
      FROM dbo.Team t
      INNER JOIN dbo.Contract c
      ON c.TeamID = t.TeamID 
      INNER JOIN dbo.Player p
      ON p.ContractID = c.ContractID) temp
      WHERE Ranking <= 15;

SELECT * FROM ValuablePlayerInTeam ORDER BY CAST(ReleaseClause AS money) DESC;
DROP VIEW ValuablePlayerInTeam;

-- Create View 2
CREATE VIEW TeamRanking AS
WITH temp AS
(SELECT t.Name ,Overall ,Attack ,Midfield ,Defence ,
	RANK() OVER (ORDER BY ta.Overall DESC) AS [Ranking1],
	RANK() OVER (ORDER BY ta.Attack  DESC) AS [Ranking2],
	RANK() OVER (ORDER BY ta.Midfield DESC) AS [Ranking3],
	RANK() OVER (ORDER BY ta.Defence DESC) AS [Ranking4]
FROM Team_Ability ta 
JOIN Team t 
ON ta.TeamID = t.TeamID ),
temp1 AS
(SELECT ROW_NUMBER() OVER(ORDER BY Overall) AS num, CAST(Name AS Varchar)+' '+CAST(Overall AS Varchar) AS "Overall"
FROM temp
WHERE Ranking1 <= 5),
temp2 AS
(SELECT ROW_NUMBER() OVER(ORDER BY Attack) AS num, CAST(Name AS Varchar)+' '+CAST(Attack AS Varchar) AS "Attack"
FROM temp
WHERE Ranking2 <= 5),
temp3 AS
(SELECT ROW_NUMBER() OVER(ORDER BY Midfield) AS num, CAST(Name AS Varchar)+' '+CAST(Midfield AS Varchar) AS "Midfield"
FROM temp
WHERE Ranking3 <= 5),
temp4 AS
(SELECT ROW_NUMBER() OVER(ORDER BY Defence) AS num, CAST(Name AS Varchar)+' '+CAST(Defence  AS Varchar) AS "Defence"
FROM temp
WHERE Ranking4 <= 5)
SELECT temp1.num,[Overall],[Attack],[Midfield],[Defence] 
FROM temp1
FULL JOIN temp2
ON temp1.num = temp2.num
FULL JOIN temp3
ON temp1.num = temp3.num
FULL JOIN temp4
ON temp1.num = temp4.num;

SELECT * FROM TeamRanking;

DROP VIEw TeamRanking

-- Create View 3
CREATE VIEW TopPlayer AS 
WITH temp AS
(SELECT p.PlayerID, PlayerFirstName + PlayerLastName AS [Name],Wage, BestPosition, ContractID, SUM(Pace+Shooting+Passing+Dribbling+Defending)/5 AS 'AVG',
       RANK() OVER (PARTITION BY BestPosition ORDER BY SUM(Pace+Shooting+Passing+Dribbling+Defending) DESC) AS ranking
FROM Player p
INNER JOIN [Professional Skills] ps
ON p.PlayerID = ps.PlayerID
WHERE BestPosition != 'GK'
GROUP BY p.PlayerID, PlayerFirstName, PlayerLastName,Wage, BestPosition, ContractID)
SELECT PlayerID,[Name],BestPosition,[AVG],Wage,ReleaseClause
FROM temp
INNER JOIN [Contract] c
ON temp.ContractID = c.ContractID
WHERE ranking = 1;

SELECT * FROM TopPlayer
ORDER BY Wage DESC

DROP VIEW TopPlayer

