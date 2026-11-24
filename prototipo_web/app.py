
from flask import Flask, render_template_string, url_for, request, redirect
from db import obtener_conexion
import mysql.connector


app = Flask(__name__)



@app.route("/")
def inicio():
    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Inicio</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>

        <header class="inicio-encabezado">
            <div class="inicio-marca">
                <span class="inicio-logo">RA</span>
                <span>RutaAndina</span>
            </div>
            <span class="inicio-etiqueta">
                Perú y Colombia
            </span>
        </header>

        <section class="inicio-banner" aria-label="RutaAndina: Tu destino, nuestro camino">
            <img
                src="{{ url_for('static', filename='banner_rutaandina.png') }}"
                alt="RutaAndina. Tu destino, nuestro camino. Viaja con comodidad y confianza en Perú y Colombia. Automóvil negro y conductor con ropa deportiva."
                width="1672" height="941"
                fetchpriority="high"
            >
        </section>

        <main class="inicio-contenido">
            <section class="inicio-presentacion">
                <span class="inicio-subtitulo">PLATAFORMA DE TRANSPORTE</span>
                <h1>Bienvenido a RutaAndina</h1>
                <p>
                    Gestiona solicitudes de viaje, consulta conductores
                    y administra servicios corporativos desde una sola plataforma.
                </p>
            </section>

            <h2>Selecciona un perfil</h2>

            <section class="inicio-tarjetas">

                <article class="inicio-tarjeta">
                    <div class="inicio-icono">P</div>

                    <h3>Pasajero</h3>

                    <p>
                        Solicita un viaje, consulta tus datos
                        y revisa tu historial de viajes.
                    </p>

                    <div class="inicio-acciones">
                        <a class="inicio-boton"
                           href="{{ url_for('solicitar_viaje') }}">
                            Solicitar viaje
                        </a>

                        <a class="inicio-enlace"
                           href="{{ url_for('pasajeros') }}">
                            Ver pasajeros
                        </a>
                    </div>
                </article>

                <article class="inicio-tarjeta">
                    <div class="inicio-icono">C</div>

                    <h3>Conductor</h3>

                    <p>
                        Consulta solicitudes, acepta viajes
                        y actualiza sus estados.
                    </p>

                    <div class="inicio-acciones">
                        <a class="inicio-boton"
                           href="{{ url_for('panel_conductor') }}">
                            Gestionar viajes
                        </a>

                        <a class="inicio-enlace"
                           href="{{ url_for('conductores') }}">
                            Ver conductores
                        </a>
                    </div>
                </article>

                <article class="inicio-tarjeta">
                    <div class="inicio-icono">E</div>

                    <h3>Empresa</h3>

                    <p>
                        Consulta empleados, viajes
                        corporativos y facturación
                        de Perú y Colombia.
                    </p>

                    <div class="inicio-acciones">
                        <a class="inicio-boton"
                           href="{{ url_for('empresas') }}">
                            Ver empresas
                        </a>

                        <a class="inicio-enlace"
                           href="{{ url_for('panel_empresa',
                                           id_empresa=2) }}">
                            Panel corporativo
                        </a>
                    </div>
                </article>

            </section>
        </main>

        <footer class="inicio-pie">
            RutaAndina | Prototipo académico
            TECSUP - Politécnico Grancolombiano
        </footer>

    </body>
    </html>
    """)



@app.route("/pasajeros")
def pasajeros():
    conexion = obtener_conexion()

    try:
        cursor = conexion.cursor(dictionary=True)
        try:
            cursor.execute("""
                SELECT id_pasajero, nombres, apellidos, email
                FROM PASAJERO
                ORDER BY id_pasajero
            """)
            datos = cursor.fetchall()
        finally:
            cursor.close()
    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Pasajeros</title>
        <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>RutaAndina - Pasajeros</h1>
        <p>Pasajeros registrados: {{ pasajeros|length }}</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Correo electrónico</th>
                    <th>Historial</th>
                </tr>
            </thead>
            <tbody>
                {% for pasajero in pasajeros %}
                <tr>
                    <td>{{ pasajero.id_pasajero }}</td>
                    <td>{{ pasajero.nombres }}</td>
                    <td>{{ pasajero.apellidos }}</td>
                    <td>{{ pasajero.email }}</td>
                    <td> <a href="{{ url_for('historial_pasajero',
                        id_pasajero=pasajero.id_pasajero) }}">
                          Ver viajes
                        </a>
                    </td>
                    
                </tr>
                {% endfor %}
            </tbody>
        </table>

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, pasajeros=datos)


@app.route("/conductores")
def conductores():
    conexion = obtener_conexion()

    try:
        cursor = conexion.cursor(dictionary=True)
        try:
            cursor.execute("""
                SELECT
                    id_conductor,
                    nombres,
                    apellidos,
                    num_licencia,
                    venc_licencia,
                    estado
                FROM CONDUCTOR
                ORDER BY id_conductor
            """)
            datos = cursor.fetchall()
        finally:
            cursor.close()
    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Conductores</title>
        <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>RutaAndina - Conductores</h1>
        <p>Conductores registrados: {{ conductores|length }}</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Licencia</th>
                    <th>Vencimiento</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                {% for conductor in conductores %}
                <tr>
                    <td>{{ conductor.id_conductor }}</td>
                    <td>{{ conductor.nombres }}</td>
                    <td>{{ conductor.apellidos }}</td>
                    <td>{{ conductor.num_licencia }}</td>
                    <td>{{ conductor.venc_licencia }}</td>
                    <td>{{ conductor.estado }}</td>
                </tr>
                {% endfor %}
            </tbody>
        </table>

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, conductores=datos)


@app.route("/empresas")
def empresas():
    conexion = obtener_conexion()

    try:
        cursor = conexion.cursor(dictionary=True)
        try:
            cursor.execute("""
                SELECT
                    e.id_empresa,
                    e.razon_social,
                    e.tipo_empresa,
                    p.nombre_pais,
                    e.telefono_contacto
                FROM EMPRESA e
                INNER JOIN PAIS p
                    ON e.id_pais = p.id_pais
                ORDER BY e.id_empresa
            """)
            datos = cursor.fetchall()
        finally:
            cursor.close()
    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Empresas</title>
        <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>RutaAndina - Empresas</h1>
        <p>Empresas registradas: {{ empresas|length }}</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Razón social</th>
                    <th>Tipo de empresa</th>
                    <th>País</th>
                    <th>Teléfono</th>
                    <th>Panel</th>
                </tr>
            </thead>
            <tbody>
                {% for empresa in empresas %}
                <tr>
                    <td>{{ empresa.id_empresa }}</td>
                    <td>{{ empresa.razon_social }}</td>
                    <td>{{ empresa.tipo_empresa }}</td>
                    <td>{{ empresa.nombre_pais }}</td>
                    <td>{{ empresa.telefono_contacto }}</td>
                    <td>{% if empresa.tipo_empresa == 'CLIENTE' %}
                    <a href="{{ url_for('panel_empresa', id_empresa=empresa.id_empresa) }}">
                    Ver panel
                    </a>
                    {% else %}
                    No aplica
                    {% endif %}
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, empresas=datos)


@app.route("/solicitar-viaje", methods=["GET", "POST"])
def solicitar_viaje():
    conexion = obtener_conexion()
    error = None

    try:
        cursor = conexion.cursor(dictionary=True)

        try:
            if request.method == "POST":
                try:
                    id_pasajero = int(request.form["id_pasajero"])
                    id_tarifa = int(request.form["id_tarifa"])
                    origen = request.form["origen"].strip()
                    destino = request.form["destino"].strip()
                    distancia = float(request.form["distancia_km"])

                    if not origen or not destino:
                        raise ValueError("Completa el origen y el destino.")

                    if len(origen) > 200 or len(destino) > 200:
                        raise ValueError("Las direcciones son demasiado largas.")

                    if not (0 < distancia <= 1000):
                        raise ValueError("La distancia debe ser mayor que 0 y hasta 1000 km.")

                    cursor.execute(
                        "SELECT id_pais FROM PASAJERO WHERE id_pasajero = %s",
                        (id_pasajero,)
                    )
                    pasajero = cursor.fetchone()

                    cursor.execute(
                        "SELECT id_pais FROM TARIFA_PAIS WHERE id_tarifa = %s",
                        (id_tarifa,)
                    )
                    tarifa = cursor.fetchone()

                    if not pasajero or not tarifa:
                        error = "El pasajero o la tarifa seleccionada no existe."

                    elif pasajero["id_pais"] != tarifa["id_pais"]:
                        error = "Selecciona una tarifa del mismo país del pasajero."

                    else:
                        cursor.execute("""
                            INSERT INTO VIAJE (
                                id_pasajero,
                                id_tarifa,
                                origen,
                                destino,
                                distancia_km,
                                estado
                            )
                            VALUES (%s, %s, %s, %s, %s, 'SOLICITADO')
                        """, (
                            id_pasajero,
                            id_tarifa,
                            origen,
                            destino,
                            distancia
                        ))

                        nuevo_id = cursor.lastrowid
                        conexion.commit()

                        return redirect(
                            url_for("solicitar_viaje", registrado=nuevo_id)
                        )

                except (ValueError, KeyError, TypeError) as e:
                    error = str(e)

            cursor.execute("""
                SELECT
                    p.id_pasajero,
                    CONCAT(p.nombres, ' ', p.apellidos) AS nombre,
                    pa.nombre_pais
                FROM PASAJERO p
                INNER JOIN PAIS pa ON p.id_pais = pa.id_pais
                ORDER BY p.id_pasajero
            """)
            pasajeros = cursor.fetchall()

            cursor.execute("""
                SELECT
                    t.id_tarifa,
                    ts.nombre_servicio,
                    pa.nombre_pais
                FROM TARIFA_PAIS t
                INNER JOIN TIPO_SERVICIO ts
                    ON t.id_tipo_servicio = ts.id_tipo_servicio
                INNER JOIN PAIS pa
                    ON t.id_pais = pa.id_pais
                ORDER BY pa.nombre_pais, ts.nombre_servicio
            """)
            tarifas = cursor.fetchall()

        finally:
            cursor.close()

    except Exception:
        conexion.rollback()
        raise

    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Solicitar viaje</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Solicitar viaje</h1>
        <p>Registra una nueva solicitud de transporte.</p>

        {% if request.args.get('registrado') %}
            <p style="color: green;">
                Viaje registrado correctamente.
                ID: {{ request.args.get('registrado') }}
            </p>
        {% endif %}

        {% if error %}
            <p style="color: red;">{{ error }}</p>
        {% endif %}

        <form method="POST">

            <p>
                <label for="id_pasajero">Pasajero:</label>
                <select name="id_pasajero" id="id_pasajero" required>
                    <option value="">Seleccionar pasajero</option>
                    {% for p in pasajeros %}
                        <option value="{{ p.id_pasajero }}">
                            {{ p.nombre }} - {{ p.nombre_pais }}
                        </option>
                    {% endfor %}
                </select>
            </p>

            <p>
                <label for="id_tarifa">Tipo de servicio:</label>
                <select name="id_tarifa" id="id_tarifa" required>
                    <option value="">Seleccionar servicio</option>
                    {% for t in tarifas %}
                        <option value="{{ t.id_tarifa }}">
                            {{ t.nombre_servicio }} - {{ t.nombre_pais }}
                        </option>
                    {% endfor %}
                </select>
            </p>

            <p>
                <label for="origen">Origen:</label>
                <input type="text" name="origen" id="origen"
                       maxlength="200" required>
            </p>

            <p>
                <label for="destino">Destino:</label>
                <input type="text" name="destino" id="destino"
                       maxlength="200" required>
            </p>

            <p>
                <label for="distancia_km">Distancia (km):</label>
                <input type="number" name="distancia_km"
                       id="distancia_km"
                       min="0.01" max="1000" step="0.01" required>
            </p>

            <button type="submit">Solicitar viaje</button>

        </form>

        <p><a href="/">Volver al inicio</a></p>

    </body>
    </html>
    """, pasajeros=pasajeros, tarifas=tarifas, error=error)


