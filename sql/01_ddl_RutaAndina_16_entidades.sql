-- RUTAANDINA | 01_ddl.sql | Diccionario actualizado: 16 entidades
-- MySQL Server 8.0+.
-- Archivo consolidado a partir de los bloques ejecutados en MySQL Workbench.
-- IMPORTANTE: NO volver a ejecutar sobre la base actual: las tablas ya existen.
-- El archivo no elimina tablas ni bases de datos.

CREATE DATABASE IF NOT EXISTS rutaandina_nueva
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE rutaandina_nueva;

-- 01: PAIS
CREATE TABLE PAIS (
 id_pais INT AUTO_INCREMENT PRIMARY KEY,
 nombre_pais VARCHAR(60) NOT NULL,
 codigo_iso CHAR(2) NOT NULL UNIQUE,
 moneda CHAR(3) NOT NULL,
 porcentaje_comision DECIMAL(5,2) NOT NULL,
 CHECK (moneda IN ('PEN','COP')),
 CHECK (porcentaje_comision BETWEEN 0 AND 100)
);

-- 02: TIPO_SERVICIO
CREATE TABLE TIPO_SERVICIO (
 id_tipo_servicio INT AUTO_INCREMENT PRIMARY KEY,
 nombre_servicio VARCHAR(50) NOT NULL UNIQUE,
 descripcion VARCHAR(200),
 capacidad INT NOT NULL,
 CHECK (capacidad > 0)
);

-- 03: TARIFA_PAIS
CREATE TABLE TARIFA_PAIS (
 id_tarifa INT AUTO_INCREMENT PRIMARY KEY,
 id_pais INT NOT NULL,
 id_tipo_servicio INT NOT NULL,
 tarifa_base DECIMAL(12,2) NOT NULL,
 costo_km DECIMAL(12,2) NOT NULL,
 costo_min DECIMAL(12,2) NOT NULL,
 FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais),
 FOREIGN KEY (id_tipo_servicio) REFERENCES TIPO_SERVICIO(id_tipo_servicio),
 UNIQUE (id_pais,id_tipo_servicio),
 CHECK (tarifa_base >= 0 AND costo_km >= 0 AND costo_min >= 0)
);

-- 04: EMPRESA
CREATE TABLE EMPRESA (
 id_empresa INT AUTO_INCREMENT PRIMARY KEY,
 id_pais INT NOT NULL,
 razon_social VARCHAR(120) NOT NULL,
 ruc_nit VARCHAR(20) NOT NULL UNIQUE,
 tipo_empresa VARCHAR(20) NOT NULL,
 telefono_contacto VARCHAR(20),
 CONSTRAINT fk_empresa_pais FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais),
 CONSTRAINT chk_tipo_empresa CHECK (tipo_empresa IN ('OPERADORA','CLIENTE','FLOTA'))
);

-- 05: PASAJERO
CREATE TABLE PASAJERO (
 id_pasajero INT AUTO_INCREMENT PRIMARY KEY,
 id_pais INT NOT NULL,
 id_empresa INT NULL,
 nombres VARCHAR(60) NOT NULL,
 apellidos VARCHAR(60) NOT NULL,
 tipo_documento VARCHAR(15) NOT NULL,
 numero_documento VARCHAR(20) NOT NULL,
 email VARCHAR(100) NOT NULL UNIQUE,
 telefono VARCHAR(20) NOT NULL,
 CONSTRAINT fk_pasajero_pais FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais),
 CONSTRAINT fk_pasajero_empresa FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
 CONSTRAINT uq_documento_pasajero UNIQUE (id_pais,tipo_documento,numero_documento)
);

