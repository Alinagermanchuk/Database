import psycopg2
import csv


login_data = {
    "user": "postgres",
    "password": "Elem654",
    "dbname": "ex",
    "host": "localhost",
    "port": "5432"
}

# ------------------ Импортируем данные из csv
path = "import\Games.csv"
content = []
with open(path, "r") as f:         # открываем csv файл
    reader = csv.DictReader(f)     # читаем его как словари
    for row in reader:
        content.append(row)

for row in content:
    for key, value in row.items():
        value = value.replace("'", "''")
        if value == "":
            value = ["NULL"]
            row[key] = value
            continue

        sep = [", ", " / "]
        if sep[0] in value and '"' not in value:
            value = value.split(sep[0])
            row[key] = value
        elif sep[1] in value:
            value = value.split(sep[1])
            row[key] = value
        else:
            row[key] = [value]
    # print(row)


# ------------------ Распаковываем по отдельным переменным
def unpack(col_name):
    _rows = [r[col_name] for r in content]
    unpacked = []
    for x in _rows:
        if isinstance(x, str):
            unpacked.append(x)
        else:
            for _x in x:
                unpacked.append(_x)
    unpacked = list(set(unpacked))
    return unpacked


developers = {i: val for i, val in enumerate(unpack("Developer"))}  # {title: dev_id}
dev_ids = {val: i for i, val in developers.items()}       # а тут наоборот {dev_id: title}
publishers = {i: val for i, val in enumerate(unpack("Publisher"))}
pub_ids = {val: i for i, val in publishers.items()}
genres = {i: val for i, val in enumerate(unpack("Genre"))}
gen_ids = {val: i for i, val in genres.items()}

insert_queries = {
    "Developers": "INSERT INTO developers (dev_id, title) VALUES (%s, '%s')",
    "Publishers": "INSERT INTO publishers (publisher_id, title) VALUES (%s, '%s')",
    "SaleInfo": "INSERT INTO saleinfo (game_id, sales) VALUES (%s, '%s')",
    "Genres": "INSERT INTO genres (genre_id, title) VALUES (%s, '%s')",
    "GameGenre": "INSERT INTO gamegenre (game_id, genre_id) VALUES (%s, %s)",
    "Games": "INSERT INTO games (game_id, dev_id, publisher_id, title, release_date) VALUES (%s, %s, %s, '%s', '%s')"
}

with psycopg2.connect(**login_data) as con:
    cursor = con.cursor()

    # удалить прошлые значения
    cursor.execute("""
        DELETE FROM GameGenre;
        DELETE FROM Genres;
        DELETE FROM Games;
        DELETE FROM Developers;
        DELETE FROM Publishers;
        DELETE FROM SaleInfo;""")

    # заполняем дев, паблишеров и жанры
    for i, dev in developers.items():
        cursor.execute(insert_queries["Developers"] % (i, dev))
    for i, pub in publishers.items():
        cursor.execute(insert_queries["Publishers"] % (i, pub))
    for i, gen in genres.items():
        cursor.execute(insert_queries["Genres"] % (i, gen))

    game_ids = {}
    # тут заполняем таблицу Games
    for i, row in enumerate(content):
        dev_id = dev_ids.get(row["Developer"][0], "NULL")
        pub_id = pub_ids.get(row["Publisher"][0], "NULL")
        title = row["Name"][0]
        release = row["Release"][0]
        genre_ids = [gen_ids.get(x, "NULL") for x in row["Genre"]]
        # if i == 0:
        #     print(row["Genre"])
        #     print([gen_ids.get(x, "NULL") for x in row["Genre"]])
        sales = row["Sales"][0]

        # сохраняем на будущее
        game_data = {"game_id": i, "dev_id": dev_id, "publisher_id": pub_id, "genre_ids": genre_ids, "sales": sales}
        game_ids[i] = game_data

        cursor.execute(insert_queries["Games"] % (i, dev_id, pub_id, title, release))

    # теперь используем game_ids для заполнения следующих таблиц
    for _id, data in game_ids.items():
        game_id = data["game_id"]
        sales = data["sales"]
        cursor.execute(insert_queries["SaleInfo"] % (game_id, sales))

        genre_ids = data["genre_ids"]
        for gen_id in genre_ids:
            cursor.execute(insert_queries["GameGenre"] % (game_id, gen_id))
