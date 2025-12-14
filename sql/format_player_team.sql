-- ============================================================
-- File: format_player_team.sql
-- Purpose: SQL*Plus formatting for PLAYER_TEAM mapping table
-- ============================================================

SET LINESIZE 200
SET PAGESIZE 50
SET TRIMSPOOL ON
SET TAB OFF

COLUMN player_id FORMAT 9999  HEADING "PLAYER"
COLUMN team_id   FORMAT 9999  HEADING "TEAM"
COLUMN from_year FORMAT 9999  HEADING "FROM"
COLUMN to_year   FORMAT 9999  HEADING "TO"

-- Example usage:
-- SELECT * FROM player_team;

-- ============================================================
