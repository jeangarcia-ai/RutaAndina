-- RUTAANDINA | 02_dml_RutaAndina_16_entidades.sql
-- Datos ficticios para un laboratorio academico (Peru y Colombia).
-- VERSION CONSOLIDADA de los bloques ya ejecutados en MySQL Workbench.
-- IMPORTANTE: NO ejecutar sobre rutaandina_nueva que ya contiene estos datos;
-- los INSERT con identificadores fijos produciran errores por duplicados.
-- Para reconstruir la base desde cero, crear primero las tablas del DDL
-- en una base VACIA y ejecutar este archivo UNA SOLA VEZ.
-- Los historiales generados son simulados, no una auditoria real de eventos.

USE rutaandina_nueva;


-- ====================================================================
-- 1. PAIS, TIPO_SERVICIO y TARIFA_PAIS
-- ====================================================================
INSERT INTO PAIS
    (id_pais, nombre_pais, codigo_iso, moneda, porcentaje_comision)
VALUES
    (1, 'Perú', 'PE', 'PEN', 20.0),
    (2, 'Colombia', 'CO', 'COP', 20.0);

INSERT INTO TIPO_SERVICIO
    (id_tipo_servicio, nombre_servicio, descripcion, capacidad)
VALUES
    (1, 'Económico', 'Servicio estándar', 4),
    (2, 'Confort', 'Servicio de mayor comodidad', 4),
    (3, 'XL', 'Servicio para grupos', 6);

INSERT INTO TARIFA_PAIS
    (id_tarifa, id_pais, id_tipo_servicio, tarifa_base, costo_km, costo_min)
VALUES
    (1, 1, 1, 4.0, 1.5, 0.25),
    (2, 1, 2, 6.0, 2.0, 0.35),
    (3, 1, 3, 8.0, 2.6, 0.5),
    (4, 2, 1, 5000.0, 1400.0, 150.0),
    (5, 2, 2, 6500.0, 1800.0, 200.0),
    (6, 2, 3, 8500.0, 2300.0, 250.0);


-- ====================================================================
-- 2. EMPRESA
-- ====================================================================
INSERT INTO EMPRESA
    (id_empresa, id_pais, razon_social, ruc_nit, tipo_empresa, telefono_contacto)
VALUES
    (1, 1, 'RutaAndina Operadora Peru SAC', '20600000001', 'OPERADORA', '+51 900000001'),
    (2, 1, 'Cliente Corporativo Andino SAC', '20600000002', 'CLIENTE', '+51 900000002'),
    (3, 1, 'Flota Costa Sur SAC', '20600000003', 'FLOTA', '+51 900000003'),
    (4, 2, 'Cliente Empresarial Bogota SAS', '900000004-1', 'CLIENTE', '+57 3000000004'),
    (5, 2, 'Flota Sabana SAS', '900000005-1', 'FLOTA', '+57 3000000005');


-- ====================================================================
-- 3. PASAJERO (20 registros)
-- ====================================================================
INSERT INTO PASAJERO
    (id_pasajero, id_pais, id_empresa, nombres, apellidos, tipo_documento, numero_documento, email, telefono)
VALUES
    (1, 1, 2, 'Lucia', 'Fernandez Rojas', 'DNI', '71000001', 'lucia01@ejemplo.test', '+51900000001'),
    (2, 1, NULL, 'Carlos', 'Mendoza Flores', 'DNI', '71000002', 'carlos02@ejemplo.test', '+51900000002'),
    (3, 1, 2, 'Andrea', 'Quispe Torres', 'DNI', '71000003', 'andrea03@ejemplo.test', '+51900000003'),
    (4, 1, NULL, 'Diego', 'Ramirez Soto', 'DNI', '71000004', 'diego04@ejemplo.test', '+51900000004'),
    (5, 1, 2, 'Valeria', 'Castillo Vega', 'DNI', '71000005', 'valeria05@ejemplo.test', '+51900000005'),
    (6, 1, NULL, 'Jorge', 'Salazar Medina', 'DNI', '71000006', 'jorge06@ejemplo.test', '+51900000006'),
    (7, 1, NULL, 'Mariana', 'Lopez Paredes', 'DNI', '71000007', 'mariana07@ejemplo.test', '+51900000007'),
    (8, 1, NULL, 'Sebastian', 'Garcia Ramos', 'DNI', '71000008', 'sebastian08@ejemplo.test', '+51900000008'),
    (9, 1, NULL, 'Camila', 'Vargas Chavez', 'DNI', '71000009', 'camila09@ejemplo.test', '+51900000009'),
    (10, 1, NULL, 'Fernando', 'Rojas Aguilar', 'DNI', '71000010', 'fernando10@ejemplo.test', '+51900000010'),
    (11, 2, 4, 'Sofia', 'Restrepo Gomez', 'CC', '1000000011', 'sofia11@ejemplo.test', '+573000000011'),
    (12, 2, 4, 'Mateo', 'Cardona Ruiz', 'CC', '1000000012', 'mateo12@ejemplo.test', '+573000000012'),
    (13, 2, NULL, 'Daniela', 'Moreno Lopez', 'CC', '1000000013', 'daniela13@ejemplo.test', '+573000000013'),
    (14, 2, NULL, 'Juan', 'Herrera Diaz', 'CC', '1000000014', 'juan14@ejemplo.test', '+573000000014'),
    (15, 2, 4, 'Isabella', 'Castro Torres', 'CC', '1000000015', 'isabella15@ejemplo.test', '+573000000015'),
    (16, 2, NULL, 'Santiago', 'Ortega Perez', 'CC', '1000000016', 'santiago16@ejemplo.test', '+573000000016'),
    (17, 2, NULL, 'Valentina', 'Rincon Morales', 'CC', '1000000017', 'valentina17@ejemplo.test', '+573000000017'),
    (18, 2, 4, 'Nicolas', 'Vargas Mejia', 'CC', '1000000018', 'nicolas18@ejemplo.test', '+573000000018'),
    (19, 2, NULL, 'Sara', 'Medina Romero', 'CC', '1000000019', 'sara19@ejemplo.test', '+573000000019'),
    (20, 2, NULL, 'Andres', 'Gomez Molina', 'CC', '1000000020', 'andres20@ejemplo.test', '+573000000020');


