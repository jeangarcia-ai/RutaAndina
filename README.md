# RutaAndina

**Prototipo académico de gestión de viajes para Perú y Colombia**  
Proyecto colaborativo de Base de Datos — TECSUP y Politécnico Grancolombiano (2026-II).

RutaAndina es una aplicación web desarrollada con Python, Flask y MySQL. Permite consultar información de pasajeros, conductores y empresas, registrar solicitudes de viaje y actualizar los estados de los viajes. Se utiliza una base de datos relacional de 16 tablas, con datos de prueba para Perú (PEN) y Colombia (COP).

> **Alcance:** prototipo académico ejecutado de forma local. No incorpora autenticación real, mapas, GPS ni pagos bancarios. Los perfiles se representan mediante pantallas funcionales. El panel empresarial muestra información mediante consultas; las operaciones de registro y actualización se realizan desde las pantallas de viajes.

## 1. Requisitos

- **Python** instalado y disponible desde la terminal (el proyecto se desarrolló con Python 3.14).
- **MySQL Server 8.0 o superior**, iniciado y accesible desde la computadora.
- **MySQL Workbench** para ejecutar cómodamente los archivos SQL.
- Un navegador web (Chrome, Edge o Firefox).
- Git, solo si se desea clonar el repositorio mediante comandos.

La aplicación no se conecta a la base de datos de otra persona: cada equipo o evaluador debe crear una base local con los archivos SQL incluidos.

## 2. Estructura de archivos

```text
RutaAndina/
├── README.md                 # Guía de instalación y ejecución
├── sql/
│   ├── 01_ddl_RutaAndina_16_entidades.sql
│   ├── 02_dml_RutaAndina_16_entidades.sql
│   ├── 03_consultas_RutaAndina.sql
│   └── 04_triggers_RutaAndina.sql
└── prototipo_web/
    ├── app.py
    ├── db.py
    ├── requirements.txt
    ├── .env.example
    ├── README.md             # Descripción del prototipo
    ├── static/
    │   ├── style.css
    │   └── banner_rutaandina.png
    └── templates/
        └── _navbar.html
```

El README de la carpeta principal explica cómo instalar el proyecto; el README que ya existe dentro de `prototipo_web` puede conservarse como descripción de la aplicación. El archivo `.env` y la carpeta `.venv` son locales y no se incluyen en GitHub.

## 3. Descargar el proyecto

Con una cuenta autorizada para acceder al repositorio privado:

```powershell
git clone https://github.com/jeangarcia-ai/RutaAndina.git
cd RutaAndina
```

También se puede utilizar **Code > Download ZIP** en GitHub, descomprimir el archivo y abrir la carpeta `RutaAndina`.

## 4. Crear la base de datos en MySQL

1. Iniciar MySQL Server y abrir **MySQL Workbench**.
2. Conectarse con un usuario que tenga permisos para crear bases de datos, tablas y triggers.
3. Ir a **File > Open SQL Script** y abrir el primer archivo de la carpeta `sql`.
4. Ejecutar los archivos **en el siguiente orden**, utilizando el botón del rayo para ejecutar todo el script:

   1. `01_ddl_RutaAndina_16_entidades.sql`: crea la base `rutaandina_nueva` y sus 16 tablas.
   2. `02_dml_RutaAndina_16_entidades.sql`: inserta los datos académicos de prueba.
   3. `04_triggers_RutaAndina.sql`: crea los seis triggers de control e historial de viajes.
   4. `03_consultas_RutaAndina.sql`: ejecuta consultas de negocio y comprobaciones, **opcional** para instalar la aplicación.

**Atención:** los scripts oficiales de este repositorio utilizan la base de datos **`rutaandina_nueva`**. No los ejecutes sobre una base que ya tenga las tablas y datos cargados, porque podrían producirse errores de objetos o identificadores duplicados. Para una instalación nueva, ejecutarlos una sola vez en ese orden.

Para comprobar que la base quedó creada, ejecutar en MySQL Workbench:

```sql
USE rutaandina_nueva;
SHOW TABLES;
SELECT COUNT(*) AS pasajeros FROM PASAJERO;
SELECT COUNT(*) AS viajes FROM VIAJE;
SHOW TRIGGERS;
```

La carga inicial contiene 20 pasajeros y 50 viajes. Los viajes creados posteriormente en otra computadora, como el viaje de demostración 51, **no forman parte del DML inicial**.

## 5. Instalar las dependencias de Python (Windows)

Abrir PowerShell o la terminal de VS Code y entrar a la carpeta de la aplicación:

```powershell
cd prototipo_web
```

Crear un entorno virtual:

```powershell
py -m venv .venv
```