-- 06: DIRECCION_FAVORITA
CREATE TABLE DIRECCION_FAVORITA (
 id_direccion INT AUTO_INCREMENT PRIMARY KEY,
 id_pasajero INT NOT NULL,
 alias VARCHAR(50) NOT NULL,
 direccion_texto VARCHAR(200) NOT NULL,
 latitud DECIMAL(10,7),
 longitud DECIMAL(10,7),
 CONSTRAINT fk_direccion_pasajero FOREIGN KEY (id_pasajero) REFERENCES PASAJERO(id_pasajero),
 CONSTRAINT uq_alias_pasajero UNIQUE (id_pasajero,alias),
 CONSTRAINT chk_latitud CHECK (latitud BETWEEN -90 AND 90),
 CONSTRAINT chk_longitud CHECK (longitud BETWEEN -180 AND 180)
);

-- 07: METODO_PAGO
CREATE TABLE METODO_PAGO (
 id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
 id_pasajero INT NOT NULL,
 tipo_pago VARCHAR(20) NOT NULL,
 detalle_enmascarado VARCHAR(100),
 es_predeterminado BOOLEAN NOT NULL DEFAULT FALSE,
 CONSTRAINT fk_metodo_pago_pasajero FOREIGN KEY (id_pasajero) REFERENCES PASAJERO(id_pasajero),
 CONSTRAINT chk_tipo_pago CHECK (tipo_pago IN ('Tarjeta','Efectivo','Billetera'))
);
CREATE UNIQUE INDEX uq_pago_predeterminado
ON METODO_PAGO ((CASE WHEN es_predeterminado = TRUE THEN id_pasajero ELSE NULL END));

-- 08: CONDUCTOR
CREATE TABLE CONDUCTOR (
 id_conductor INT AUTO_INCREMENT PRIMARY KEY,
 id_pais INT NOT NULL,
 id_empresa_flota INT NULL,
 nombres VARCHAR(60) NOT NULL,
 apellidos VARCHAR(60) NOT NULL,
 numero_documento VARCHAR(20) NOT NULL,
 telefono VARCHAR(20) NOT NULL,
 num_licencia VARCHAR(30) NOT NULL UNIQUE,
 categoria_licencia VARCHAR(15) NOT NULL,
 venc_licencia DATE NOT NULL,
 estado VARCHAR(20) NOT NULL DEFAULT 'EN_REVISION',
 cuenta_pago VARCHAR(100),
 CONSTRAINT fk_conductor_pais FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais),
 CONSTRAINT fk_conductor_empresa FOREIGN KEY (id_empresa_flota) REFERENCES EMPRESA(id_empresa),
 CONSTRAINT uq_documento_conductor UNIQUE (id_pais,numero_documento),
 CONSTRAINT chk_estado_conductor CHECK (estado IN ('ACTIVO','SUSPENDIDO','EN_REVISION'))
);

-- 09: VEHICULO
CREATE TABLE VEHICULO (
 id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
 id_empresa_flota INT NULL,
 id_conductor_propietario INT NULL,
 id_tipo_servicio INT NOT NULL,
 placa VARCHAR(15) NOT NULL UNIQUE,
 marca VARCHAR(50) NOT NULL,
 modelo VARCHAR(50) NOT NULL,
 anio SMALLINT NOT NULL,
 color VARCHAR(30) NOT NULL,
 venc_soat DATE NOT NULL,
 CONSTRAINT fk_vehiculo_empresa FOREIGN KEY (id_empresa_flota) REFERENCES EMPRESA(id_empresa),
 CONSTRAINT fk_vehiculo_conductor FOREIGN KEY (id_conductor_propietario) REFERENCES CONDUCTOR(id_conductor),
 CONSTRAINT fk_vehiculo_servicio FOREIGN KEY (id_tipo_servicio) REFERENCES TIPO_SERVICIO(id_tipo_servicio),
 CONSTRAINT chk_propietario_vehiculo CHECK (
   (id_empresa_flota IS NOT NULL AND id_conductor_propietario IS NULL)
   OR (id_empresa_flota IS NULL AND id_conductor_propietario IS NOT NULL)
 ),
 CONSTRAINT chk_anio_vehiculo CHECK (anio BETWEEN 1900 AND 2100)
);