-- ====================================================================
-- 4. CONDUCTOR (10 registros)
-- ====================================================================
INSERT INTO CONDUCTOR
    (id_conductor, id_pais, id_empresa_flota, nombres, apellidos, numero_documento, telefono, num_licencia, categoria_licencia, venc_licencia, estado, cuenta_pago)
VALUES
    (1, 1, NULL, 'Miguel', 'Torres Rojas', '72000001', '+51910000001', 'LIC-PE-001', 'A-IIa', '2028-05-15', 'ACTIVO', 'CUENTA-DEMO-PE-001'),
    (2, 1, 3, 'Rosa', 'Mendoza Flores', '72000002', '+51910000002', 'LIC-PE-002', 'A-IIa', '2029-03-20', 'ACTIVO', 'CUENTA-DEMO-PE-002'),
    (3, 1, 3, 'Javier', 'Quispe Ramos', '72000003', '+51910000003', 'LIC-PE-003', 'A-IIb', '2028-11-10', 'ACTIVO', 'CUENTA-DEMO-PE-003'),
    (4, 1, NULL, 'Daniel', 'Castillo Vega', '72000004', '+51910000004', 'LIC-PE-004', 'A-IIa', '2029-07-25', 'ACTIVO', 'CUENTA-DEMO-PE-004'),
    (5, 1, NULL, 'Patricia', 'Salazar Medina', '72000005', '+51910000005', 'LIC-PE-005', 'A-IIb', '2028-09-18', 'ACTIVO', 'CUENTA-DEMO-PE-005'),
    (6, 2, 5, 'Andres', 'Restrepo Gomez', '2000000006', '+573100000006', 'LIC-CO-006', 'C1', '2028-06-12', 'ACTIVO', 'CUENTA-DEMO-CO-006'),
    (7, 2, 5, 'Camila', 'Cardona Ruiz', '2000000007', '+573100000007', 'LIC-CO-007', 'C1', '2029-02-28', 'ACTIVO', 'CUENTA-DEMO-CO-007'),
    (8, 2, NULL, 'Sebastian', 'Moreno Lopez', '2000000008', '+573100000008', 'LIC-CO-008', 'C1', '2028-08-14', 'ACTIVO', 'CUENTA-DEMO-CO-008'),
    (9, 2, NULL, 'Valentina', 'Herrera Diaz', '2000000009', '+573100000009', 'LIC-CO-009', 'C2', '2029-04-30', 'ACTIVO', 'CUENTA-DEMO-CO-009'),
    (10, 2, NULL, 'Nicolas', 'Castro Torres', '2000000010', '+573100000010', 'LIC-CO-010', 'C1', '2028-12-05', 'ACTIVO', 'CUENTA-DEMO-CO-010');


-- ====================================================================
-- 5. VEHICULO y ASIGNACION_VEHICULO (10 + 10)
-- ====================================================================
INSERT INTO VEHICULO
    (id_vehiculo, id_empresa_flota, id_conductor_propietario, id_tipo_servicio, placa, marca, modelo, anio, color, venc_soat)
VALUES
    (1, NULL, 1, 1, 'RTA-101', 'Toyota', 'Yaris', 2022, 'Blanco', '2028-06-15'),
    (2, 3, NULL, 2, 'RTA-102', 'Hyundai', 'Elantra', 2023, 'Negro', '2028-08-20'),
    (3, 3, NULL, 1, 'RTA-103', 'Kia', 'Rio', 2021, 'Gris', '2028-05-12'),
    (4, NULL, 4, 2, 'RTA-104', 'Toyota', 'Corolla', 2023, 'Azul', '2028-09-18'),
    (5, NULL, 5, 3, 'RTA-105', 'Kia', 'Carnival', 2024, 'Blanco', '2028-11-10'),
    (6, 5, NULL, 1, 'RTA106', 'Renault', 'Logan', 2022, 'Gris', '2028-07-25'),
    (7, 5, NULL, 2, 'RTA107', 'Mazda', '3', 2023, 'Rojo', '2028-10-14'),
    (8, NULL, 8, 1, 'RTA108', 'Chevrolet', 'Onix', 2022, 'Blanco', '2028-04-30'),
    (9, NULL, 9, 2, 'RTA109', 'Hyundai', 'Tucson', 2024, 'Negro', '2028-12-05'),
    (10, NULL, 10, 3, 'RTA110', 'Kia', 'Carnival', 2023, 'Azul', '2028-06-28');

