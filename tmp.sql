Select *

    FROM Stud.Knyga 
    JOIN Stud.Autorius ON Autorius.ISBN = Knyga.ISBN
    JOIN Stud.Egzempliorius ON Knyga.ISBN = Egzempliorius.ISBN

    WHERE Pavarde = 'Petraitis' AND Vardas = 'Jonas'
