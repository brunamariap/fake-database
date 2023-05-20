from faker import Faker
from settings import CURSOR


fake = Faker()

def create_teacher(qtd_teachers):
    for i in range(qtd_teachers):
        CURSOR.execute(f"INSERT INTO Teacher (registration, name, profile_photo, departament) VALUES ({fake.name()}, {i}, , Professor)")


def create_student():
    pass