INSERT INTO ASIGNACION_VEHICULO
    (id_asignacion, id_conductor, id_vehiculo, fecha_inicio, fecha_fin, es_activo)
VALUES
    (1, 1, 1, '2026-11-01', NULL, TRUE),
    (2, 2, 2, '2026-11-01', NULL, TRUE),
    (3, 3, 3, '2026-11-01', NULL, TRUE),
    (4, 4, 4, '2026-11-01', NULL, TRUE),
    (5, 5, 5, '2026-11-01', NULL, TRUE),
    (6, 6, 6, '2026-11-01', NULL, TRUE),
    (7, 7, 7, '2026-11-01', NULL, TRUE),
    (8, 8, 8, '2026-11-01', NULL, TRUE),
    (9, 9, 9, '2026-11-01', NULL, TRUE),
    (10, 10, 10, '2026-11-01', NULL, TRUE);


-- ====================================================================
-- 6. METODO_PAGO (25 registros)
-- ====================================================================
INSERT INTO METODO_PAGO
    (id_metodo_pago, id_pasajero, tipo_pago, detalle_enmascarado, es_predeterminado)
VALUES
    (1, 1, 'Tarjeta', 'Visa **** 1001', TRUE),
    (2, 2, 'Efectivo', 'Pago en efectivo', TRUE),
    (3, 3, 'Billetera', 'Yape', TRUE),
    (4, 4, 'Tarjeta', 'Visa **** 1004', TRUE),
    (5, 5, 'Billetera', 'Plin', TRUE),
    (6, 6, 'Efectivo', 'Pago en efectivo', TRUE),
    (7, 7, 'Tarjeta', 'Mastercard **** 1007', TRUE),
    (8, 8, 'Billetera', 'Yape', TRUE),
    (9, 9, 'Efectivo', 'Pago en efectivo', TRUE),
    (10, 10, 'Tarjeta', 'Visa **** 1010', TRUE),
    (11, 11, 'Tarjeta', 'Visa **** 2011', TRUE),
    (12, 12, 'Billetera', 'Nequi', TRUE),
    (13, 13, 'Efectivo', 'Pago en efectivo', TRUE),
    (14, 14, 'Tarjeta', 'Mastercard **** 2014', TRUE),
    (15, 15, 'Billetera', 'Daviplata', TRUE),
    (16, 16, 'Efectivo', 'Pago en efectivo', TRUE),
    (17, 17, 'Tarjeta', 'Visa **** 2017', TRUE),
    (18, 18, 'Billetera', 'Nequi', TRUE),
    (19, 19, 'Efectivo', 'Pago en efectivo', TRUE),
    (20, 20, 'Tarjeta', 'Mastercard **** 2020', TRUE),
    (21, 1, 'Billetera', 'Yape', FALSE),
    (22, 3, 'Efectivo', 'Pago en efectivo', FALSE),
    (23, 5, 'Tarjeta', 'Visa **** 1005', FALSE),
    (24, 11, 'Billetera', 'Nequi', FALSE),
    (25, 15, 'Tarjeta', 'Visa **** 2015', FALSE);


-- ====================================================================
-- 7. DIRECCION_FAVORITA (24 registros)
-- ====================================================================
INSERT INTO DIRECCION_FAVORITA
    (id_direccion, id_pasajero, alias, direccion_texto, latitud, longitud)
VALUES
    (1, 1, 'Casa', 'Av. Larco, Miraflores, Lima', NULL, NULL),
    (2, 2, 'Casa', 'Av. Brasil, Jesus Maria, Lima', NULL, NULL),
    (3, 3, 'Casa', 'Av. Arequipa, Lince, Lima', NULL, NULL),
    (4, 4, 'Casa', 'Av. Benavides, Surco, Lima', NULL, NULL),
    (5, 5, 'Casa', 'Av. La Marina, San Miguel, Lima', NULL, NULL),
    (6, 6, 'Casa', 'Av. Universitaria, Los Olivos, Lima', NULL, NULL),
    (7, 7, 'Casa', 'Av. Javier Prado, San Isidro, Lima', NULL, NULL),
    (8, 8, 'Casa', 'Av. Canada, La Victoria, Lima', NULL, NULL),
    (9, 9, 'Casa', 'Av. Angamos, Surquillo, Lima', NULL, NULL),
    (10, 10, 'Casa', 'Av. Faucett, Callao', NULL, NULL),
    (11, 11, 'Casa', 'Chapinero, Bogota, Colombia', NULL, NULL),
    (12, 12, 'Casa', 'Engativa, Bogota, Colombia', NULL, NULL),
    (13, 13, 'Casa', 'Usaquen, Bogota, Colombia', NULL, NULL),
    (14, 14, 'Casa', 'Suba, Bogota, Colombia', NULL, NULL),
    (15, 15, 'Casa', 'Teusaquillo, Bogota, Colombia', NULL, NULL),
    (16, 16, 'Casa', 'Fontibon, Bogota, Colombia', NULL, NULL),
    (17, 17, 'Casa', 'Kennedy, Bogota, Colombia', NULL, NULL),
    (18, 18, 'Casa', 'Barrios Unidos, Bogota, Colombia', NULL, NULL),
    (19, 19, 'Casa', 'Puente Aranda, Bogota, Colombia', NULL, NULL),
    (20, 20, 'Casa', 'Bosa, Bogota, Colombia', NULL, NULL),
    (21, 1, 'Trabajo', 'San Isidro, Lima, Peru', NULL, NULL),
    (22, 3, 'Trabajo', 'Miraflores, Lima, Peru', NULL, NULL),
    (23, 11, 'Trabajo', 'Centro Internacional, Bogota', NULL, NULL),
    (24, 15, 'Trabajo', 'Zona T, Bogota, Colombia', NULL, NULL);


