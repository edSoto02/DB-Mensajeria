CREATE OR REPLACE FUNCTION insertar_usuario(
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_username VARCHAR,
    p_password VARCHAR,
    p_email VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO USUARIOS (nombre, apellido, username, password, email)
    VALUES (p_nombre, p_apellido, p_username, p_password, p_email);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION leer_usuarios()
RETURNS TABLE(idUsuario INT, nombre VARCHAR, apellido VARCHAR, username VARCHAR, email VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT idUsuario, nombre, apellido, username, email
    FROM USUARIOS;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_usuario(
    p_idUsuario INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_username VARCHAR,
    p_password VARCHAR,
    p_email VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE USUARIOS
    SET nombre = p_nombre,
        apellido = p_apellido,
        username = p_username,
        password = p_password,
        email = p_email
    WHERE idUsuario = p_idUsuario;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION borrar_usuario(p_idUsuario INT) RETURNS VOID AS $$
BEGIN
    DELETE FROM USUARIOS WHERE idUsuario = p_idUsuario;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertar_dispositivo(
    p_idUsuario INT,
    p_tipoDispositivo VARCHAR,
    p_claveDispositivo VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO DISPOSITIVOS (idUsuario, tipoDispositivo, claveDispositivo)
    VALUES (p_idUsuario, p_tipoDispositivo, p_claveDispositivo);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION leer_dispositivos()
RETURNS TABLE(idDispositivo INT, idUsuario INT, tipoDispositivo VARCHAR, claveDispositivo VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT idDispositivo, idUsuario, tipoDispositivo, claveDispositivo
    FROM DISPOSITIVOS;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_dispositivo(
    p_idDispositivo INT,
    p_idUsuario INT,
    p_tipoDispositivo VARCHAR,
    p_claveDispositivo VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE DISPOSITIVOS
    SET idUsuario = p_idUsuario,
        tipoDispositivo = p_tipoDispositivo,
        claveDispositivo = p_claveDispositivo
    WHERE idDispositivo = p_idDispositivo;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION borrar_dispositivo(p_idDispositivo INT) RETURNS VOID AS $$
BEGIN
    DELETE FROM DISPOSITIVOS WHERE idDispositivo = p_idDispositivo;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertar_contacto(
    p_idUsuario INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_telefono VARCHAR,
    p_email VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO CONTACTOS (idUsuario, nombre, apellido, telefono, email)
    VALUES (p_idUsuario, p_nombre, p_apellido, p_telefono, p_email);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION leer_contactos()
RETURNS TABLE(idContacto INT, idUsuario INT, nombre VARCHAR, apellido VARCHAR, telefono VARCHAR, email VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT idContacto, idUsuario, nombre, apellido, telefono, email
    FROM CONTACTOS;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_contacto(
    p_idContacto INT,
    p_idUsuario INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_telefono VARCHAR,
    p_email VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE CONTACTOS
    SET idUsuario = p_idUsuario,
        nombre = p_nombre,
        apellido = p_apellido,
        telefono = p_telefono,
        email = p_email
    WHERE idContacto = p_idContacto;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION borrar_contacto(p_idContacto INT) RETURNS VOID AS $$
BEGIN
    DELETE FROM CONTACTOS WHERE idContacto = p_idContacto;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertar_acceso(
    p_idUsuario INT,
    p_idDispositivo INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO ACCESO (idUsuario, idDispositivo)
    VALUES (p_idUsuario, p_idDispositivo);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION leer_accesos()
RETURNS TABLE(idAcceso INT, idUsuario INT, idDispositivo INT, fecRegistro TIMESTAMP, fecActualizacion TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT idAcceso, idUsuario, idDispositivo, fecRegistro, fecActualizacion
    FROM ACCESO;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION leer_accesos()
RETURNS TABLE(idAcceso INT, idUsuario INT, idDispositivo INT, fecRegistro TIMESTAMP, fecActualizacion TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT idAcceso, idUsuario, idDispositivo, fecRegistro, fecActualizacion
    FROM ACCESO;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_acceso(
    p_idAcceso INT,
    p_idUsuario INT,
    p_idDispositivo INT
) RETURNS VOID AS $$
BEGIN
    UPDATE ACCESO
    SET idUsuario = p_idUsuario,
        idDispositivo = p_idDispositivo,
        fecActualizacion = CURRENT_TIMESTAMP
    WHERE idAcceso = p_idAcceso;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION borrar_acceso(p_idAcceso INT) RETURNS VOID AS $$
BEGIN
    DELETE FROM ACCESO WHERE idAcceso = p_idAcceso;
END;
$$ LANGUAGE plpgsql;

