import psycopg2
import csv


login_data = {
    "user": "postgres",
    "password": "Elem654",
    "dbname": "ex",
    "host": "localhost",
    "port": "5432"
}

tables = ["Developers", "Publishers", "Games",
          "SaleInfo", "GameGenre", "Genres"]

with psycopg2.connect(**login_data) as con:
    cur = con.cursor()

    for table_name in tables:
        cur.execute(f"SELECT * FROM {table_name}")

        columns = [col[0] for col in cur.description]    # берём имена столбцов

        with open(f"export\\{table_name}.csv", "w", newline='') as f:
            writer = csv.writer(f)
            writer.writerow(columns)
            for row in cur:
                writer.writerow(row)