-- ====================================================================
-- 8. VIAJE (50 registros)
-- ====================================================================
INSERT INTO VIAJE
    (id_viaje, id_pasajero, id_conductor, id_tarifa, id_empresa, origen, destino, distancia_km, monto_total, estado, fecha_solicitud, fecha_inicio, fecha_fin)
VALUES
    (1, 1, 1, 1, 2, 'Miraflores, Lima', 'San Isidro, Lima', 5, 16.5, 'FINALIZADO', '2026-11-10 08:50:00', '2026-11-10 09:00:00', '2026-11-10 09:20:00'),
    (2, 2, 2, 2, NULL, 'Surco, Lima', 'Miraflores, Lima', 5, 23, 'FINALIZADO', '2026-11-11 08:50:00', '2026-11-11 09:00:00', '2026-11-11 09:20:00'),
    (3, 3, 3, 1, 2, 'Lince, Lima', 'San Isidro, Lima', 5, 16.5, 'FINALIZADO', '2026-11-12 08:50:00', '2026-11-12 09:00:00', '2026-11-12 09:20:00'),
    (4, 4, 4, 2, NULL, 'San Miguel, Lima', 'Callao, Perú', 5, 23, 'FINALIZADO', '2026-11-13 08:50:00', '2026-11-13 09:00:00', '2026-11-13 09:20:00'),
    (5, 5, 5, 3, 2, 'Surco, Lima', 'La Molina, Lima', 5, 31, 'FINALIZADO', '2026-11-14 08:50:00', '2026-11-14 09:00:00', '2026-11-14 09:20:00'),
    (6, 11, 6, 4, 4, 'Chapinero, Bogotá', 'Teusaquillo, Bogotá', 5, 15000, 'FINALIZADO', '2026-11-15 08:50:00', '2026-11-15 09:00:00', '2026-11-15 09:20:00'),
    (7, 12, 7, 5, 4, 'Engativá, Bogotá', 'Fontibón, Bogotá', 5, 19500, 'FINALIZADO', '2026-11-16 08:50:00', '2026-11-16 09:00:00', '2026-11-16 09:20:00'),
    (8, 13, NULL, 4, NULL, 'Usaquén, Bogotá', 'Chapinero, Bogotá', NULL, NULL, 'SOLICITADO', '2026-11-23 20:00:00', NULL, NULL),
    (9, 14, NULL, 6, NULL, 'Suba, Bogotá', 'Fontibón, Bogotá', NULL, NULL, 'CANCELADO', '2026-11-19 08:00:00', NULL, NULL),
    (10, 15, 10, 6, 4, 'Teusaquillo, Bogotá', 'Usaquén, Bogotá', NULL, NULL, 'ACEPTADO', '2026-11-23 18:50:00', NULL, NULL),
    (11, 6, 1, 1, NULL, 'Los Olivos, Lima', 'San Miguel, Lima', 6, 18, 'FINALIZADO', '2026-11-07 09:50:00', '2026-11-07 10:00:00', '2026-11-07 10:20:00'),
    (12, 7, 2, 2, NULL, 'San Isidro, Lima', 'Miraflores, Lima', 8, 30.75, 'FINALIZADO', '2026-11-08 13:50:00', '2026-11-08 14:00:00', '2026-11-08 14:25:00'),
    (13, 8, 3, 1, NULL, 'La Victoria, Lima', 'Lince, Lima', 4, 13.75, 'FINALIZADO', '2026-11-09 07:50:00', '2026-11-09 08:00:00', '2026-11-09 08:15:00'),
    (14, 9, 4, 2, NULL, 'Surquillo, Lima', 'Surco, Lima', 7, 27, 'FINALIZADO', '2026-11-10 16:50:00', '2026-11-10 17:00:00', '2026-11-10 17:20:00'),
    (15, 10, 5, 3, NULL, 'Callao, Perú', 'San Isidro, Lima', 9, 46.4, 'FINALIZADO', '2026-11-11 10:50:00', '2026-11-11 11:00:00', '2026-11-11 11:30:00'),
    (16, 16, 6, 4, NULL, 'Fontibón, Bogotá', 'Chapinero, Bogotá', 6, 16400, 'FINALIZADO', '2026-11-12 08:50:00', '2026-11-12 09:00:00', '2026-11-12 09:20:00'),
    (17, 17, 7, 5, NULL, 'Kennedy, Bogotá', 'Teusaquillo, Bogotá', 8, 25900, 'FINALIZADO', '2026-11-13 13:50:00', '2026-11-13 14:00:00', '2026-11-13 14:25:00'),
    (18, 18, 8, 4, 4, 'Barrios Unidos, Bogotá', 'Chapinero, Bogotá', 5, 15000, 'FINALIZADO', '2026-11-14 09:50:00', '2026-11-14 10:00:00', '2026-11-14 10:20:00'),
    (19, 19, NULL, 4, NULL, 'Puente Aranda, Bogotá', 'Suba, Bogotá', NULL, NULL, 'CANCELADO', '2026-11-20 12:00:00', NULL, NULL),
    (20, 20, 9, 5, NULL, 'Bosa, Bogotá', 'Fontibón, Bogotá', NULL, NULL, 'EN_CURSO', '2026-11-23 20:50:00', '2026-11-23 21:00:00', NULL),
    (21, 1, 2, 2, 2, 'Miraflores, Lima', 'San Borja, Lima', 6, 25.7, 'FINALIZADO', '2026-11-12 08:45:00', '2026-11-12 09:00:00', '2026-11-12 09:22:00'),
    (22, 2, 1, 1, NULL, 'Jesus Maria, Lima', 'San Isidro, Lima', 7, 20.5, 'FINALIZADO', '2026-11-14 09:45:00', '2026-11-14 10:00:00', '2026-11-14 10:24:00'),
    (23, 3, 5, 3, 2, 'Lince, Lima', 'La Molina, Lima', 9, 46.4, 'FINALIZADO', '2026-11-18 10:45:00', '2026-11-18 11:00:00', '2026-11-18 11:30:00'),
    (24, 6, 4, 2, NULL, 'Los Olivos, Lima', 'San Miguel, Lima', 4, 19.25, 'FINALIZADO', '2026-11-16 07:45:00', '2026-11-16 08:00:00', '2026-11-16 08:15:00'),
    (25, 7, 3, 1, NULL, 'San Isidro, Lima', 'Surquillo, Lima', 6, 17.5, 'FINALIZADO', '2026-11-19 13:45:00', '2026-11-19 14:00:00', '2026-11-19 14:18:00'),
    (26, 11, 6, 4, 4, 'Chapinero, Bogota', 'Suba, Bogota', 7, 18550, 'FINALIZADO', '2026-11-17 08:45:00', '2026-11-17 09:00:00', '2026-11-17 09:25:00'),
    (27, 12, 10, 6, 4, 'Engativa, Bogota', 'Usaquen, Bogota', 8, 34400, 'FINALIZADO', '2026-11-18 09:45:00', '2026-11-18 10:00:00', '2026-11-18 10:30:00'),
    (28, 14, 8, 4, NULL, 'Suba, Bogota', 'Chapinero, Bogota', 6, 16400, 'FINALIZADO', '2026-11-21 10:45:00', '2026-11-21 11:00:00', '2026-11-21 11:20:00'),
    (29, 16, NULL, 4, NULL, 'Fontibon, Bogota', 'Teusaquillo, Bogota', NULL, NULL, 'SOLICITADO', '2026-11-23 20:30:00', NULL, NULL),
    (30, 19, NULL, 5, NULL, 'Puente Aranda, Bogota', 'Kennedy, Bogota', NULL, NULL, 'CANCELADO', '2026-11-22 10:00:00', NULL, NULL),
    (31, 4, 1, 1, NULL, 'Surco, Lima', 'San Isidro, Lima', 7, 20, 'FINALIZADO', '2026-11-15 09:45:00', '2026-11-15 10:00:00', '2026-11-15 10:22:00'),
    (32, 5, 2, 2, 2, 'San Miguel, Lima', 'Miraflores, Lima', 8, 30.4, 'FINALIZADO', '2026-11-16 08:45:00', '2026-11-16 09:00:00', '2026-11-16 09:24:00'),
    (33, 8, 3, 1, NULL, 'La Victoria, Lima', 'Lince, Lima', 5, 16, 'FINALIZADO', '2026-11-17 10:45:00', '2026-11-17 11:00:00', '2026-11-17 11:18:00'),
    (34, 9, 4, 2, NULL, 'Surquillo, Lima', 'La Molina, Lima', 10, 36.5, 'FINALIZADO', '2026-11-18 12:45:00', '2026-11-18 13:00:00', '2026-11-18 13:30:00'),
    (35, 10, 5, 3, NULL, 'Callao, Peru', 'San Miguel, Lima', 6, 33.6, 'FINALIZADO', '2026-11-19 14:45:00', '2026-11-19 15:00:00', '2026-11-19 15:20:00'),
    (36, 13, 6, 4, NULL, 'Usaquen, Bogota', 'Chapinero, Bogota', 7, 18400, 'FINALIZADO', '2026-11-16 07:45:00', '2026-11-16 08:00:00', '2026-11-16 08:24:00'),
    (37, 15, 7, 5, 4, 'Teusaquillo, Bogota', 'Fontibon, Bogota', 9, 28700, 'FINALIZADO', '2026-11-17 08:45:00', '2026-11-17 09:00:00', '2026-11-17 09:30:00'),
    (38, 17, 10, 6, NULL, 'Kennedy, Bogota', 'Suba, Bogota', 6, 27800, 'FINALIZADO', '2026-11-20 09:45:00', '2026-11-20 10:00:00', '2026-11-20 10:22:00'),
    (39, 18, NULL, 5, NULL, 'Barrios Unidos, Bogota', 'Chapinero, Bogota', NULL, NULL, 'SOLICITADO', '2026-11-23 21:10:00', NULL, NULL),
    (40, 16, NULL, 4, NULL, 'Fontibon, Bogota', 'Kennedy, Bogota', NULL, NULL, 'CANCELADO', '2026-11-22 11:00:00', NULL, NULL),
    (41, 1, 1, 1, 2, 'Miraflores, Lima', 'San Borja, Lima', 8, 21, 'FINALIZADO', '2026-11-20 08:45:00', '2026-11-20 09:00:00', '2026-11-20 09:20:00'),
    (42, 2, 2, 2, NULL, 'Jesus Maria, Lima', 'Surco, Lima', 6, 26.75, 'FINALIZADO', '2026-11-20 09:45:00', '2026-11-20 10:00:00', '2026-11-20 10:25:00'),
    (43, 3, 3, 1, 2, 'Lince, Lima', 'San Isidro, Lima', 4, 13.75, 'FINALIZADO', '2026-11-21 07:45:00', '2026-11-21 08:00:00', '2026-11-21 08:15:00'),
    (44, 5, 5, 3, 2, 'San Miguel, Lima', 'La Molina, Lima', 10, 49, 'FINALIZADO', '2026-11-21 10:45:00', '2026-11-21 11:00:00', '2026-11-21 11:30:00'),
    (45, 11, 6, 4, 4, 'Chapinero, Bogota', 'Teusaquillo, Bogota', 5, 15000, 'FINALIZADO', '2026-11-20 08:45:00', '2026-11-20 09:00:00', '2026-11-20 09:20:00'),
    (46, 12, 7, 5, 4, 'Engativa, Bogota', 'Usaquen, Bogota', 7, 24100, 'FINALIZADO', '2026-11-20 09:45:00', '2026-11-20 10:00:00', '2026-11-20 10:25:00'),
    (47, 18, 8, 4, 4, 'Barrios Unidos, Bogota', 'Suba, Bogota', 6, 16400, 'FINALIZADO', '2026-11-21 07:45:00', '2026-11-21 08:00:00', '2026-11-21 08:20:00'),
    (48, 20, 10, 6, NULL, 'Bosa, Bogota', 'Chapinero, Bogota', 9, 36700, 'FINALIZADO', '2026-11-21 10:45:00', '2026-11-21 11:00:00', '2026-11-21 11:30:00'),
    (49, 9, NULL, 1, NULL, 'Surquillo, Lima', 'San Isidro, Lima', NULL, NULL, 'SOLICITADO', '2026-11-23 21:30:00', NULL, NULL),
    (50, 14, NULL, 5, NULL, 'Suba, Bogota', 'Kennedy, Bogota', NULL, NULL, 'CANCELADO', '2026-11-22 12:00:00', NULL, NULL);


