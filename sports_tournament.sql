-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: sports_tournament
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table coach
--

DROP TABLE IF EXISTS coach;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE coach (
  coach_id int NOT NULL,
  team_id int DEFAULT NULL,
  name varchar(20) DEFAULT NULL,
  age int DEFAULT NULL,
  PRIMARY KEY (coach_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table coach
--

LOCK TABLES coach WRITE;
/*!40000 ALTER TABLE coach DISABLE KEYS */;
INSERT INTO coach VALUES (1,1,'Tom Coach',45),(2,2,'Anna Manager',50),(3,3,'Ella Coach',42),(4,4,'Liam Manager',38),(5,5,'Maya Manager',47),(6,1,'Gary Assistant',33),(7,2,'Steve Assistant',39),(8,3,'Linda Assistant',41),(9,4,'Paul Assistant',37),(10,5,'Nina Assistant',36);
/*!40000 ALTER TABLE coach ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table game
--

DROP TABLE IF EXISTS game;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE game (
  game_name varchar(20) NOT NULL,
  game_id int NOT NULL,
  team_1 int DEFAULT NULL,
  team_2 int DEFAULT NULL,
  date date DEFAULT NULL,
  location varchar(20) DEFAULT NULL,
  PRIMARY KEY (game_name,game_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table game
--

LOCK TABLES game WRITE;
/*!40000 ALTER TABLE game DISABLE KEYS */;
INSERT INTO game VALUES ('Baseball',5,NULL,NULL,'2024-11-05','Stadium E'),('Basketball',2,NULL,NULL,'2024-11-02','Court B'),('Cricket',3,NULL,NULL,'2024-11-03','Ground C'),('Hockey',4,NULL,NULL,'2024-11-04','Rink D'),('Soccer',1,NULL,NULL,'2024-11-01','Field A');
/*!40000 ALTER TABLE game ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table manager
--

DROP TABLE IF EXISTS manager;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE manager (
  manager_name varchar(20) NOT NULL,
  years_with_team int DEFAULT NULL,
  PRIMARY KEY (manager_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table manager
--

LOCK TABLES manager WRITE;
/*!40000 ALTER TABLE manager DISABLE KEYS */;
INSERT INTO manager VALUES ('Anna Manager',5),('Ella Coach',8),('Gary Assistant',2),('Liam Manager',6),('Linda Assistant',4),('Maya Manager',7),('Nina Assistant',1),('Paul Assistant',5),('Steve Assistant',3),('Tom Coach',10);
/*!40000 ALTER TABLE manager ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table merch
--

DROP TABLE IF EXISTS merch;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE merch (
  merch_name varchar(20) NOT NULL,
  price int NOT NULL,
  PRIMARY KEY (merch_name,price)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table merch
--

LOCK TABLES merch WRITE;
/*!40000 ALTER TABLE merch DISABLE KEYS */;
INSERT INTO merch VALUES ('Bag H',25),('Cap B',20),('Hoodie E',30),('Jersey A',50),('Keychain F',5),('Mug D',10),('Poster G',7),('Scarf C',15),('Socks I',8),('Wristband J',12);
/*!40000 ALTER TABLE merch ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table players
--

DROP TABLE IF EXISTS players;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE players (
  player_id int NOT NULL,
  name varchar(20) DEFAULT NULL,
  team_id int DEFAULT NULL,
  age int DEFAULT NULL,
  PRIMARY KEY (player_id),
  KEY team_id (team_id),
  CONSTRAINT players_ibfk_1 FOREIGN KEY (team_id) REFERENCES teams (team_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table players
--

LOCK TABLES players WRITE;
/*!40000 ALTER TABLE players DISABLE KEYS */;
INSERT INTO players VALUES (1,'Alice Smith',1,25),(2,'Bob Johnson',1,28),(3,'Charlie Lee',2,22),(4,'Diana Wang',2,26),(5,'Evan Thomas',3,24),(6,'Fiona Green',3,27),(7,'George Harris',4,29),(8,'Hannah Brown',4,23),(9,'Ian White',5,30),(10,'Jack Black',5,21);
/*!40000 ALTER TABLE players ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table score
--

DROP TABLE IF EXISTS score;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE score (
  team1_score int DEFAULT NULL,
  team2_score int DEFAULT NULL,
  match_id int NOT NULL,
  game_name varchar(20) DEFAULT NULL,
  PRIMARY KEY (match_id),
  KEY game_name (game_name),
  CONSTRAINT score_ibfk_1 FOREIGN KEY (game_name) REFERENCES game (game_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table score
--

LOCK TABLES score WRITE;
/*!40000 ALTER TABLE score DISABLE KEYS */;
INSERT INTO score VALUES (3,1,1,'Soccer'),(90,85,2,'Basketball'),(200,150,3,'Cricket'),(2,3,4,'Hockey'),(5,4,5,'Baseball');
/*!40000 ALTER TABLE score ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table teams
--

DROP TABLE IF EXISTS teams;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE teams (
  team_id int NOT NULL,
  team_name varchar(20) DEFAULT NULL,
  home_ground varchar(20) DEFAULT NULL,
  team_captain int DEFAULT NULL,
  coach_id int DEFAULT NULL,
  game_name varchar(20) DEFAULT NULL,
  manager varchar(20) DEFAULT NULL,
  team_merch varchar(20) DEFAULT NULL,
  PRIMARY KEY (team_id),
  KEY coach_id (coach_id),
  KEY team_captain (team_captain),
  KEY next_game (game_name),
  KEY manager (manager),
  KEY team_merch (team_merch),
  CONSTRAINT teams_ibfk_1 FOREIGN KEY (coach_id) REFERENCES coach (coach_id),
  CONSTRAINT teams_ibfk_2 FOREIGN KEY (team_captain) REFERENCES players (player_id),
  CONSTRAINT teams_ibfk_3 FOREIGN KEY (game_name) REFERENCES game (game_name),
  CONSTRAINT teams_ibfk_4 FOREIGN KEY (manager) REFERENCES manager (manager_name),
  CONSTRAINT teams_ibfk_5 FOREIGN KEY (team_merch) REFERENCES merch (merch_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table teams
--

LOCK TABLES teams WRITE;
/*!40000 ALTER TABLE teams DISABLE KEYS */;
INSERT INTO teams VALUES (1,'Warriors','Stadium A',NULL,1,'Soccer','Tom Coach','Jersey A'),(2,'Knights','Stadium B',NULL,2,'Basketball','Anna Manager','Cap B'),(3,'Dragons','Stadium C',NULL,3,'Cricket','Ella Coach','Scarf C'),(4,'Tigers','Stadium D',NULL,4,'Hockey','Liam Manager','Mug D'),(5,'Eagles','Stadium E',NULL,5,'Baseball','Maya Manager','Hoodie E');
/*!40000 ALTER TABLE teams ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-08 21:55:36
-- 
DELIMITER $$

CREATE FUNCTION get_tournament_status(starting_date DATE, end_date DATE)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE status VARCHAR(20);
    DECLARE today DATE;

    -- Get today's date
    SET today = CURDATE();

    -- Compare today's date with the start and end dates to determine the status
    IF today < starting_date THEN
        SET status = 'Upcoming'; -- Tournament hasn't started yet
    ELSEIF today > end_date THEN
        SET status = 'Completed'; -- Tournament has ended
    ELSE
        SET status = 'Ongoing'; -- Tournament is currently ongoing
    END IF;

    RETURN status;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE validate_tournament_dates(
    IN p_tournament_name VARCHAR(255),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    -- Validate that the end date is not before the start date
    IF p_end_date < p_start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'End date must be on or after start date';
    END IF;

    -- Insert the tournament record if validation passes
    INSERT INTO tournaments (tournament_name, start_date, end_date)
    VALUES (p_tournament_name, p_start_date, p_end_date);
    
END $$

DELIMITER ;