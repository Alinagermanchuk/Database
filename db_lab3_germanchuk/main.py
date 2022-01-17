import psycopg2
import matplotlib.pyplot as plt


login_data = {
    "user": "postgres",         
    "password": "Elem654",
    "dbname": "ex",
    "host": "localhost",
    "port": "5432"
}


def execute(cursor, query):
    cursor.execute(query)
    values = cursor.fetchall()
    return values


with psycopg2.connect(**login_data) as con:

    cur = con.cursor()

    with open("view.sql", "r") as f:
        text = f.read()
        cur.execute(text)

    # 6а: гра - продажі
    values = execute(cur, "SELECT * FROM game_sale")

    plt.title("Гра - Продажі")
    plt.bar([v[0] for v in values], [v[1] for v in values])
    plt.xticks(rotation=90)
    plt.ylabel("sales (million dollars)")
    plt.tight_layout()
    plt.savefig("img/6a.png")
    plt.show()

    # 6б: найпопулярніші жанри
    plt.title("Найпопулярніші жанри")
    values = execute(cur, "SELECT * FROM popular_genre")
    xs = [v[1] for v in values]
    plt.pie(x=xs, autopct=lambda x: f"{round(x, 2)}%" if x > 0 else "")
    plt.legend(labels=[v[0] for v in values], loc="center right", bbox_to_anchor=(1.5, 0.5))
    plt.subplots_adjust(left=0.0, bottom=0.1, right=0.65)
    plt.savefig("img/6b.png")
    plt.show()

    # 6c: сумарний прибуток по кожному девелоперу
    values = execute(cur, "SELECT * FROM dev_profit")
    plt.bar([v[0] for v in values], [v[1] for v in values])
    plt.title("Сумарний прибуток по кожному девелоперу")
    plt.xticks(rotation=90)
    plt.ylabel("total profit")
    plt.tight_layout()
    plt.savefig("img/6c.png")
    plt.show()