-- 10: ASIGNACION_VEHICULO
CREATE TABLE ASIGNACION_VEHICULO (
 id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
 id_conductor INT NOT NULL,
 id_vehiculo INT NOT NULL,
 fecha_inicio DATE NOT NULL,
 fecha_fin DATE NULL,
 es_activo BOOLEAN NOT NULL DEFAULT TRUE,
 CONSTRAINT fk_asignacion_conductor FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor),
 CONSTRAINT fk_asignacion_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo),
 CONSTRAINT chk_fechas_asignacion CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
 CONSTRAINT chk_asignacion_activa CHECK (
   (es_activo = TRUE AND fecha_fin IS NULL)
   OR (es_activo = FALSE AND fecha_fin IS NOT NULL)
 )
);
CREATE UNIQUE INDEX uq_conductor_activo ON ASIGNACION_VEHICULO
((CASE WHEN es_activo = TRUE THEN id_conductor ELSE NULL END));
CREATE UNIQUE INDEX uq_vehiculo_activo ON ASIGNACION_VEHICULO
((CASE WHEN es_activo = TRUE THEN id_vehiculo ELSE NULL END));

-- 11: FACTURA
CREATE TABLE FACTURA (
 id_factura INT AUTO_INCREMENT PRIMARY KEY,
 id_empresa INT NOT NULL,
 periodo_inicio DATE NOT NULL,
 periodo_fin DATE NOT NULL,
 fecha_emision DATE NOT NULL,
 monto_total DECIMAL(12,2) NOT NULL,
 moneda CHAR(3) NOT NULL,
 estado VARCHAR(20) NOT NULL,
 CONSTRAINT fk_factura_empresa FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
 CONSTRAINT chk_factura_periodo CHECK (periodo_fin >= periodo_inicio),
 CONSTRAINT chk_factura_monto CHECK (monto_total >= 0),
 CONSTRAINT chk_factura_moneda CHECK (moneda IN ('PEN','COP'))
);

-- 12: VIAJE
CREATE TABLE VIAJE (
 id_viaje INT AUTO_INCREMENT PRIMARY KEY,
 id_pasajero INT NOT NULL,
 id_conductor INT NULL,
 id_tarifa INT NOT NULL,
 id_empresa INT NULL,
 origen VARCHAR(200) NOT NULL,
 destino VARCHAR(200) NOT NULL,
 distancia_km DECIMAL(8,2),
 monto_total DECIMAL(12,2),
 estado VARCHAR(15) NOT NULL DEFAULT 'SOLICITADO',
 fecha_solicitud DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 fecha_inicio DATETIME NULL,
 fecha_fin DATETIME NULL,
 id_factura INT NULL,
 CONSTRAINT fk_viaje_pasajero FOREIGN KEY (id_pasajero) REFERENCES PASAJERO(id_pasajero),
 CONSTRAINT fk_viaje_conductor FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor),
 CONSTRAINT fk_viaje_tarifa FOREIGN KEY (id_tarifa) REFERENCES TARIFA_PAIS(id_tarifa),
 CONSTRAINT fk_viaje_empresa FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
 CONSTRAINT fk_viaje_factura FOREIGN KEY (id_factura) REFERENCES FACTURA(id_factura),
 CONSTRAINT chk_estado_viaje CHECK (estado IN ('SOLICITADO','ACEPTADO','EN_CURSO','FINALIZADO','CANCELADO')),
 CONSTRAINT chk_distancia_viaje CHECK (distancia_km >= 0),
 CONSTRAINT chk_monto_viaje CHECK (monto_total >= 0),
 CONSTRAINT chk_fecha_inicio_viaje CHECK (fecha_inicio IS NULL OR fecha_inicio >= fecha_solicitud),
 CONSTRAINT chk_fecha_fin_viaje CHECK (fecha_fin IS NULL OR (fecha_inicio IS NOT NULL AND fecha_fin >= fecha_inicio)),
 CONSTRAINT chk_factura_viaje CHECK (id_factura IS NULL OR id_empresa IS NOT NULL)
);

