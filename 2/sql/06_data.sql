BEGIN;

-- Klientai
INSERT INTO client (id, name, surname, email, phone, city, street, home_nr) VALUES
    (1, 'Jonas',  'Jonaitis',  'jonas.jonaitis@example.com',  '+37060000001', 'Vilnius',  'Gedimino',  '1'),
    (2, 'Ona',    'Onaitė',    'ona.onaite@example.com',      '+37060000002', 'Kaunas',   'Laisvės',   '2'),
    (3, 'Petras', 'Petraitis', 'petras.petraitis@example.com', '+37060000003', 'Klaipėda', 'Baltijos',  '3');

-- Klientų vairuotojo pažymėjimo kategorijos (daugiareikšmis atributas)
INSERT INTO client_category (client_id, category) VALUES
    (1, 'B'),
    (1, 'BE'),
    (2, 'B'),
    (3, 'B'),
    (3, 'C1');

-- Stovėjimo / nuomos vietos
INSERT INTO location (id, name, city, address) VALUES
    (1, 'Vilniaus centras',  'Vilnius',  'Gedimino pr. 10'),
    (2, 'Kauno centras',     'Kaunas',   'Laisvės al. 20'),
    (3, 'Klaipėdos centras', 'Klaipėda', 'Baltijos pr. 30');

-- Automobiliai
INSERT INTO car
    (id, required_category, registration_nr, brand, model, production_year, price, status)
VALUES
    (1, 'B',  'AAA-001', 'Toyota', 'Corolla', 2020, 0.25, 'available'),
    (2, 'B',  'BBB-002', 'BMW',    '320',     2021, 0.35, 'available'),
    (3, 'C1', 'CCC-003', 'Ford',   'Transit', 2019, 0.40, 'available'),
    (4, 'B',  'DDD-004', 'Tesla',  'Model 3', 2022, 0.50, 'maintenance');

-- Automobilių buvimo vietų istorija
INSERT INTO car_location (car_id, location_id, from_time, to_time) VALUES
    (1, 1, '2026-11-01 08:00', '2026-11-01 18:00'),
    (1, 2, '2026-11-01 18:00', NULL),
    (2, 1, '2026-11-01 08:00', NULL),
    (3, 2, '2026-11-02 09:00', NULL),
    (4, 3, '2026-11-01 07:00', NULL);

-- Rezervacijos
INSERT INTO reservation
    (id, client_id, car_id, start_time, end_time, status)
VALUES
    (1, 1, 1, '2026-11-20 10:00', '2026-11-20 12:00', 'active'),
    (2, 2, 2, '2026-11-20 10:00', '2026-11-20 12:00', 'active'),
    (3, 3, 3, '2026-11-21 09:00', '2026-11-21 17:00', 'active'),
    (4, 1, 1, '2026-11-21 10:00', '2026-11-21 12:00', 'active'),
    (5, 2, 2, '2026-11-21 10:00', '2026-11-21 12:00', 'cancelled'),
    (6, 1, 2, '2026-11-10 09:00', '2026-11-10 11:00', 'completed'),
    (7, 3, 3, '2026-11-12 09:00', '2026-11-12 17:00', 'no_show');

-- Kad vėliau įterpiant be ID nebūtų konflikto su identity sekomis.
SELECT setval(pg_get_serial_sequence('client', 'id'), (SELECT max(id) FROM client), true);
SELECT setval(pg_get_serial_sequence('car', 'id'), (SELECT max(id) FROM car), true);
SELECT setval(pg_get_serial_sequence('location', 'id'), (SELECT max(id) FROM location), true);
SELECT setval(pg_get_serial_sequence('reservation', 'id'), (SELECT max(id) FROM reservation), true);

COMMIT;

-- Materializuotosios lentelės duomenų atnaujinimo sakinys.
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_car_reservation_stats;
