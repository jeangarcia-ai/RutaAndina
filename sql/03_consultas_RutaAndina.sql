-- RutaAndina - Consultas de negocio
-- Modelo: 16 entidades. Base de datos: rutaandina_nueva
-- Archivo de solo lectura: no modifica los registros.

USE rutaandina_nueva;

-- CONSULTA 1. Viajes finalizados por conductor
SELECT
    c.id_conductor,
    CONCAT(c.nombres, ' ', c.apellidos) AS conductor,
    p.nombre_pais AS pais,
    COUNT(v.id_viaje) AS viajes_finalizados
FROM CONDUCTOR c
INNER JOIN PAIS p ON c.id_pais = p.id_pais
INNER JOIN VIAJE v ON c.id_conductor = v.id_conductor
WHERE v.estado = 'FINALIZADO'
GROUP BY c.id_conductor, c.nombres, c.apellidos, p.nombre_pais
ORDER BY viajes_finalizados DESC;

-- CONSULTA 2. Ingresos de la plataforma por pais (solo pagos completados)
SELECT
    pa.nombre_pais AS pais,
    pa.moneda,
    COUNT(pg.id_pago) AS pagos_completados,
    SUM(pg.monto_bruto) AS ingresos_brutos,
    SUM(pg.comision_app) AS ingresos_plataforma
FROM PAGO pg
INNER JOIN VIAJE v ON pg.id_viaje = v.id_viaje
INNER JOIN TARIFA_PAIS t ON v.id_tarifa = t.id_tarifa
INNER JOIN PAIS pa ON t.id_pais = pa.id_pais
WHERE pg.estado_pago = 'COMPLETADO'
GROUP BY pa.nombre_pais, pa.moneda
ORDER BY pa.nombre_pais;

-- CONSULTA 3. Cinco conductores mejor calificados
SELECT
    c.id_conductor,
    CONCAT(c.nombres, ' ', c.apellidos) AS conductor,
    pa.nombre_pais AS pais,
    COUNT(cal.id_calificacion) AS calificaciones_recibidas,
    ROUND(AVG(cal.puntaje_conductor), 2) AS promedio_calificacion
FROM CALIFICACION cal
INNER JOIN VIAJE v ON cal.id_viaje = v.id_viaje
INNER JOIN CONDUCTOR c ON v.id_conductor = c.id_conductor
INNER JOIN PAIS pa ON c.id_pais = pa.id_pais
WHERE v.estado = 'FINALIZADO'
  AND cal.puntaje_conductor IS NOT NULL
GROUP BY c.id_conductor, c.nombres, c.apellidos, pa.nombre_pais
ORDER BY promedio_calificacion DESC, calificaciones_recibidas DESC
LIMIT 5;

-- CONSULTA 4. Consumo corporativo por empresa y factura
SELECT
    e.razon_social AS empresa,
    f.id_factura,
    f.periodo_inicio,
    f.periodo_fin,
    f.moneda,
    COUNT(v.id_viaje) AS viajes_facturados,
    ROUND(SUM(p.monto_bruto), 2) AS consumo_calculado,
    f.monto_total AS total_factura,
    f.estado
FROM FACTURA f
INNER JOIN EMPRESA e ON f.id_empresa = e.id_empresa
INNER JOIN VIAJE v ON v.id_factura = f.id_factura
INNER JOIN PAGO p ON p.id_viaje = v.id_viaje
WHERE e.tipo_empresa = 'CLIENTE'
GROUP BY e.razon_social, f.id_factura, f.periodo_inicio,
         f.periodo_fin, f.moneda, f.monto_total, f.estado
ORDER BY e.razon_social;

