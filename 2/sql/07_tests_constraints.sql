-- 1. Neteisingas el. pašto formatas
DO $$
BEGIN
    INSERT INTO client (name, surname, email)
    VALUES ('Test', 'Email', 'not-an-email');
    RAISE EXCEPTION 'TEST FAILED: neteisingas el. paštas buvo priimtas';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 2. El. pašto unikalumas nepriklausomai nuo raidžių
DO $$
BEGIN
    INSERT INTO client (name, surname, email)
    VALUES ('Test', 'Duplicate', 'JONAS.JONAITIS@EXAMPLE.COM');
    RAISE EXCEPTION 'TEST FAILED: pasikartojantis el. paštas buvo priimtas';
EXCEPTION WHEN unique_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 3. Neigiama kaina
DO $$
BEGIN
    INSERT INTO car
        (required_category, registration_nr, brand, model, production_year, price)
    VALUES
        ('B', 'TST-001', 'Test', 'Bad price', 2020, -1);
    RAISE EXCEPTION 'TEST FAILED: neigiama kaina buvo priimta';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 4. Neteisinga automobilio būsena
DO $$
BEGIN
    INSERT INTO car
        (required_category, registration_nr, brand, model, production_year, price, status)
    VALUES
        ('B', 'TST-002', 'Test', 'Bad status', 2020, 10, 'unknown');
    RAISE EXCEPTION 'TEST FAILED: neteisinga automobilio būsena buvo priimta';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 5. Rezervacijos pabaiga anksčiau už pradžią
DO $$
BEGIN
    INSERT INTO reservation (client_id, car_id, start_time, end_time)
    VALUES (1, 1, '2026-12-01 10:00', '2026-12-01 09:00');
    RAISE EXCEPTION 'TEST FAILED: neteisingas rezervacijos laikotarpis buvo priimtas';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 6. Neteisingas buvimo vietos laikotarpis
DO $$
BEGIN
    INSERT INTO car_location (car_id, location_id, from_time, to_time)
    VALUES (1, 1, '2026-12-03 10:00', '2026-12-03 09:00');
    RAISE EXCEPTION 'TEST FAILED: neteisingas car_location laikotarpis buvo priimtas';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 7. Pasikartojantis daugiareikšmio atributo įrašas
DO $$
BEGIN
    INSERT INTO client_category (client_id, category)
    VALUES (1, 'B');
    RAISE EXCEPTION 'TEST FAILED: pasikartojanti kategorija buvo priimta';
EXCEPTION WHEN unique_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 8. Neegzistuojantis klientas
DO $$
BEGIN
    INSERT INTO client_category (client_id, category)
    VALUES (999, 'B');
    RAISE EXCEPTION 'TEST FAILED: neegzistuojantis klientas buvo priimtas';
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 9. Privalomas laukas negali būti NULL
DO $$
BEGIN
    INSERT INTO client (name, surname, email)
    VALUES ('Test', 'Null', NULL);
    RAISE EXCEPTION 'TEST FAILED: NULL el. paštas buvo priimtas';
EXCEPTION WHEN not_null_violation THEN
    RAISE NOTICE 'OK!';
END $$;

-- 10. Numatytosios reikšmės
DO $$
DECLARE
    v_car_id integer;
    v_status varchar(20);
BEGIN
    INSERT INTO car
        (required_category, registration_nr, brand, model, production_year, price)
    VALUES
        ('B', 'TST-003', 'Test', 'Default car', 2020, 0.20)
    RETURNING id, status INTO v_car_id, v_status;

    IF v_status <> 'available' THEN
        RAISE EXCEPTION 'TEST FAILED: car.status numatytoji reikšmė yra %', v_status;
    END IF;

    RAISE NOTICE 'OK!';
    DELETE FROM car WHERE id = v_car_id;
END $$;

DO $$
DECLARE
    v_reservation_id integer;
    v_status varchar(20);
BEGIN
    INSERT INTO reservation (client_id, car_id, start_time, end_time)
    VALUES (1, 1, '2026-12-15 10:00', '2026-12-15 11:00')
    RETURNING id, status INTO v_reservation_id, v_status;

    IF v_status <> 'active' THEN
        RAISE EXCEPTION 'TEST FAILED: reservation.status numatytoji reikšmė yra %', v_status;
    END IF;

    RAISE NOTICE 'OK!';
    DELETE FROM reservation WHERE id = v_reservation_id;
END $$;
