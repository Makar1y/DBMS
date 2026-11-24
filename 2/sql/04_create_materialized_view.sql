-- ---------------------------------------------------------------------
-- 4. Materializuotoji virtualioji lentelė
-- ---------------------------------------------------------------------

CREATE MATERIALIZED VIEW mv_car_reservation_stats AS
SELECT car.id AS car_id,
       car.registration_nr,
       car.brand,
       car.model,
       COUNT(r.id) AS total_reservations,
       COUNT(*) FILTER (WHERE r.status = 'active')    AS active_reservations,
       COUNT(*) FILTER (WHERE r.status = 'completed') AS completed_reservations,
       COUNT(*) FILTER (WHERE r.status = 'cancelled') AS cancelled_reservations
FROM car
LEFT JOIN reservation r ON r.car_id = car.id
GROUP BY car.id, car.registration_nr, car.brand, car.model;

-- CONCURRENTLY requirement 
CREATE UNIQUE INDEX uix_mv_car_reservation_stats_car_id
    ON mv_car_reservation_stats (car_id);