-- CONSULTA 5. Vigencia de licencias y SOAT de vehiculos asignados
SELECT
    c.id_conductor,
    CONCAT(c.nombres, ' ', c.apellidos) AS conductor,
    pa.nombre_pais AS pais,
    c.venc_licencia,
    ve.placa,
    ve.venc_soat,
    CASE
        WHEN c.venc_licencia < CURDATE() THEN 'VENCIDA'
        WHEN c.venc_licencia <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) THEN 'POR VENCER'
        ELSE 'VIGENTE'
    END AS estado_licencia,
    CASE
        WHEN ve.venc_soat < CURDATE() THEN 'VENCIDO'
        WHEN ve.venc_soat <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) THEN 'POR VENCER'
        ELSE 'VIGENTE'
    END AS estado_soat
FROM CONDUCTOR c
INNER JOIN PAIS pa ON c.id_pais = pa.id_pais
INNER JOIN ASIGNACION_VEHICULO av ON c.id_conductor = av.id_conductor
INNER JOIN VEHICULO ve ON av.id_vehiculo = ve.id_vehiculo
WHERE av.es_activo = TRUE
ORDER BY c.id_conductor;

-- CONSULTA 6. Porcentaje de cancelacion por tipo de servicio
SELECT
    ts.nombre_servicio AS tipo_servicio,
    COUNT(v.id_viaje) AS total_viajes,
    SUM(v.estado = 'CANCELADO') AS viajes_cancelados,
    ROUND(SUM(v.estado = 'CANCELADO') * 100.0 / COUNT(v.id_viaje), 2) AS porcentaje_cancelacion
FROM VIAJE v
INNER JOIN TARIFA_PAIS t ON v.id_tarifa = t.id_tarifa
INNER JOIN TIPO_SERVICIO ts ON t.id_tipo_servicio = ts.id_tipo_servicio
GROUP BY ts.id_tipo_servicio, ts.nombre_servicio
ORDER BY porcentaje_cancelacion DESC;

-- CONSULTA 7. Pasajeros con viajes finalizados que nunca calificaron al conductor
SELECT
    p.id_pasajero,
    CONCAT(p.nombres, ' ', p.apellidos) AS pasajero,
    pa.nombre_pais AS pais,
    COUNT(v.id_viaje) AS viajes_finalizados
FROM PASAJERO p
INNER JOIN PAIS pa ON p.id_pais = pa.id_pais
INNER JOIN VIAJE v ON p.id_pasajero = v.id_pasajero
LEFT JOIN CALIFICACION c ON v.id_viaje = c.id_viaje
WHERE v.estado = 'FINALIZADO'
GROUP BY p.id_pasajero, p.nombres, p.apellidos, pa.nombre_pais
HAVING SUM(CASE WHEN c.puntaje_conductor IS NOT NULL THEN 1 ELSE 0 END) = 0
ORDER BY viajes_finalizados DESC, pasajero;

-- CONSULTA 8. Historial de estados del viaje 1
SELECT
    v.id_viaje,
    CONCAT(p.nombres, ' ', p.apellidos) AS pasajero,
    v.estado AS estado_actual,
    h.estado_anterior,
    h.estado_nuevo,
    h.fecha_cambio
FROM VIAJE v
INNER JOIN PASAJERO p ON v.id_pasajero = p.id_pasajero
INNER JOIN HISTORIAL_ESTADO_VIAJE h ON v.id_viaje = h.id_viaje
WHERE v.id_viaje = 1
ORDER BY h.fecha_cambio, h.id_historial;


-- VISTA: Resumen de viajes por pasajero
-- Permite consultar los viajes y sus pasajeros.

CREATE OR REPLACE VIEW vista_viajes_pasajeros AS
SELECT
    v.id_viaje,
    p.id_pasajero,
    CONCAT(p.nombres, ' ', p.apellidos) AS pasajero,
    v.origen,
    v.destino,
    v.distancia_km,
    v.estado,
    v.monto_total
FROM VIAJE v
INNER JOIN PASAJERO p
    ON v.id_pasajero = p.id_pasajero;

-- Consulta de comprobación
SELECT *
FROM vista_viajes_pasajeros
LIMIT 10;
