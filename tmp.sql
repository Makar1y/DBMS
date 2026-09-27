SELECT Table_Schema, Table_Name, Data_Type
    FROM information_schema.columns

    GROUP BY Table_Schema, Table_Name, Data_Type