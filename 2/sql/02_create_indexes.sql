-- ---------------------------------------------------------------------
-- 2. Indeksai
--    Bent vienas unikalus ir bent vienas neunikalus.
-- ---------------------------------------------------------------------

-- Unikalus, kiekį nepriklausantis nuo didžiųjų/mažųjų raidžių.
CREATE UNIQUE INDEX ux_client_email_lower
    ON client (lower(email));

-- Neunikalūs indeksai, naudojami paieškai ir trigerių patikroms.
CREATE INDEX ix_reservation_car_start
    ON reservation (car_id, start_time);

CREATE INDEX ix_reservation_client_start
    ON reservation (client_id, start_time);

CREATE INDEX ix_car_location_location_time
    ON car_location (location_id, from_time);
