-- Kiekvienai leidyklai skaičius skaitytojų, skaitančių bent vieną joje išleistą knygą.

SELECT Leidykla, COUNT(DISTINCT Vardas||','||Pavarde) as "Skaitytoju sk." FROM stud.Skaitytojas 
    JOIN stud.Skaitymas ON Skaitymas.Skaitytojas = Skaitytojas.Nr
    JOIN stud.Egzempliorius ON Skaitymas.Egzempliorius = Egzempliorius.Nr
    JOIN stud.Knyga ON Egzempliorius.ISBN = Knyga.ISBN
    WHERE Grazinta IS NULL
    GROUP BY Leidykla