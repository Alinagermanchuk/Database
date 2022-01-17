import psycopg2
import json


login_data = {
    "user": "postgres",
    "password": "Elem654",
    "dbname": "ex",
    "host": "localhost",
    "port": "5432"
}

tables = ["Developers", "Publishers", "Games",
          "SaleInfo", "GameGenre", "Genres"]

export = {}     # будем здесь хранить все данные, чтобы потом записать их в файл
with psycopg2.connect(**login_data) as con:
    cur = con.cursor()

    for table_name in tables:
        cur.execute(f"SELECT * FROM {table_name}")

        columns = [col[0] for col in cur.description]    # берём имена столбцов

        rows = []
        for row in cur:
            values = dict(zip(columns, row))
            rows.append(values)

        export[table_name] = rows

# здесь мы записываем наш словарь в виде json
with open("export\\database.json", "w") as f:
    json.dump(export, f)
