-- ---------------------------------------------------------------------
-- 3. Virtualiosios lentelės (views)
-- ---------------------------------------------------------------------

CREATE OR REPLACE VIEW v_active_reservations AS
SELECT r.id              AS reservation_id,
       c.id              AS client_id,
       c.name || ' ' || c.surname AS client_name,
       c.email           AS client_email,
       ca.id             AS car_id,
       ca.registration_nr,
       ca.brand,
       ca.model,
       r.start_time,
       r.end_time,
       r.status
FROM reservation r
JOIN client c ON c.id = r.client_id
JOIN car ca   ON ca.id = r.car_id
WHERE r.status = 'active';

CREATE OR REPLACE VIEW v_car_current_location AS
SELECT ca.id AS car_id,
       ca.registration_nr,
       ca.brand,
       ca.model,
       l.id AS location_id,
       l.name AS location_name,
       l.city,
       l.address,
       cl.from_time
    --    cl.to_time
FROM car ca
JOIN car_location cl ON cl.car_id = ca.id AND cl.to_time IS NULL
JOIN location l      ON l.id = cl.location_id;

CREATE OR REPLACE VIEW v_client_reservation_summary AS
SELECT c.id AS client_id,
       c.name,
       c.surname,
       c.email,
       COUNT(r.id) AS total_reservations,
       COUNT(*) FILTER (WHERE r.status = 'active')    AS active_reservations,
       COUNT(*) FILTER (WHERE r.status = 'completed') AS completed_reservations,
       COUNT(*) FILTER (WHERE r.status = 'cancelled') AS cancelled_reservations
FROM client c
LEFT JOIN reservation r ON r.client_id = c.id
GROUP BY c.id, c.name, c.surname, c.email;
