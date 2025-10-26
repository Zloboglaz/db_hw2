import psycopg2


def create_db(conn):
    """
    Создание таблиц client и phone
    """

    with conn.cursor() as cur:
        cur.execute("""
        DROP TABLE phone;
        DROP TABLE client;
        """)

        cur.execute("""
        CREATE TABLE IF NOT EXISTS client(
            client_id SERIAL PRIMARY KEY,
            name      VARCHAR(20) NOT NULL,
            last_name VARCHAR(20) NOT NULL,
            email     VARCHAR(30) UNIQUE NOT NULL
            );
        """)

        cur.execute("""
        CREATE TABLE IF NOT EXISTS phone(
            phone_id     SERIAL PRIMARY KEY,
            phone_number VARCHAR(20) UNIQUE NOT NULL,
            client_id    INTEGER NOT NULL REFERENCES client(client_id)
            );
        """)

        conn.commit()


def add_client(conn, name, last_name, email, phones: list = None):
    """
    Добавление пользователя
    """

    with conn.cursor() as cur:
        cur.execute("""
        INSERT INTO client(name, last_name, email)
            VALUES(%s, %s, %s);
        """, (name, last_name, email))
        conn.commit()

        if phones:
            cur.execute("""
            SELECT client_id
              FROM client 
             WHERE name=%s AND last_name=%s AND email=%s;
            """, (name, last_name, email))
            client_id = cur.fetchone()[0]
            for phone in phones:
                cur.execute("""
                INSERT INTO phone(phone_number, client_id)
                    VALUES(%s, %s);
                """, (phone, client_id))


def add_phone(conn, client_id, phone):
    """
    Добавление номера телефона
    """

    with conn.cursor() as cur:
        cur.execute("""
        SELECT phone_id
          FROM phone 
         WHERE client_id=%s AND phone_number=%s;
        """, (client_id, phone))
        answ = cur.fetchone()

        if answ:
            print("Запись с таким id клиента и номером телефона уже присутствует в БД")
        else:
            cur.execute("""
               INSERT INTO phone (client_id, phone_number)
               VALUES (%s, %s);
            """, (client_id, phone))


def change_client(conn, client_id, first_name=None, last_name=None, email=None, phones:list = None):
    """
    Изменение информации о пользователе
    """

    with conn.cursor() as cur:
        query_str = []
        params = []

        if first_name:
            query_str.append('name = %s')
            params.append(first_name)

        if last_name:
            query_str.append('last_name = %s')
            params.append(last_name)

        if email:
            query_str.append('email = %s')
            params.append(email)

        if query_str:
            query = f"""
                   UPDATE client
                      SET {', '.join(query_str)}
                    WHERE client_id = %s
                RETURNING *;
            """
            params.append(client_id)

            cur.execute(query, params)
            conn.commit()

        if phones:
            cur.execute("""
            DELETE FROM phone
             WHERE client_id = %s; 
            """, (client_id, ))

            for phone in phones:
                add_phone(conn, client_id, phone)


def delete_phone(conn, client_id, phone):
    """
    Удаление номера телефона
    """

    with conn.cursor() as cur:
        cur.execute("""
        DELETE FROM phone
         WHERE client_id = %s AND phone_number = %s; 
        """, (client_id, phone))
        conn.commit()


def delete_client(conn, client_id):
    """
    Удаление номеров телефона пользователя и информации о самом пользователе
    """

    with conn.cursor() as cur:
        cur.execute("""
        DELETE FROM phone
         WHERE client_id = %s;
        """, (client_id, ))

        cur.execute("""
        DELETE FROM client
         WHERE client_id = %s;
        """, (client_id, ))

        conn.commit()


def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    """
    Вывод информации о пользователе
    """

    with conn.cursor() as cur:
        if phone:
            cur.execute("""
                SELECT client_id
                  FROM phone
                 WHERE phone_number=%s;
                """, (phone, ))
            client_id = cur.fetchone()[0]
        else:
            query_str = []
            params = []

            if first_name:
                query_str.append('name = %s')
                params.append(first_name)

            if last_name:
                query_str.append('last_name = %s')
                params.append(last_name)

            if email:
                query_str.append('email = %s')
                params.append(email)

            if query_str:
                query = f"""
                       SELECT client_id
                         FROM client
                        WHERE {' AND '.join(query_str)};
                """
                cur.execute(query, params)
                client_id = cur.fetchone()[0]

        cur.execute("""
            SELECT *
              FROM client
             WHERE client_id=%s;
            """, (client_id,))

        client_info = cur.fetchall()
        print('Информация о запрошенном пользователе')
        print(f'id - {client_info[0][0]}\nИмя - {client_info[0][1]}\nФамилия - {client_info[0][2]}\nEmail - {client_info[0][3]}')

        cur.execute("""
        SELECT phone_number
          FROM phone
         WHERE client_id = %s;
        """, (client_id, ))
        phones = cur.fetchall()
        print('Номера телефонов:')
        for phone in phones:
            print(phone[0])


with psycopg2.connect(database="client", user="postgres", password="postgres") as conn:
    create_db(conn=conn)

    # Добавление пользователей
    add_client(conn=conn, name='Анна', last_name='Петрова',
               email='ann_petrova@gmail.com')
    add_client(conn=conn, name='Евгений', last_name='Чёрный',
               email='e_black@yandex.ru')
    add_client(conn=conn, name='Вера', last_name='Васильева',
               email='v_v@yandex.ru')
    add_client(conn=conn, name='Елизавета', last_name='Антошкина',
               email='liz_ant@gmail.com', phones=('+74001234567', '+74007689654', '+74006578936'))
    add_client(conn=conn, name='Сергей', last_name='Макаров',
               email='s_makar@mail.ru', phones=('+75005678907', '+750083905768'))

    # Добавление номеров телефоном пользователей
    add_phone(conn=conn, client_id=1, phone='+71001234567')
    add_phone(conn=conn, client_id=1, phone='+71003478569')
    add_phone(conn=conn, client_id=2, phone='+72004785963')
    add_phone(conn=conn, client_id=2, phone='+72007689904')
    add_phone(conn=conn, client_id=3, phone='+73007934658')
    add_phone(conn=conn, client_id=3, phone='+73007645984')

    # Изменение информации о пользователе
    change_client(conn=conn, client_id=4, first_name='Лиза', email='l_ant@yandex.ru', phones=['+74001234549',])
    change_client(conn=conn, client_id=2, phones=['+72007777777', '+72008888888'])

    # Удаление номера телефона
    delete_phone(conn=conn, client_id=5, phone='+75005678907')
    delete_phone(conn=conn, client_id=2, phone='+72008888888')

    # Удаление пользователя
    delete_client(conn=conn, client_id=2)

    # Вывод информации о пользователе
    find_client(conn=conn, phone='+74001234549')
    print('\n-----------\n')
    find_client(conn=conn, first_name='Вера', last_name='Васильева')

conn.close()
