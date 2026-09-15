-- Konkrečioje leidykloje išleistų knygų visų autorių vardai ir jų pavardės.

-- SELECT Vardas, Pavarde 
-- FROM stud.Autorius JOIN stud.Knyga ON Autorius.ISBN = Knyga.ISBN
-- GROUP BY Vardas, Pavarde

SELECT DISTINCT Vardas, Pavarde 
FROM stud.Autorius JOIN stud.Knyga ON Autorius.ISBN = Knyga.ISBN


-- WHERE Skaitymas.Grazinta IS NULL
--     AND Skaitymas.Grazinti < DATE '2025-01-01'