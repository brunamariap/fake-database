import random
from faker import Faker
import psycopg2

fake = Faker()

# Conexão com o banco de dados
conn = psycopg2.connect(
    dbname="bancofake",
    user="postgresfake",
    password="12345",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

# Configurar a quantidade de linhas que você deseja gerar para cada tabela
qtd_teachers = 200000
qtd_students = 500
qtd_courses = 50000
qtd_schedules = 500000
qtd_disciplines = 1000

# Gerar e inserir dados na tabela Cidade
for _ in range(qtd_cidades):
    cursor.execute("INSERT INTO Cidade (nome) VALUES (%s)", (fake.city(),))

# Gerar e inserir dados na tabela Universidade
for _ in range(qtd_universidades):
    cidade_id = random.randint(1, qtd_cidades)
    cursor.execute("INSERT INTO Universidade (nome, cidade_id) VALUES (%s, %s)", (fake.company(), cidade_id))

# Gerar e inserir dados na tabela Professor
for _ in range(qtd_professores):
    cidade_id = random.randint(1, qtd_cidades)
    cursor.execute(
        "INSERT INTO Professor (nome, data_nascimento, cidade_id) VALUES (%s, %s, %s)",
        (fake.name(), fake.date_of_birth(tzinfo=None, minimum_age=25, maximum_age=65), cidade_id)
    )

# Gerar e inserir dados na tabela Aluno
for _ in range(qtd_alunos):
    cidade_id = random.randint(1, qtd_cidades)
    universidade_id = random.randint(1, qtd_universidades)
    cursor.execute(
        "INSERT INTO Aluno (nome, data_nascimento, cidade_id, universidade_id) VALUES (%s, %s, %s, %s)",
        (fake.name(), fake.date_of_birth(tzinfo=None, minimum_age=18, maximum_age=30), cidade_id, universidade_id)
    )

# Gerar e inserir dados na tabela Disciplina
for _ in range(qtd_disciplinas):
    professor_id = random.randint(1, qtd_professores)
    universidade_id = random.randint(1, qtd_universidades)
    cursor.execute(
        "INSERT INTO Disciplina (nome, professor_id, universidade_id) VALUES (%s, %s, %s)",
        (fake.job(), professor_id, universidade_id)
    )

# Confirmar as alterações e fechar a conexão
conn.commit()
cursor.close()
conn.close()