-- ====================================================================
-- 9. PAGO (39 viajes finalizados)
-- ====================================================================
-- Se omite el viaje si ya cuenta con pago, por seguridad.
INSERT INTO PAGO
    (id_viaje, id_metodo_pago, monto_bruto, comision_app,
     moneda, estado_pago, fecha_pago)
SELECT
    v.id_viaje,
    CASE WHEN v.id_empresa IS NULL THEN mp.id_metodo_pago ELSE NULL END,
    v.monto_total,
    ROUND(v.monto_total * pa.porcentaje_comision / 100, 2),
    pa.moneda,
    CASE WHEN v.id_empresa IS NULL THEN 'COMPLETADO' ELSE 'PENDIENTE' END,
    CASE WHEN v.id_empresa IS NULL THEN v.fecha_fin ELSE NULL END
FROM VIAJE v
JOIN TARIFA_PAIS t ON t.id_tarifa = v.id_tarifa
JOIN PAIS pa ON pa.id_pais = t.id_pais
LEFT JOIN METODO_PAGO mp
  ON mp.id_pasajero = v.id_pasajero AND mp.es_predeterminado = TRUE
LEFT JOIN PAGO existente ON existente.id_viaje = v.id_viaje
WHERE v.estado = 'FINALIZADO'
  AND existente.id_pago IS NULL
  AND (v.id_empresa IS NOT NULL OR mp.id_metodo_pago IS NOT NULL);


