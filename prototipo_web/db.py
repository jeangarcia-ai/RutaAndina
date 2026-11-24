
import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()


def obtener_conexion():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT", "3306")),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )


if __name__ == "__main__":
    try:
        conexion = obtener_conexion()
        cursor = conexion.cursor()

        cursor.execute("SELECT COUNT(*) FROM VIAJE")
        total_viajes = cursor.fetchone()[0]

        print("Conexión exitosa con RutaAndina.")
        print(f"Viajes registrados: {total_viajes}")

        cursor.close()
        conexion.close()

    except mysql.connector.Error as error:
        print(f"Error de conexión: {error}")
