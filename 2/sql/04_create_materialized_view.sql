-- ---------------------------------------------------------------------
-- 4. Materializuotoji virtualioji lentelė
-- ---------------------------------------------------------------------

CREATE MATERIALIZED VIEW mv_car_reservation_stats AS
SELECT ca.id AS car_id,
       ca.registration_nr,
       ca.brand,
       ca.model,
       COUNT(r.id) AS total_reservations,
       COUNT(*) FILTER (WHERE r.status = 'active')    AS active_reservations,
       COUNT(*) FILTER (WHERE r.status = 'completed') AS completed_reservations,
       COUNT(*) FILTER (WHERE r.status = 'cancelled') AS cancelled_reservations,
       COUNT(*) FILTER (WHERE r.status = 'no_show')   AS no_show_reservations
FROM car ca
LEFT JOIN reservation r ON r.car_id = ca.id
GROUP BY ca.id, ca.registration_nr, ca.brand, ca.model;

-- Būtinas REFRESH MATERIALIZED VIEW CONCURRENTLY.
CREATE UNIQUE INDEX ux_mv_car_reservation_stats_car_id
    ON mv_car_reservation_stats (car_id);