Instalar las bibliotecas del proyecto dentro de ese entorno:

```powershell
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

Si Windows no reconoce el comando `py`, utilizar `python -m venv .venv`.

## 6. Configurar la conexión con MySQL

En `prototipo_web`, crear un archivo `.env` a partir de `.env.example`:

```powershell
Copy-Item .env.example .env
```

Abrir `.env` y ajustar los valores de acuerdo con el servidor MySQL instalado. La configuración prevista es:

```dotenv
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=rutaandina_nueva
```

- `DB_USER` y `DB_PASSWORD` deben corresponder a las credenciales **propias** del MySQL del evaluador. Si `root` tiene contraseña, escribirla en `DB_PASSWORD`.
- Si MySQL utiliza otro puerto, ajustar `DB_PORT`.
- **Importante:** establecer `DB_NAME=rutaandina_nueva`. El esquema `rutaandina_prueba` se usó únicamente para las pruebas locales del equipo; no es el nombre que crean los scripts incluidos en este repositorio.
- `db.py` obtiene `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD` y `DB_NAME` directamente del archivo `.env`.
- **Nunca subir el archivo `.env` a GitHub.**

## 7. Probar la conexión y ejecutar RutaAndina

Dentro de `prototipo_web`, con el servidor MySQL iniciado, comprobar primero la conexión:

```powershell
.\.venv\Scripts\python.exe db.py
```

Si la configuración es correcta, aparecerá el mensaje «Conexión exitosa con RutaAndina» junto al número de viajes registrados. Después iniciar el servidor Flask:

```powershell
.\.venv\Scripts\python.exe app.py
```

Cuando Flask muestre una dirección local, abrir en el navegador:

**http://127.0.0.1:5000**

Mantener abierta la terminal mientras se utiliza la aplicación. Para detener Flask, presionar `Ctrl + C`.

## 8. Funciones que se pueden demostrar

- **Inicio (`/`)**: página de presentación y acceso a los tres perfiles.
- **Pasajeros (`/pasajeros`)**: consulta de pasajeros y acceso a sus historiales.
- **Solicitar viaje (`/solicitar-viaje`)**: registro de una solicitud de viaje en MySQL.
- **Conductores (`/conductores`)**: consulta de conductores registrados.
- **Panel del conductor (`/panel-conductor`)**: aceptación de solicitudes, inicio y finalización de viajes; los estados se guardan en MySQL.
- **Empresas (`/empresas`)**: consulta de empresas.
- **Panel corporativo**: consulta de empleados, viajes y facturas de una empresa cliente.

Para verificar los cambios después de finalizar un viaje, se pueden consultar las tablas `VIAJE` e `HISTORIAL_ESTADO_VIAJE` en MySQL Workbench.

## 9. Solución de problemas frecuentes

| Problema | Qué comprobar |
|---|---|
| `ERR_CONNECTION_REFUSED` al abrir `127.0.0.1:5000` | Iniciar `app.py` y mantener Flask ejecutándose. |
| `ModuleNotFoundError` | Instalar las dependencias con el Python del entorno virtual. |
| `Access denied for user` | Comprobar usuario y contraseña en `.env`. |
| `Unknown database` | Ejecutar el script DDL y verificar que `DB_NAME` sea `rutaandina_nueva`. |
| `Can't connect to MySQL server` | Iniciar MySQL y revisar host y puerto. |
| Error al volver a ejecutar el DDL o DML | Los scripts de creación y carga inicial se ejecutan una sola vez en una base nueva. |
| El banner no aparece | Comprobar `static/banner_rutaandina.png` y actualizar el navegador con `Ctrl + F5`. |

## 10. Código fuente y seguridad

Repositorio: **https://github.com/jeangarcia-ai/RutaAndina**

Para comprobar el entorno del evaluador, el archivo `.env.example` debe conservar `DB_NAME=rutaandina_nueva` y cada evaluador debe crear su propio archivo `.env`.

El repositorio se creó como **privado**. El profesor necesitará una invitación como colaborador o una copia del proyecto para acceder. Los datos incluidos en los scripts son de demostración y el proyecto no debe utilizarse como una plataforma de transporte en producción.


## 11. Nota sobre los scripts entregados

Los cuatro scripts enumerados en esta guía son los que se utilizan para reconstruir la base y realizar las consultas. La vista SQL (`VIEW`) exigida en la rúbrica fue comprobada durante el desarrollo, pero su instrucción de creación no está incluida en la versión revisada de `03_consultas_RutaAndina.sql`. Antes de la entrega definitiva, debe incorporarse al repositorio para que el evaluador pueda reproducir también esa vista.