-- ====================================================================
-- 10. CALIFICACION (20 registros)
-- ====================================================================
INSERT INTO CALIFICACION
    (id_viaje, puntaje_conductor, comentario_conductor, puntaje_pasajero, comentario_pasajero)
VALUES
    (1, 5, 'Conduccion segura y puntual', 5, 'Pasajero respetuoso'),
    (2, 4, 'Buen servicio', 5, 'Pasajero amable'),
    (3, 5, 'Excelente atencion', 4, 'Viaje sin inconvenientes'),
    (4, 4, 'Conductor puntual', 5, 'Buena comunicacion'),
    (5, 5, 'Vehiculo comodo', 5, 'Pasajero cordial'),
    (6, 5, 'Excelente conductor', 4, 'Pasajero respetuoso'),
    (7, 4, 'Servicio adecuado', 5, 'Buen trato'),
    (11, 5, 'Conductor responsable', 5, 'Pasajero puntual'),
    (12, 4, 'Viaje tranquilo', 4, 'Sin inconvenientes'),
    (13, 5, 'Excelente experiencia', 5, 'Pasajero amable'),
    (14, 3, 'El viaje tuvo una demora', 4, 'Buena comunicacion'),
    (15, 5, 'Vehiculo limpio', 5, 'Pasajero respetuoso'),
    (16, 4, 'Buen recorrido', 5, 'Pasajero puntual'),
    (17, 5, 'Excelente servicio', 4, 'Viaje satisfactorio'),
    (18, 4, 'Conductor amable', 5, 'Pasajero cordial'),
    (21, 5, 'Muy buen servicio', 5, 'Pasajero respetuoso'),
    (22, 4, 'Conduccion segura', NULL, NULL),
    (23, 5, 'Excelente atencion', NULL, NULL),
    (24, NULL, NULL, 5, 'Pasajero amable'),
    (25, NULL, NULL, 4, 'Viaje sin inconvenientes');


