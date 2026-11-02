-- Visų skaitytojų, kuriems reikia grąžinti paimtus egzempliorius iki konkrečios datos, skaičius

SELECT COUNT(DISTINCT skaitytojas) AS "Skaitytoju sk." FROM Stud.Skaitymas
WHERE Stud.Skaitymas.Grazinta IS NULL
    AND Stud.Skaitymas.Grazinti < DATE '2025-01-01'