@app.route("/aceptar-viaje/<int:id_viaje>", methods=["GET", "POST"])
def aceptar_viaje(id_viaje):
    conexion = obtener_conexion()
    cursor = conexion.cursor(dictionary=True)
    error = None

    try:
        cursor.execute("""
            SELECT
                v.id_viaje,
                v.id_pasajero,
                v.id_tarifa,
                v.origen,
                v.destino,
                v.estado,
                CONCAT(p.nombres, ' ', p.apellidos) AS pasajero,
                ts.nombre_servicio
            FROM VIAJE v
            INNER JOIN PASAJERO p
                ON v.id_pasajero = p.id_pasajero
            INNER JOIN TARIFA_PAIS t
                ON v.id_tarifa = t.id_tarifa
            INNER JOIN TIPO_SERVICIO ts
                ON t.id_tipo_servicio = ts.id_tipo_servicio
            WHERE v.id_viaje = %s
        """, (id_viaje,))

        viaje = cursor.fetchone()

        if viaje is None:
            return "El viaje no existe.", 404

        cursor.execute("""
            SELECT DISTINCT
                c.id_conductor,
                CONCAT(c.nombres, ' ', c.apellidos) AS nombre,
                ve.placa
            FROM CONDUCTOR c
            INNER JOIN ASIGNACION_VEHICULO av
                ON av.id_conductor = c.id_conductor
            INNER JOIN VEHICULO ve
                ON ve.id_vehiculo = av.id_vehiculo
            INNER JOIN TARIFA_PAIS t
                ON t.id_tarifa = %s
            INNER JOIN PASAJERO p
                ON p.id_pasajero = %s
            WHERE c.estado = 'ACTIVO'
              AND c.venc_licencia >= CURDATE()
              AND ve.venc_soat >= CURDATE()
              AND av.es_activo = TRUE
              AND av.fecha_inicio <= CURDATE()
              AND av.fecha_fin IS NULL
              AND c.id_pais = t.id_pais
              AND p.id_pais = t.id_pais
              AND ve.id_tipo_servicio = t.id_tipo_servicio
            ORDER BY c.id_conductor
        """, (viaje["id_tarifa"], viaje["id_pasajero"]))

        conductores = cursor.fetchall()

        if request.method == "POST":
            try:
                id_conductor = int(request.form["id_conductor"])

                if viaje["estado"] != "SOLICITADO":
                    error = "Este viaje ya no está pendiente."

                elif id_conductor not in [
                    c["id_conductor"] for c in conductores
                ]:
                    error = "El conductor no cumple los requisitos."

                else:
                    cursor.execute("""
                        UPDATE VIAJE
                        SET
                            id_conductor = %s,
                            estado = 'ACEPTADO'
                        WHERE id_viaje = %s
                          AND estado = 'SOLICITADO'
                    """, (id_conductor, id_viaje))

                    if cursor.rowcount != 1:
                        conexion.rollback()
                        error = "El viaje ya fue modificado."
                    else:
                        conexion.commit()
                        return redirect(
                            url_for("aceptar_viaje", id_viaje=id_viaje)
                        )

            except (ValueError, KeyError):
                error = "Selecciona un conductor válido."

            except mysql.connector.Error as e:
                conexion.rollback()
                error = f"MySQL rechazó la asignación: {e.msg}"

    finally:
        cursor.close()
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Aceptar viaje</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Aceptar viaje #{{ viaje.id_viaje }}</h1>

        <p><strong>Pasajero:</strong> {{ viaje.pasajero }}</p>
        <p><strong>Origen:</strong> {{ viaje.origen }}</p>
        <p><strong>Destino:</strong> {{ viaje.destino }}</p>
        <p><strong>Servicio:</strong> {{ viaje.nombre_servicio }}</p>
        <p><strong>Estado actual:</strong> {{ viaje.estado }}</p>

        {% if error %}
            <p style="color: red;">{{ error }}</p>
        {% endif %}

        {% if viaje.estado == 'SOLICITADO' %}

            {% if conductores %}
                <form method="POST">
                    <p>
                        <label for="id_conductor">
                            Seleccionar conductor:
                        </label>
                    </p>

                    <select name="id_conductor"
                            id="id_conductor" required>
                        <option value="">
                            Seleccionar conductor
                        </option>

                        {% for c in conductores %}
                            <option value="{{ c.id_conductor }}">
                                {{ c.nombre }} - Placa {{ c.placa }}
                            </option>
                        {% endfor %}
                    </select>

                    <p>
                        <button type="submit">
                            Aceptar viaje
                        </button>
                    </p>
                </form>
            {% else %}
                <p>No hay conductores habilitados
                   para este viaje.</p>
            {% endif %}

        {% else %}
            <p>Este viaje ya no está pendiente de aceptación.</p>
        {% endif %}

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, viaje=viaje, conductores=conductores, error=error)


