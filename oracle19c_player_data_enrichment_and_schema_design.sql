-- ============================================================
-- File: enrich_player_schema_and_relationships.sql
--
-- Purpose:
-- Incrementally enrich PLAYER data, add realistic attributes,
-- introduce supporting master tables, and model real-world
-- relationships using proper Oracle constraints.
--
-- Assumptions:
-- - Executed as application user (SDP)
-- - PLAYER table already exists with basic columns
-- - Required privileges (CREATE SEQUENCE, CREATE TABLE) granted
-- ============================================================


-- ============================================================
-- STEP 1: Enrich PLAYER table with real-world attributes
-- ============================================================

ALTER TABLE player ADD (
  country        VARCHAR2(50),
  date_of_birth  DATE,
  batting_style  VARCHAR2(20),
  role           VARCHAR2(30),
  debut_year     NUMBER(4),
  is_active      CHAR(1) CHECK (is_active IN ('Y','N'))
);

-- Table PLAYER altered.


-- ============================================================
-- STEP 2: Update existing players with enriched data
-- ============================================================

UPDATE player SET
  country = 'India',
  date_of_birth = DATE '1973-04-24',
  batting_style = 'Right-hand',
  role = 'Batsman',
  debut_year = 1989,
  is_active = 'N'
WHERE first_name = 'Sachin';

-- 1 row updated.

UPDATE player SET
  country = 'India',
  date_of_birth = DATE '1972-07-08',
  batting_style = 'Left-hand',
  role = 'Batsman',
  debut_year = 1992,
  is_active = 'N'
WHERE first_name = 'Sourav';

-- 1 row updated.

COMMIT;

-- Commit complete.


-- ============================================================
-- STEP 3: Create sequence for PLAYER_ID generation
-- ============================================================
-- PLAYER_ID values 1 and 2 already exist, so start with 3

CREATE SEQUENCE player_seq
START WITH 3
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence PLAYER_SEQ created.


-- Verify sequence existence
SELECT sequence_name FROM user_sequences;

-- Expected output:
-- PLAYER_SEQ


-- ============================================================
-- STEP 4: Insert additional players using sequence
-- ============================================================

INSERT INTO player VALUES (
  player_seq.NEXTVAL,
  'Virat',
  'Kohli',
  'CRICKET',
  'India',
  DATE '1988-11-05',
  'Right-hand',
  'Batsman',
  2008,
  'Y'
);

-- 1 row inserted.

INSERT INTO player VALUES (
  player_seq.NEXTVAL,
  'MS',
  'Dhoni',
  'CRICKET',
  'India',
  DATE '1981-07-07',
  'Right-hand',
  'Wicket-Keeper',
  2004,
  'N'
);

-- 1 row inserted.

COMMIT;

-- Commit complete.


-- ============================================================
-- STEP 5: Verify PLAYER data
-- ============================================================

SELECT player_id, first_name, last_name
FROM player
ORDER BY player_id;

-- Expected result:
-- 1 Sachin Tendulkar
-- 2 Sourav Ganguly
-- 3 Virat  Kohli
-- 4 MS     Dhoni


-- ============================================================
-- STEP 6: Create SPORT master table
-- ============================================================

CREATE TABLE sport (
  sport_id   NUMBER PRIMARY KEY,
  sport_name VARCHAR2(30) UNIQUE NOT NULL
);

-- Table SPORT created.

INSERT INTO sport VALUES (1, 'CRICKET');
INSERT INTO sport VALUES (2, 'FOOTBALL');

COMMIT;

-- Commit complete.


-- ============================================================
-- STEP 7: Create TEAM master table
-- ============================================================

CREATE TABLE team (
  team_id   NUMBER PRIMARY KEY,
  team_name VARCHAR2(50),
  country   VARCHAR2(50)
);

-- Table TEAM created.


-- ============================================================
-- STEP 8: Ensure PLAYER has a primary key
-- (Required for foreign key references)
-- ============================================================

ALTER TABLE player
ADD CONSTRAINT pk_player
PRIMARY KEY (player_id);

-- Table PLAYER altered.


-- ============================================================
-- STEP 9: Create PLAYER_TEAM mapping table
-- Models player-team association over time
-- ============================================================

CREATE TABLE player_team (
  player_id NUMBER NOT NULL,
  team_id   NUMBER NOT NULL,
  from_year NUMBER(4),
  to_year   NUMBER(4),
  CONSTRAINT fk_pt_player FOREIGN KEY (player_id)
    REFERENCES player(player_id),
  CONSTRAINT fk_pt_team FOREIGN KEY (team_id)
    REFERENCES team(team_id)
);

-- Table PLAYER_TEAM created.


-- ============================================================
-- STEP 10: Add composite primary key to PLAYER_TEAM
-- Prevents duplicate timeline entries
-- ============================================================

ALTER TABLE player_team
ADD CONSTRAINT pk_player_team
PRIMARY KEY (player_id, team_id, from_year);

-- Table PLAYER_TEAM altered.


-- ============================================================
-- STEP 11: Example real-world query
-- Active players ordered by debut year
-- ============================================================

SELECT first_name, last_name, debut_year
FROM player
WHERE is_active = 'Y'
ORDER BY debut_year;

-- End of script
-- ============================================================
