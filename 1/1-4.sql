-- Vardas ir pavardė autoriaus, kurio knygų egzempliorių bibliotekoje yra daugiausiai.
-- Greta pateikti ir to autoriaus visų knygų bei visų egzempliorių skaičius.

WITH max AS (
    Select Vardas, Pavarde,
    COUNT(DISTINCT Knyga.ISBN) AS "Knygu sk.",
    COUNT(Egzempliorius.Nr) AS "Egzemplioriu sk.",
    COUNT(Knyga.Leidykla)

    FROM Stud.Autorius 
    JOIN Stud.Knyga ON Autorius.ISBN = Knyga.ISBN
    LEFT OUTER JOIN Stud.Egzempliorius ON Autorius.ISBN = Egzempliorius.ISBN
    GROUP BY Vardas, Pavarde
), max2 AS (
    SELECT MAX("Egzemplioriu sk.") as "Egzemplioriu sk. maks." from max
)

Select * FROM max, max2
WHERE "Egzemplioriu sk." < "Egzemplioriu sk. maks."