@app.route("/iniciar-viaje/<int:id_viaje>", methods=["GET", "POST"])
def iniciar_viaje(id_viaje):
    conexion = obtener_conexion()
    cursor = conexion.cursor(dictionary=True)
    error = None

    try:
        cursor.execute("""
            SELECT
                v.id_viaje,
                v.estado,
                v.origen,
                v.destino,
                CONCAT(c.nombres, ' ', c.apellidos) AS conductor
            FROM VIAJE v
            LEFT JOIN CONDUCTOR c
                ON v.id_conductor = c.id_conductor
            WHERE v.id_viaje = %s
        """, (id_viaje,))

        viaje = cursor.fetchone()

        if viaje is None:
            return "El viaje no existe.", 404

        if request.method == "POST":
            if viaje["estado"] != "ACEPTADO":
                error = "El viaje debe estar ACEPTADO para iniciarlo."
            else:
                try:
                    cursor.execute("""
                        UPDATE VIAJE
                        SET
                            estado = 'EN_CURSO',
                            fecha_inicio = NOW()
                        WHERE id_viaje = %s
                          AND estado = 'ACEPTADO'
                          AND id_conductor IS NOT NULL
                    """, (id_viaje,))

                    if cursor.rowcount == 1:
                        conexion.commit()
                        return redirect(
                            url_for("iniciar_viaje", id_viaje=id_viaje)
                        )
                    else:
                        conexion.rollback()
                        error = "No se pudo iniciar el viaje."

                except mysql.connector.Error as e:
                    conexion.rollback()
                    error = f"Error de MySQL: {e.msg}"

    finally:
        cursor.close()
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Iniciar viaje</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Gestión del viaje #{{ viaje.id_viaje }}</h1>

        <p><strong>Conductor:</strong> {{ viaje.conductor }}</p>
        <p><strong>Origen:</strong> {{ viaje.origen }}</p>
        <p><strong>Destino:</strong> {{ viaje.destino }}</p>
        <p><strong>Estado:</strong> {{ viaje.estado }}</p>

        {% if error %}
            <p style="color: red;">{{ error }}</p>
        {% endif %}

        {% if viaje.estado == 'ACEPTADO' %}
            <form method="POST">
                <button type="submit">Iniciar viaje</button>
            </form>
        {% elif viaje.estado == 'EN_CURSO' %}
            <p style="color: green;">
                El viaje se inició correctamente.
            </p>
        {% endif %}

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, viaje=viaje, error=error)