-- ====================================================================
-- 11. FACTURA (2 facturas, 18 viajes corporativos)
-- ====================================================================
INSERT INTO FACTURA
    (id_empresa, periodo_inicio, periodo_fin, fecha_emision,
     monto_total, moneda, estado)
SELECT
    v.id_empresa,
    '2026-11-01', '2026-11-23', '2026-11-23',
    SUM(p.monto_bruto), pa.moneda, 'PENDIENTE'
FROM VIAJE v
JOIN PAGO p ON p.id_viaje = v.id_viaje
JOIN TARIFA_PAIS t ON t.id_tarifa = v.id_tarifa
JOIN PAIS pa ON pa.id_pais = t.id_pais
WHERE v.id_empresa IS NOT NULL
  AND v.estado = 'FINALIZADO'
  AND p.estado_pago = 'PENDIENTE'
  AND v.fecha_fin >= '2026-11-01'
  AND v.fecha_fin < '2026-11-24'
  AND v.id_factura IS NULL
GROUP BY v.id_empresa, pa.moneda;

UPDATE VIAJE v
JOIN TARIFA_PAIS t ON t.id_tarifa = v.id_tarifa
JOIN PAIS pa ON pa.id_pais = t.id_pais
JOIN FACTURA f
  ON f.id_empresa = v.id_empresa
 AND f.moneda = pa.moneda
 AND v.fecha_fin >= f.periodo_inicio
 AND v.fecha_fin < DATE_ADD(f.periodo_fin, INTERVAL 1 DAY)
SET v.id_factura = f.id_factura
WHERE v.estado = 'FINALIZADO' AND v.id_factura IS NULL;


-- ====================================================================
-- 12. LIQUIDACION (9 conductores con pagos completados)
-- ====================================================================
INSERT INTO LIQUIDACION
    (id_conductor, periodo_inicio, periodo_fin, monto_bruto,
     comision, monto_neto, moneda, estado)
SELECT
    v.id_conductor,
    '2026-11-01', '2026-11-23',
    ROUND(SUM(p.monto_bruto), 2),
    ROUND(SUM(p.comision_app), 2),
    ROUND(SUM(p.monto_bruto - p.comision_app), 2),
    p.moneda, 'PENDIENTE'
FROM PAGO p
JOIN VIAJE v ON v.id_viaje = p.id_viaje
WHERE p.estado_pago = 'COMPLETADO'
  AND v.estado = 'FINALIZADO'
  AND v.id_conductor IS NOT NULL
  AND p.fecha_pago >= '2026-11-01'
  AND p.fecha_pago < '2026-11-24'
  AND NOT EXISTS (
      SELECT 1 FROM LIQUIDACION l
      WHERE l.id_conductor = v.id_conductor
        AND l.periodo_inicio = '2026-11-01'
        AND l.periodo_fin = '2026-11-23'
        AND l.moneda = p.moneda
  )
GROUP BY v.id_conductor, p.moneda;