-- 13: PAGO
CREATE TABLE PAGO (
 id_pago INT AUTO_INCREMENT PRIMARY KEY,
 id_viaje INT NOT NULL UNIQUE,
 id_metodo_pago INT NULL,
 monto_bruto DECIMAL(12,2) NOT NULL,
 comision_app DECIMAL(12,2) NOT NULL,
 moneda CHAR(3) NOT NULL,
 estado_pago VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
 fecha_pago DATETIME NULL,
 CONSTRAINT fk_pago_viaje FOREIGN KEY (id_viaje) REFERENCES VIAJE(id_viaje),
 CONSTRAINT fk_pago_metodo FOREIGN KEY (id_metodo_pago) REFERENCES METODO_PAGO(id_metodo_pago),
 CONSTRAINT chk_pago_montos CHECK (monto_bruto > 0 AND comision_app >= 0 AND comision_app <= monto_bruto),
 CONSTRAINT chk_pago_moneda CHECK (moneda IN ('PEN','COP')),
 CONSTRAINT chk_pago_estado CHECK (estado_pago IN ('PENDIENTE','COMPLETADO','FALLIDO','REEMBOLSADO'))
);

-- 14: CALIFICACION
CREATE TABLE CALIFICACION (
 id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
 id_viaje INT NOT NULL UNIQUE,
 puntaje_conductor INT NULL,
 comentario_conductor VARCHAR(255),
 puntaje_pasajero INT NULL,
 comentario_pasajero VARCHAR(255),
 CONSTRAINT fk_calificacion_viaje FOREIGN KEY (id_viaje) REFERENCES VIAJE(id_viaje),
 CONSTRAINT chk_puntaje_conductor CHECK (puntaje_conductor BETWEEN 1 AND 5 OR puntaje_conductor IS NULL),
 CONSTRAINT chk_puntaje_pasajero CHECK (puntaje_pasajero BETWEEN 1 AND 5 OR puntaje_pasajero IS NULL),
 CONSTRAINT chk_calificacion_existente CHECK (puntaje_conductor IS NOT NULL OR puntaje_pasajero IS NOT NULL)
);

-- 15: LIQUIDACION
CREATE TABLE LIQUIDACION (
 id_liquidacion INT AUTO_INCREMENT PRIMARY KEY,
 id_conductor INT NOT NULL,
 periodo_inicio DATE NOT NULL,
 periodo_fin DATE NOT NULL,
 monto_bruto DECIMAL(12,2) NOT NULL,
 comision DECIMAL(12,2) NOT NULL,
 monto_neto DECIMAL(12,2) NOT NULL,
 moneda CHAR(3) NOT NULL,
 estado VARCHAR(20) NOT NULL,
 CONSTRAINT fk_liquidacion_conductor FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor),
 CONSTRAINT chk_liquidacion_periodo CHECK (periodo_fin >= periodo_inicio),
 CONSTRAINT chk_liquidacion_montos CHECK (monto_bruto > 0 AND comision >= 0 AND monto_neto >= 0),
 CONSTRAINT chk_liquidacion_moneda CHECK (moneda IN ('PEN','COP'))
);

-- 16: HISTORIAL_ESTADO_VIAJE
CREATE TABLE HISTORIAL_ESTADO_VIAJE (
 id_historial INT AUTO_INCREMENT PRIMARY KEY,
 id_viaje INT NOT NULL,
 estado_anterior VARCHAR(15) NULL,
 estado_nuevo VARCHAR(15) NOT NULL,
 fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_historial_viaje FOREIGN KEY (id_viaje) REFERENCES VIAJE(id_viaje),
 CONSTRAINT chk_historial_anterior CHECK (
   estado_anterior IS NULL OR estado_anterior IN ('SOLICITADO','ACEPTADO','EN_CURSO','FINALIZADO','CANCELADO')
 ),
 CONSTRAINT chk_historial_nuevo CHECK (estado_nuevo IN ('SOLICITADO','ACEPTADO','EN_CURSO','FINALIZADO','CANCELADO'))
);

SHOW TABLES;
