-- Vardas ir pavardė autoriaus, kurio knygų egzempliorių bibliotekoje yra daugiausiai.
-- Greta pateikti ir to autoriaus visų knygų bei visų egzempliorių skaičius.

Select Vardas, Pavarde,
    COUNT(DISTINCT Knyga.ISBN) AS "Knygu sk.",
    COUNT(Egzempliorius.Nr) AS "Egzemplioriu sk."

    FROM Stud.Autorius 
    JOIN Stud.Knyga ON Autorius.ISBN = Knyga.ISBN
    LEFT OUTER JOIN Stud.Egzempliorius ON Autorius.ISBN = Egzempliorius.ISBN

    GROUP BY Vardas, Pavarde
    ORDER BY COUNT(Egzempliorius.Nr) DESC, COUNT(DISTINCT Knyga.ISBN) DESC
    LIMIT 1