@app.route("/finalizar-viaje/<int:id_viaje>", methods=["GET", "POST"])
def finalizar_viaje(id_viaje):
    conexion = obtener_conexion()
    cursor = conexion.cursor(dictionary=True)
    error = None

    try:
        if request.method == "POST":
            try:
                cursor.execute("""
                    UPDATE VIAJE v
                    INNER JOIN TARIFA_PAIS t
                        ON v.id_tarifa = t.id_tarifa
                    SET
                        v.monto_total = ROUND(
                            GREATEST(
                                t.costo_min,
                                t.tarifa_base +
                                t.costo_km * v.distancia_km
                            ), 2
                        ),
                        v.fecha_fin = NOW(),
                        v.estado = 'FINALIZADO'
                    WHERE v.id_viaje = %s
                      AND v.estado = 'EN_CURSO'
                      AND v.id_conductor IS NOT NULL
                      AND v.fecha_inicio IS NOT NULL
                      AND v.distancia_km > 0
                """, (id_viaje,))

                if cursor.rowcount == 1:
                    conexion.commit()
                    return redirect(
                        url_for("finalizar_viaje", id_viaje=id_viaje)
                    )
                else:
                    conexion.rollback()
                    error = "El viaje no cumple los requisitos para finalizar."

            except mysql.connector.Error as e:
                conexion.rollback()
                error = f"MySQL rechazó la operación: {e.msg}"

        cursor.execute("""
            SELECT
                v.id_viaje,
                v.estado,
                v.origen,
                v.destino,
                v.distancia_km,
                v.fecha_inicio,
                v.fecha_fin,
                v.monto_total,
                pa.moneda,
                ROUND(
                    GREATEST(
                        t.costo_min,
                        t.tarifa_base +
                        t.costo_km * v.distancia_km
                    ), 2
                ) AS monto_estimado,
                CONCAT(c.nombres, ' ', c.apellidos) AS conductor
            FROM VIAJE v
            LEFT JOIN CONDUCTOR c
                ON v.id_conductor = c.id_conductor
            INNER JOIN TARIFA_PAIS t
                ON v.id_tarifa = t.id_tarifa
            INNER JOIN PAIS pa
                ON t.id_pais = pa.id_pais
            WHERE v.id_viaje = %s
        """, (id_viaje,))

        viaje = cursor.fetchone()

    finally:
        cursor.close()
        conexion.close()

    if viaje is None:
        return "El viaje no existe.", 404

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Finalizar viaje</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Finalizar viaje #{{ viaje.id_viaje }}</h1>

        <p><strong>Conductor:</strong> {{ viaje.conductor }}</p>
        <p><strong>Origen:</strong> {{ viaje.origen }}</p>
        <p><strong>Destino:</strong> {{ viaje.destino }}</p>
        <p><strong>Distancia:</strong> {{ viaje.distancia_km }} km</p>
        <p><strong>Estado:</strong> {{ viaje.estado }}</p>

        {% if error %}
            <p style="color: red;">{{ error }}</p>
        {% endif %}

        {% if viaje.estado == 'EN_CURSO' %}
            <h2>Resumen del viaje</h2>

            <p>
                <strong>Importe estimado:</strong>
                {{ viaje.moneda }} {{ viaje.monto_estimado }}
            </p>

            <form method="POST">
                <button type="submit">Finalizar viaje</button>
            </form>

        {% elif viaje.estado == 'FINALIZADO' %}
            <h2>Viaje finalizado correctamente</h2>

            <p>
                <strong>Importe total:</strong>
                {{ viaje.moneda }} {{ viaje.monto_total }}
            </p>

            <p>
                <strong>Fecha de finalización:</strong>
                {{ viaje.fecha_fin }}
            </p>

        {% else %}
            <p>Este viaje todavía no puede finalizarse.</p>
        {% endif %}

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, viaje=viaje, error=error)