-- ====================================================================
-- 13. HISTORIAL_ESTADO_VIAJE (175 registros simulados)
-- ====================================================================
-- Inicial: todos los viajes fueron solicitados.
INSERT INTO HISTORIAL_ESTADO_VIAJE
    (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
SELECT v.id_viaje, NULL, 'SOLICITADO', v.fecha_solicitud
FROM VIAJE v
WHERE NOT EXISTS (
    SELECT 1 FROM HISTORIAL_ESTADO_VIAJE h
    WHERE h.id_viaje = v.id_viaje AND h.estado_anterior IS NULL
);

-- Aceptacion: 41 viajes.
INSERT INTO HISTORIAL_ESTADO_VIAJE
    (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
SELECT v.id_viaje, 'SOLICITADO', 'ACEPTADO',
       CASE WHEN v.fecha_inicio IS NOT NULL
            THEN DATE_SUB(v.fecha_inicio, INTERVAL 5 MINUTE)
            ELSE DATE_ADD(v.fecha_solicitud, INTERVAL 5 MINUTE) END
FROM VIAJE v
WHERE v.estado IN ('ACEPTADO', 'EN_CURSO', 'FINALIZADO')
  AND NOT EXISTS (
      SELECT 1 FROM HISTORIAL_ESTADO_VIAJE h
      WHERE h.id_viaje = v.id_viaje AND h.estado_nuevo = 'ACEPTADO'
  );

-- Inicio de ruta: 40 viajes.
INSERT INTO HISTORIAL_ESTADO_VIAJE
    (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
SELECT v.id_viaje, 'ACEPTADO', 'EN_CURSO', v.fecha_inicio
FROM VIAJE v
WHERE v.estado IN ('EN_CURSO', 'FINALIZADO')
  AND v.fecha_inicio IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM HISTORIAL_ESTADO_VIAJE h
      WHERE h.id_viaje = v.id_viaje AND h.estado_nuevo = 'EN_CURSO'
  );

-- Viajes terminados: 39.
INSERT INTO HISTORIAL_ESTADO_VIAJE
    (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
SELECT v.id_viaje, 'EN_CURSO', 'FINALIZADO', v.fecha_fin
FROM VIAJE v
WHERE v.estado = 'FINALIZADO'
  AND v.fecha_fin IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM HISTORIAL_ESTADO_VIAJE h
      WHERE h.id_viaje = v.id_viaje AND h.estado_nuevo = 'FINALIZADO'
  );

-- Cancelaciones: 5.
INSERT INTO HISTORIAL_ESTADO_VIAJE
    (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
SELECT v.id_viaje, 'SOLICITADO', 'CANCELADO',
       DATE_ADD(v.fecha_solicitud, INTERVAL 2 MINUTE)
FROM VIAJE v
WHERE v.estado = 'CANCELADO'
  AND NOT EXISTS (
      SELECT 1 FROM HISTORIAL_ESTADO_VIAJE h
      WHERE h.id_viaje = v.id_viaje AND h.estado_nuevo = 'CANCELADO'
  );


-- ====================================================================
-- 14. VERIFICACIONES FINALES
-- ====================================================================
-- 16 entidades y sus cantidades de registros.
SELECT 'PAIS' AS tabla, COUNT(*) AS registros FROM PAIS
UNION ALL SELECT 'TIPO_SERVICIO', COUNT(*) FROM TIPO_SERVICIO
UNION ALL SELECT 'TARIFA_PAIS', COUNT(*) FROM TARIFA_PAIS
UNION ALL SELECT 'EMPRESA', COUNT(*) FROM EMPRESA
UNION ALL SELECT 'PASAJERO', COUNT(*) FROM PASAJERO
UNION ALL SELECT 'CONDUCTOR', COUNT(*) FROM CONDUCTOR
UNION ALL SELECT 'VEHICULO', COUNT(*) FROM VEHICULO
UNION ALL SELECT 'ASIGNACION_VEHICULO', COUNT(*) FROM ASIGNACION_VEHICULO
UNION ALL SELECT 'METODO_PAGO', COUNT(*) FROM METODO_PAGO
UNION ALL SELECT 'DIRECCION_FAVORITA', COUNT(*) FROM DIRECCION_FAVORITA
UNION ALL SELECT 'VIAJE', COUNT(*) FROM VIAJE
UNION ALL SELECT 'PAGO', COUNT(*) FROM PAGO
UNION ALL SELECT 'CALIFICACION', COUNT(*) FROM CALIFICACION
UNION ALL SELECT 'FACTURA', COUNT(*) FROM FACTURA
UNION ALL SELECT 'LIQUIDACION', COUNT(*) FROM LIQUIDACION
UNION ALL SELECT 'HISTORIAL_ESTADO_VIAJE', COUNT(*) FROM HISTORIAL_ESTADO_VIAJE;

SELECT
    COUNT(*) AS total_viajes,
    SUM(estado = 'FINALIZADO') AS finalizados,
    SUM(estado = 'SOLICITADO') AS solicitados,
    SUM(estado = 'ACEPTADO') AS aceptados,
    SUM(estado = 'EN_CURSO') AS en_curso,
    SUM(estado = 'CANCELADO') AS cancelados
FROM VIAJE;

SELECT COUNT(*) AS total_historial,
       COUNT(DISTINCT id_viaje) AS viajes_con_historial
FROM HISTORIAL_ESTADO_VIAJE;

-- Pendiente de la siguiente etapa:
-- 1) Triggers que validen transiciones de viaje y generen historial REAL.
-- 2) Validar calificaciones solo para viajes finalizados.
-- 3) Validar licencia/SOAT y correspondencia pasajero/empresa/servicio.
-- 4) Comprobar importes de tarifas, facturas y liquidaciones.
