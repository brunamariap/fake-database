import random
from faker import Faker
import psycopg2

fake = Faker('pt-BR')

# Conexão com o banco de dados
conn = psycopg2.connect(
    dbname="bancofake",
    user="postgres",
    password="BMp@7890",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

# Configurar a quantidade de linhas que você deseja gerar para cada tabela
qtd_teachers = 20000
qtd_students = 50000
qtd_courses = 5000
qtd_schedules = 50000
qtd_disciplines = 10000
qtd_classes = 5000


cursor.execute('DELETE FROM Schedule')
cursor.execute('DELETE FROM studentassociation')
cursor.execute('DELETE FROM cousediscipline')
cursor.execute('DELETE FROM Discipline')
cursor.execute('DELETE FROM Student')
cursor.execute('DELETE FROM Class')
cursor.execute('DELETE FROM Course')
cursor.execute('DELETE FROM Teacher')

for x in range(qtd_teachers):
    cursor.execute('INSERT INTO teacher (id, registration, name, profile_photo, departament) VALUES (%s, %s, %s, %s, %s)', (x, x, fake.name(), fake.file_path(depth=3), 'Professor'))

for x in range(qtd_courses):
    cursor.execute("INSERT INTO Course (id, name, degree, course_load, byname) VALUES (%s, %s, %s, %s, %s)", (x, fake.catch_phrase(), random.randint(1, 7), random.randint(1000, 3500), fake.catch_phrase()))

for x in range(qtd_disciplines):
    workloads = [
        30,
        60,
        80,
        120,
    ]
    worload_random = workloads[random.randint(0, 3)]
    cursor.execute("INSERT INTO Discipline (id, name, code, workload_in_clock, workload_in_class, is_optional) VALUES (%s, %s, %s, %s, %s, %s)", (x, fake.job(), f"TEC-{x}", worload_random, (worload_random * 60) / 45, bool(random.randint(0, 1))))

for x in range(qtd_classes):
    shifts = [
        'Matutino',
        'Vespertino',
        'Noturno'
    ]
    shift_random = shifts[random.randint(0,2)]
    cursor.execute("INSERT INTO Class (id, class_leader, course_id, reference_period, shift) VALUES (%s, %s, %s, %s, %s)", (x, None, random.randint(0, qtd_courses-1), random.randint(1, 7), shift_random))

# Gerar e inserir dados na tabela Student
for x in range(qtd_students):
    cursor.execute('INSERT INTO student (id, registration, name, profile_photo, class_id) VALUES (%s, %s, %s, %s, %s)', (x, x, fake.name(), fake.file_path(depth=3), random.randint(0, qtd_classes-1)))

# Gerar e inserir dados na tabela Schedule
for x in range(qtd_schedules):
    cursor.execute('INSERT INTO schedule (id, discipline_id, quantity, weekday, start_time, end_time, class_id) VALUES (%s, %s, %s, %s, %s, %s, %s)', (x, random.randint(0, qtd_disciplines-1), random.randint(1, 6), random.randint(0, 6), fake.time(), fake.time(), random.randint(0, qtd_classes-1)))

for x in range(qtd_students):
    cursor.execute('INSERT INTO studentassociation (id, student_id, discipline_id) VALUES (%s, %s, %s)', (x, random.randint(0, qtd_students - 1), random.randint(0, qtd_disciplines - 1)))

for x in range(qtd_disciplines):
    cursor.execute('INSERT INTO cousediscipline (id, discipline_id, course_id, period) VALUES (%s, %s, %s, %s)', (x, x, random.randint(0, qtd_courses - 1), random.randint(1, 8)))


# Confirmar as alterações e fechar a conexão
conn.commit()
cursor.close()
conn.close()