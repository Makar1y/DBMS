-- 1. Persidengiančios aktyvios rezervacijos (triggeris)
DO $$
BEGIN
    INSERT INTO reservation (client_id, car_id, start_time, end_time)
    VALUES (1, 1, '2026-11-20 11:00', '2026-11-20 13:00');
    RAISE EXCEPTION 'TEST FAILED: persidengianti rezervacija buvo priimta';
EXCEPTION WHEN raise_exception THEN
    RAISE NOTICE 'OK: persidengianti aktyvi rezervacija atmesta';
END $$;

-- 2. Klientas neturi reikiamos kategorijos (triggeris)
DO $$
BEGIN
    INSERT INTO reservation (client_id, car_id, start_time, end_time)
    VALUES (2, 3, '2026-12-02 09:00', '2026-12-02 10:00');
    RAISE EXCEPTION 'TEST FAILED: rezervacija be reikiamos kategorijos buvo priimta';
EXCEPTION WHEN raise_exception THEN
    RAISE NOTICE 'OK: rezervacija be reikiamos kategorijos atmesta';
END $$;

-- 3. Persidengimas atnaujinant esamą rezervaciją (triggeris)
DO $$
BEGIN
    UPDATE reservation
       SET start_time = '2026-11-20 11:00',
           end_time   = '2026-11-20 13:00'
     WHERE id = 4;
    RAISE EXCEPTION 'TEST FAILED: persidengiantis UPDATE buvo priimtas';
EXCEPTION WHEN raise_exception THEN
    RAISE NOTICE 'OK: persidengiantis rezervacijos UPDATE atmestas';
END $$;
