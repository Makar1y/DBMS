-- Kiekvienai duomenų bazės lentelei - konkretaus skaitinio tipo stulpelių skaičius.

SELECT Table_Schema, Table_Name, Data_Type, Count(*) AS "Stulpelių sk."
    FROM information_schema.columns

    WHERE Data_Type = 'integer'

    GROUP BY Table_Schema, Table_Name, Data_Type
    ORDER BY "Stulpelių sk." DESC