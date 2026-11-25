-- 1. Persidengiančios aktyvios rezervacijos
DO $$
BEGIN
    INSERT INTO reservation (client_id, car_id, start_time, end_time)
    VALUES (1, 1, '2026-11-20 11:00', '2026-11-20 13:00');
    RAISE EXCEPTION 'TEST FAILED: persidengianti rezervacija buvo priimta';
EXCEPTION WHEN SQLSTATE 'E0001' THEN
    RAISE NOTICE 'OK!';
END $$;

-- 2. Klientas neturi reikiamos kategorijos
DO $$
BEGIN
    INSERT INTO reservation (client_id, car_id, start_time, end_time)
    VALUES (2, 3, '2026-12-02 09:00', '2026-12-02 10:00');
    RAISE EXCEPTION 'TEST FAILED: rezervacija be reikiamos kategorijos buvo priimta';
EXCEPTION WHEN SQLSTATE 'E0003' THEN
    RAISE NOTICE 'OK!';
END $$;

-- 3. Persidengimas atnaujinant esamą rezervaciją
DO $$
BEGIN
    UPDATE reservation
       SET start_time = '2026-11-20 11:00',
           end_time   = '2026-11-20 13:00'
     WHERE id = 4;
    RAISE EXCEPTION 'TEST FAILED: persidengiantis UPDATE buvo priimtas';
EXCEPTION WHEN SQLSTATE 'E0001' THEN
    RAISE NOTICE 'OK!';
END $$;
