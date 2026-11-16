-- ---------------------------------------------------------------------
-- 5. Dalykinės taisyklės trigeriais
-- ---------------------------------------------------------------------

-- 5.1. Vieno automobilio aktyvios rezervacijos negali persidengti.
CREATE OR REPLACE FUNCTION fn_reservation_no_overlap()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.status <> 'active' THEN
        RETURN NEW;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM reservation r
        WHERE r.car_id = NEW.car_id
          AND r.status = 'active'
          AND r.id <> COALESCE(NEW.id, -1)
          AND NEW.start_time < r.end_time
          AND NEW.end_time > r.start_time
    ) THEN
        RAISE EXCEPTION
            'Automobilis % jau turi aktyvią rezervaciją, persidengiančią su [%, %)',
            NEW.car_id, NEW.start_time, NEW.end_time
            USING ERRCODE = 'P0001';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_reservation_no_overlap
BEFORE INSERT OR UPDATE OF car_id, start_time, end_time, status
ON reservation
FOR EACH ROW
EXECUTE FUNCTION fn_reservation_no_overlap();

-- 5.2. Klientas gali rezervuoti tik tos kategorijos automobilį,
--      kurios vairuotojo pažymėjimo kategoriją jis turi.
CREATE OR REPLACE FUNCTION fn_reservation_category()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_required_category varchar(5);
BEGIN
    SELECT c.required_category
      INTO v_required_category
      FROM car c
     WHERE c.id = NEW.car_id;

    IF v_required_category IS NULL THEN
        RAISE EXCEPTION 'Automobilis % neegzistuoja', NEW.car_id
            USING ERRCODE = '23503';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM client_category cc
        WHERE cc.client_id = NEW.client_id
          AND cc.category = v_required_category
    ) THEN
        RAISE EXCEPTION
            'Klientas % neturi reikalingos % kategorijos automobiliui %',
            NEW.client_id, v_required_category, NEW.car_id
            USING ERRCODE = 'P0001';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_reservation_category
BEFORE INSERT OR UPDATE OF client_id, car_id
ON reservation
FOR EACH ROW
EXECUTE FUNCTION fn_reservation_category();
