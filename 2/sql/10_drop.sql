-- Indeksai (materializuotosios lentelės indeksas — prieš pat lentelę)
DROP INDEX IF EXISTS uix_mv_car_reservation_stats_car_id;
DROP INDEX IF EXISTS uix_client_email_lower;
DROP INDEX IF EXISTS ix_reservation_car_start;
DROP INDEX IF EXISTS ix_reservation_client_start;
DROP INDEX IF EXISTS ix_car_location_location_time;

-- Virtualiosios lentelės
DROP MATERIALIZED VIEW IF EXISTS mv_car_reservation_stats CASCADE;
DROP VIEW IF EXISTS v_active_reservations CASCADE;
DROP VIEW IF EXISTS v_car_current_location CASCADE;
DROP VIEW IF EXISTS v_client_reservation_summary CASCADE;

-- Triggiai (aiškiai, prieš ištrinant lenteles; saugu ir kartojant)
DROP TRIGGER IF EXISTS trg_reservation_no_overlap ON reservation;
DROP TRIGGER IF EXISTS trg_reservation_category ON reservation;

-- Lentelės
DROP TABLE IF EXISTS car_location CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;
DROP TABLE IF EXISTS client_category CASCADE;
DROP TABLE IF EXISTS car CASCADE;
DROP TABLE IF EXISTS location CASCADE;
DROP TABLE IF EXISTS client CASCADE;

-- Trigerių funkcijos
DROP FUNCTION IF EXISTS fn_reservation_no_overlap() CASCADE;
DROP FUNCTION IF EXISTS fn_reservation_category() CASCADE;