@app.route("/panel-conductor")
def panel_conductor():
    conexion = obtener_conexion()

    try:
        cursor = conexion.cursor(dictionary=True)
        try:
            cursor.execute("""
                SELECT
                    v.id_viaje,
                    v.origen,
                    v.destino,
                    v.estado,
                    ts.nombre_servicio,
                    CONCAT(p.nombres, ' ', p.apellidos) AS pasajero,
                    CONCAT(c.nombres, ' ', c.apellidos) AS conductor
                FROM VIAJE v
                INNER JOIN PASAJERO p
                    ON v.id_pasajero = p.id_pasajero
                INNER JOIN TARIFA_PAIS t
                    ON v.id_tarifa = t.id_tarifa
                INNER JOIN TIPO_SERVICIO ts
                    ON t.id_tipo_servicio = ts.id_tipo_servicio
                LEFT JOIN CONDUCTOR c
                    ON v.id_conductor = c.id_conductor
                ORDER BY v.id_viaje DESC
                LIMIT 30
            """)

            viajes = cursor.fetchall()
        finally:
            cursor.close()
    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Panel del conductor</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Panel del conductor</h1>
        <p>Consulta y gestión de solicitudes de viaje.</p>

        <table>
            <thead>
                <tr>
                    <th>Viaje</th>
                    <th>Pasajero</th>
                    <th>Origen</th>
                    <th>Destino</th>
                    <th>Servicio</th>
                    <th>Conductor</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                {% for v in viajes %}
                <tr>
                    <td>{{ v.id_viaje }}</td>
                    <td>{{ v.pasajero }}</td>
                    <td>{{ v.origen }}</td>
                    <td>{{ v.destino }}</td>
                    <td>{{ v.nombre_servicio }}</td>
                    <td>{{ v.conductor or 'Sin asignar' }}</td>
                    <td>{{ v.estado }}</td>
                    <td>
                        {% if v.estado == 'SOLICITADO' %}
                            <a href="{{ url_for(
                                'aceptar_viaje',
                                id_viaje=v.id_viaje
                            ) }}">Aceptar</a>

                        {% elif v.estado == 'ACEPTADO' %}
                            <a href="{{ url_for(
                                'iniciar_viaje',
                                id_viaje=v.id_viaje
                            ) }}">Iniciar</a>

                        {% elif v.estado == 'EN_CURSO' %}
                            <a href="{{ url_for(
                                'finalizar_viaje',
                                id_viaje=v.id_viaje
                            ) }}">Finalizar</a>

                        {% else %}
                            Sin acciones
                        {% endif %}
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>

        <p><a href="/">Volver al inicio</a></p>
    </body>
    </html>
    """, viajes=viajes)


@app.route("/historial-pasajero/<int:id_pasajero>")
def historial_pasajero(id_pasajero):
    conexion = obtener_conexion()

    try:
        cursor = conexion.cursor(dictionary=True)

        try:
            cursor.execute("""
                SELECT id_pasajero, nombres, apellidos
                FROM PASAJERO
                WHERE id_pasajero = %s
            """, (id_pasajero,))

            pasajero = cursor.fetchone()

            if pasajero is None:
                return "El pasajero no existe.", 404

            cursor.execute("""
                SELECT
                    v.id_viaje,
                    v.origen,
                    v.destino,
                    v.distancia_km,
                    v.estado,
                    v.monto_total,
                    v.fecha_solicitud,
                    pa.moneda,
                    ts.nombre_servicio
                FROM VIAJE v
                INNER JOIN TARIFA_PAIS t
                    ON v.id_tarifa = t.id_tarifa
                INNER JOIN PAIS pa
                    ON t.id_pais = pa.id_pais
                INNER JOIN TIPO_SERVICIO ts
                    ON t.id_tipo_servicio = ts.id_tipo_servicio
                WHERE v.id_pasajero = %s
                ORDER BY v.fecha_solicitud DESC, v.id_viaje DESC
            """, (id_pasajero,))

            viajes = cursor.fetchall()

        finally:
            cursor.close()

    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Historial de viajes</title>
        <link rel="stylesheet"
              href="{{ url_for('static', filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Historial de viajes</h1>

        <h2>{{ pasajero.nombres }} {{ pasajero.apellidos }}</h2>

        <p>Viajes registrados: {{ viajes|length }}</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Origen</th>
                    <th>Destino</th>
                    <th>Servicio</th>
                    <th>Distancia</th>
                    <th>Estado</th>
                    <th>Importe</th>
                </tr>
            </thead>
            <tbody>
                {% for v in viajes %}
                <tr>
                    <td>{{ v.id_viaje }}</td>
                    <td>{{ v.origen }}</td>
                    <td>{{ v.destino }}</td>
                    <td>{{ v.nombre_servicio }}</td>
                    <td>
                        {% if v.distancia_km is not none %}
                            {{ v.distancia_km }} km
                        {% else %}
                            Pendiente
                        {% endif %}
                    </td>
                    <td>{{ v.estado }}</td>
                    <td>
                        {% if v.monto_total is not none %}
                            {{ v.moneda }} {{ v.monto_total }}
                        {% else %}
                            Pendiente
                        {% endif %}
                    </td>
                </tr>
                {% else %}
                <tr>
                    <td colspan="7">
                        Este pasajero todavía no tiene viajes.
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>

        <p><a href="/pasajeros">Volver a pasajeros</a></p>
    </body>
    </html>
    """, pasajero=pasajero, viajes=viajes)


