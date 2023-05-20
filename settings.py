import psycopg2


CONN = psycopg2.connect(
    dbname="bancofake",
    user="postgresfake",
    password="12345",
    host="localhost",
    port="5432"
)

CURSOR = CONN.cursor()