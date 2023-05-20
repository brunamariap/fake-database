import random
from faker import Faker
import psycopg2

fake = Faker('pt-BR')

# Conexão com o banco de dados
conn = psycopg2.connect(
    dbname="bancofake",
    user="postgres",
    password="admin",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

# Configurar a quantidade de linhas que você deseja gerar para cada tabela
qtd_teachers = 20000
qtd_students = 50000
qtd_courses = 50000
qtd_schedules = 500000
qtd_disciplines = 1000
qtd_classes = 5000


# Gerar e inserir dados na tabela Teacher
for i in range(qtd_teachers):
    cursor.execute('INSERT INTO teacher (id, registration, name, profile_photo, departament) VALUES (%s, %s, %s, %s, %s)', (i+1, i+1, fake.name(), fake.file_path(depth=3), 'Professor'))

# Gerar e inserir dados na tabela Student
for x in range(qtd_students):
    cursor.execute('INSERT INTO student (id, registration, name, profile_photo, class_id) VALUES (%s, %s, %s, %s, %s)', (x+1, f'20211094{x}', fake.name(), fake.file_path(depth=3), random.randint(1, qtd_classes)))

# Gerar e inserir dados na tabela Schedule
for x in range(qtd_schedules):
    cursor.execute('INSERT INTO schedule (id, discipline_id, quantity, weekday, start_time, end_time, class_id) VALUES (%s, %s, %s, %s, %s, %s, %s)', ())

# Confirmar as alterações e fechar a conexão
conn.commit()
cursor.close()
conn.close()