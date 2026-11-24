
# RutaAndina

Prototipo web de un sistema de gestión de viajes para Perú y Colombia, desarrollado como parte del proyecto académico de Base de Datos entre TECSUP y el Politécnico Grancolombiano.

## Tecnologías utilizadas

- Python y Flask
- MySQL 8
- HTML y CSS
- MySQL Connector/Python
- python-dotenv

## Funcionalidades

### Pasajero
- Consultar pasajeros registrados.
- Solicitar viajes.
- Revisar el historial de viajes.

### Conductor
- Consultar conductores registrados.
- Aceptar solicitudes.
- Iniciar y finalizar viajes.
- Actualizar los estados en MySQL.

### Empresa
- Consultar empresas registradas.
- Revisar empleados vinculados.
- Visualizar viajes corporativos y facturación.

## Requisitos

- Python instalado.
- MySQL Server funcionando.
- Una copia de la base de datos RutaAndina.

## Instalación

1. Abrir la carpeta prototipo_web en VS Code.

2. Crear el entorno virtual:

    python -m venv .venv

3. Instalar las dependencias:

    python -m pip install -r requirements.txt

4. Crear la base de datos rutaandina_prueba en MySQL e importar el respaldo SQL del proyecto.

5. Copiar .env.example con el nombre .env.

6. Configurar la contraseña de MySQL en .env.

7. Ejecutar la aplicación:

    python app.py

8. Abrir en el navegador:

    http://127.0.0.1:5000

## Base de datos

El modelo contiene 16 tablas relacionadas y utiliza claves primarias, claves foráneas, restricciones y triggers para controlar la integridad de los datos.

El prototipo utiliza la base rutaandina_prueba para realizar sus operaciones sin modificar la base original.

## Alcance

El sistema es un prototipo académico. Permite demostrar operaciones de lectura y escritura en MySQL, pero no incorpora autenticación real de usuarios ni procesamiento de pagos electrónicos.

## Seguridad

El archivo .env contiene las credenciales locales y no debe subirse a GitHub.
