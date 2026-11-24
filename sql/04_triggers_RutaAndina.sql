-- RutaAndina - Triggers de reglas de negocio
-- Base de datos: rutaandina_nueva
-- Contiene los seis triggers que ya fueron creados y probados en MySQL Workbench.
-- Archivo de respaldo para reconstruir la BD en una instalacion nueva.
-- NO EJECUTAR en la BD actual: estos triggers ya existen.
-- En una BD nueva, ejecutar despues del DDL y de la carga inicial del DML.

USE rutaandina_nueva;

DELIMITER $$

-- 1. Guardar el estado inicial de cada nuevo viaje.
CREATE TRIGGER trg_viaje_historial_insert
AFTER INSERT ON VIAJE
FOR EACH ROW
BEGIN
    INSERT INTO HISTORIAL_ESTADO_VIAJE
        (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
    VALUES
        (NEW.id_viaje, NULL, NEW.estado, NOW());
END$$

-- 2. Guardar los cambios posteriores del estado del viaje.
CREATE TRIGGER trg_viaje_historial_update
AFTER UPDATE ON VIAJE
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO HISTORIAL_ESTADO_VIAJE
            (id_viaje, estado_anterior, estado_nuevo, fecha_cambio)
        VALUES
            (NEW.id_viaje, OLD.estado, NEW.estado, NOW());
    END IF;
END$$

-- 3. Impedir las transiciones no permitidas entre estados.
CREATE TRIGGER trg_validar_estado_viaje
BEFORE UPDATE ON VIAJE
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        IF NOT (
            (OLD.estado = 'SOLICITADO'
                AND NEW.estado IN ('ACEPTADO', 'CANCELADO'))
            OR (OLD.estado = 'ACEPTADO'
                AND NEW.estado IN ('EN_CURSO', 'CANCELADO'))
            OR (OLD.estado = 'EN_CURSO'
                AND NEW.estado IN ('FINALIZADO', 'CANCELADO'))
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transicion de estado no permitida';
        END IF;
    END IF;
END$$

-- 4. Validar conductor, vehiculo, licencia, seguro, pais y servicio
--    al aceptar o iniciar un viaje mediante UPDATE.
CREATE TRIGGER trg_validar_conductor_vehiculo
BEFORE UPDATE ON VIAJE
FOR EACH ROW
BEGIN
    DECLARE coincidencias INT DEFAULT 0;

    IF OLD.estado <> NEW.estado
       AND NEW.estado IN ('ACEPTADO', 'EN_CURSO') THEN

        IF NEW.id_conductor IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El viaje necesita un conductor asignado';
        END IF;

        SELECT COUNT(*) INTO coincidencias
        FROM CONDUCTOR c
        INNER JOIN ASIGNACION_VEHICULO av
            ON av.id_conductor = c.id_conductor
        INNER JOIN VEHICULO ve
            ON ve.id_vehiculo = av.id_vehiculo
        INNER JOIN TARIFA_PAIS t
            ON t.id_tarifa = NEW.id_tarifa
        INNER JOIN PASAJERO pa
            ON pa.id_pasajero = NEW.id_pasajero
        WHERE c.id_conductor = NEW.id_conductor
          AND c.estado = 'ACTIVO'
          AND c.venc_licencia >= CURDATE()
          AND ve.venc_soat >= CURDATE()
          AND av.es_activo = TRUE
          AND av.fecha_inicio <= CURDATE()
          AND av.fecha_fin IS NULL
          AND c.id_pais = t.id_pais
          AND pa.id_pais = t.id_pais
          AND ve.id_tipo_servicio = t.id_tipo_servicio;

        IF coincidencias = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Conductor o vehiculo no cumple requisitos';
        END IF;
    END IF;
END$$

-- 5. Permitir nuevas calificaciones solo para viajes finalizados.
CREATE TRIGGER trg_validar_calificacion_insert
BEFORE INSERT ON CALIFICACION
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM VIAJE
        WHERE id_viaje = NEW.id_viaje
          AND estado = 'FINALIZADO'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se puede calificar un viaje finalizado';
    END IF;
END$$

-- 6. Mantener la validacion al actualizar calificaciones.
CREATE TRIGGER trg_validar_calificacion_update
BEFORE UPDATE ON CALIFICACION
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM VIAJE
        WHERE id_viaje = NEW.id_viaje
          AND estado = 'FINALIZADO'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se puede calificar un viaje finalizado';
    END IF;
END$$

DELIMITER ;

-- Comprobar los triggers (solo consulta):
SHOW TRIGGERS FROM rutaandina_nueva;