@app.route("/panel-empresa/<int:id_empresa>")
def panel_empresa(id_empresa):
    conexion = obtener_conexion()

    try:
        cursor = conexion.cursor(dictionary=True)

        try:
            cursor.execute("""
                SELECT
                    e.id_empresa,
                    e.razon_social,
                    e.tipo_empresa,
                    p.nombre_pais,
                    p.moneda
                FROM EMPRESA e
                INNER JOIN PAIS p
                    ON e.id_pais = p.id_pais
                WHERE e.id_empresa = %s
            """, (id_empresa,))

            empresa = cursor.fetchone()

            if empresa is None:
                return "La empresa no existe.", 404

            if empresa["tipo_empresa"] != "CLIENTE":
                return render_template_string("""
                    <link rel="stylesheet"
                          href="{{ url_for('static',
                          filename='style.css') }}">

                    <h1>{{ empresa.razon_social }}</h1>
                    <p>Tipo: {{ empresa.tipo_empresa }}</p>
                    <p>Este panel corresponde a empresas
                       clientes corporativas.</p>
                    <a href="/empresas">Volver a empresas</a>
                """, empresa=empresa)

            cursor.execute("""
                SELECT
                    id_pasajero,
                    nombres,
                    apellidos,
                    email
                FROM PASAJERO
                WHERE id_empresa = %s
                ORDER BY nombres
            """, (id_empresa,))

            empleados = cursor.fetchall()

            cursor.execute("""
                SELECT
                    v.id_viaje,
                    CONCAT(p.nombres, ' ', p.apellidos)
                        AS pasajero,
                    v.origen,
                    v.destino,
                    v.estado,
                    v.monto_total
                FROM VIAJE v
                INNER JOIN PASAJERO p
                    ON v.id_pasajero = p.id_pasajero
                WHERE v.id_empresa = %s
                ORDER BY v.id_viaje DESC
            """, (id_empresa,))

            viajes = cursor.fetchall()

            cursor.execute("""
                SELECT
                    id_factura,
                    periodo_inicio,
                    periodo_fin,
                    monto_total,
                    moneda,
                    estado
                FROM FACTURA
                WHERE id_empresa = %s
                ORDER BY periodo_inicio DESC
            """, (id_empresa,))

            facturas = cursor.fetchall()

        finally:
            cursor.close()

    finally:
        conexion.close()

    return render_template_string("""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <title>RutaAndina - Panel de empresa</title>
        <link rel="stylesheet"
              href="{{ url_for('static',
              filename='style.css') }}">
    </head>
    


<body>
        {% include '_navbar.html' %}

        <h1>Panel de empresa</h1>
        <h2>{{ empresa.razon_social }}</h2>

        <p><strong>País:</strong> {{ empresa.nombre_pais }}</p>
        <p><strong>Moneda:</strong> {{ empresa.moneda }}</p>

        <h2>Empleados registrados</h2>
        <p>Total de empleados: {{ empleados|length }}</p>

        <table>
            <tr>
                <th>ID</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Correo electrónico</th>
            </tr>

            {% for e in empleados %}
            <tr>
                <td>{{ e.id_pasajero }}</td>
                <td>{{ e.nombres }}</td>
                <td>{{ e.apellidos }}</td>
                <td>{{ e.email }}</td>
            </tr>
            {% else %}
            <tr>
                <td colspan="4">Sin empleados registrados.</td>
            </tr>
            {% endfor %}
        </table>

        <h2>Viajes corporativos</h2>
        <p>Total de viajes: {{ viajes|length }}</p>

        <table>
            <tr>
                <th>ID</th>
                <th>Pasajero</th>
                <th>Origen</th>
                <th>Destino</th>
                <th>Estado</th>
                <th>Importe</th>
            </tr>

            {% for v in viajes %}
            <tr>
                <td>{{ v.id_viaje }}</td>
                <td>{{ v.pasajero }}</td>
                <td>{{ v.origen }}</td>
                <td>{{ v.destino }}</td>
                <td>{{ v.estado }}</td>
                <td>
                    {% if v.monto_total is not none %}
                        {{ empresa.moneda }} {{ v.monto_total }}
                    {% else %}
                        Pendiente
                    {% endif %}
                </td>
            </tr>
            {% else %}
            <tr>
                <td colspan="6">Sin viajes corporativos.</td>
            </tr>
            {% endfor %}
        </table>

        <h2>Facturación de la empresa</h2>

        <table>
            <tr>
                <th>Factura</th>
                <th>Inicio del periodo</th>
                <th>Fin del periodo</th>
                <th>Importe</th>
                <th>Estado</th>
            </tr>

            {% for f in facturas %}
            <tr>
                <td>{{ f.id_factura }}</td>
                <td>{{ f.periodo_inicio }}</td>
                <td>{{ f.periodo_fin }}</td>
                <td>{{ f.moneda }} {{ f.monto_total }}</td>
                <td>{{ f.estado }}</td>
            </tr>
            {% else %}
            <tr>
                <td colspan="5">Sin facturas registradas.</td>
            </tr>
            {% endfor %}
        </table>

        <p><a href="/empresas">Volver a empresas</a></p>

    </body>
    </html>
    """,
        empresa=empresa,
        empleados=empleados,
        viajes=viajes,
        facturas=facturas
    )


if __name__ == "__main__":
    app.run(debug=True)
