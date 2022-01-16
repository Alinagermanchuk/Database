import psycopg2

login_data = {
    "user": "postgres",         # логин
    "password": "Elem654",    # пароль
    "dbname": "ex",
    "host": "localhost",
    "port": "5432"
}


# Информация про логин передаётся в качестве kwargs:
with psycopg2.connect(**login_data) as con:
    # с помощью курсора мы выполняем запросы и извлекаем результаты
    cur = con.cursor()

    with open("create.sql", "r") as f:
        text = f.read()
        cur.execute(text)

    with open("populate.sql", "r") as f:
        text = f.read()
        cur.execute(text)

    with open("query.sql", "r") as f:
        # Поскольку мы хотим выполнять команды последовательно,
        # нам нужно в 'query.sql' обязательно разделить запросы точкой с запятой.
        # А в коде мы читаем этот файл полностью. Разделяем команды
        # с помощью split(";"). Далее проводим итерацию по списку команд
        # и выполняем их, выводя результат в консоль.

        text = f.read()
        commands = text.split(";")
        for com in commands:
            cur.execute(com)    # вот тут мы выполняем запрос
            print("###############> execute:")
            print(com)
            print("<############### returned:")
            values = cur.fetchall()  # извлекаем все результирующие строки
            for row in values:
                print(row)
