-- 1. Virtualiųjų lentelių patikra
\echo '--- v_active_reservations ---'
SELECT reservation_id, client_name, registration_nr, start_time, end_time
FROM v_active_reservations
ORDER BY start_time, reservation_id;

\echo '--- v_car_current_location ---'
SELECT car_id, registration_nr, location_name, city, from_time
FROM v_car_current_location
ORDER BY car_id;

\echo '--- v_client_reservation_summary ---'
SELECT client_id, name, surname, total_reservations,
       active_reservations, completed_reservations,
       cancelled_reservations
FROM v_client_reservation_summary
ORDER BY client_id;

-- 2. Materializuotosios lentelės atnaujinimas ir patikra
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_car_reservation_stats;

\echo '--- mv_car_reservation_stats ---'
SELECT car_id, registration_nr, total_reservations,
       active_reservations, completed_reservations,
       cancelled_reservations
FROM mv_car_reservation_stats
ORDER BY car_id;
