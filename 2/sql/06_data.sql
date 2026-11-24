BEGIN;

-- Klientai
INSERT INTO client (name, surname, email, phone, city, street, home_nr) VALUES
    ('Jonas',  'Jonaitis',  'jonas.jonaitis@example.com',  '+37060000001', 'Vilnius',  'Gedimino',  '1'),
    ('Ona',    'Onaitė',    'ona.onaite@example.com',      '+37060000002', 'Kaunas',   'Laisvės',   '2'),
    ('Petras', 'Petraitis', 'petras.petraitis@example.com', '+37060000003', 'Klaipėda', 'Baltijos',  '3');

-- Klientų vairuotojo pažymėjimo kategorijos
INSERT INTO client_category (client_id, category) VALUES
    (1, 'B'),
    (1, 'BE'),
    (2, 'B'),
    (3, 'B'),
    (3, 'C1');

-- Vietos
INSERT INTO location (name, city, address) VALUES
    ('Vilniaus centras',  'Vilnius',  'Gedimino pr. 10'),
    ('Kauno centras',     'Kaunas',   'Laisvės al. 20'),
    ('Klaipėdos centras', 'Klaipėda', 'Baltijos pr. 30');

-- Automobiliai
INSERT INTO car
    (required_category, registration_nr, brand, model, production_year, price, status)
VALUES
    ('B',  'AAA-001', 'Toyota', 'Corolla', 2020, 0.25, 'available'),
    ('B',  'BBB-002', 'BMW',    '320',     2021, 0.35, 'available'),
    ('C1', 'CCC-003', 'Ford',   'Transit', 2019, 0.40, 'available'),
    ('B',  'DDD-004', 'Tesla',  'Model 3', 2022, 0.50, 'maintenance');

-- Automobilių buvimo vietų istorija
INSERT INTO car_location (car_id, location_id, from_time, to_time) VALUES
    (1, 1, '2026-11-01 08:00', '2026-11-01 18:00'),
    (1, 2, '2026-11-01 18:00', NULL),
    (2, 1, '2026-11-01 08:00', NULL),
    (3, 2, '2026-11-02 09:00', NULL),
    (4, 3, '2026-11-01 07:00', NULL);

-- Rezervacijos
INSERT INTO reservation
    (client_id, car_id, start_time, end_time, status)
VALUES
    (1, 1, '2026-11-20 10:00', '2026-11-20 12:00', 'active'),
    (2, 2, '2026-11-20 10:00', '2026-11-20 12:00', 'active'),
    (3, 3, '2026-11-21 09:00', '2026-11-21 17:00', 'active'),
    (1, 1, '2026-11-21 10:00', '2026-11-21 12:00', 'active'),
    (2, 2, '2026-11-21 10:00', '2026-11-21 12:00', 'cancelled'),
    (1, 2, '2026-11-10 09:00', '2026-11-10 11:00', 'completed'),
    (3, 3, '2026-11-12 09:00', '2026-11-12 17:00', 'cancelled');

COMMIT;

-- Materializuotosios lentelės duomenų atnaujinimo sakinys.
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_car_reservation_stats;
