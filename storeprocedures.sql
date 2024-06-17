CREATE OR REPLACE PROCEDURE insertarUsuario(
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_username VARCHAR,
    p_password VARCHAR,
    p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO USUARIOS (nombre, apellido, username, password, email)
    VALUES (p_nombre, p_apellido, p_username, p_password, p_email);
END;
$$;

CREATE OR REPLACE PROCEDURE leerUsuarios()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Leyendo:';
    FOR user_record IN
        SELECT idUsuario, nombre, apellido, username, email
        FROM USUARIOS
    LOOP
        RAISE NOTICE 'idUsuario: %, nombre: %, apellido: %, username: %, email: %', 
        user_record.idUsuario, user_record.nombre, user_record.apellido, 
        user_record.username, user_record.email;
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE actualizarUsuario(
    p_idUsuario INT,
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_username VARCHAR,
    p_password VARCHAR,
    p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE USUARIOS
    SET nombre = p_nombre,
        apellido = p_apellido,
        username = p_username,
        password = p_password,
        email = p_email
    WHERE idUsuario = p_idUsuario;
END;
$$;

CREATE OR REPLACE PROCEDURE borrarUsuario(p_idUsuario INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM USUARIOS WHERE idUsuario = p_idUsuario;
END;
$$;

CREATE OR REPLACE PROCEDURE insertarDispositivo(
    p_idUsuario INT,
    p_tipoDispositivo VARCHAR,
    p_claveDispositivo VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO DISPOSITIVOS (idUsuario, tipoDispositivo, claveDispositivo)
    VALUES (p_idUsuario, p_tipoDispositivo, p_claveDispositivo);
END;
$$;

CREATE OR REPLACE PROCEDURE leerDispositivos()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Leyendo:';
    FOR device_record IN
        SELECT idDispositivo, idUsuario, tipoDispositivo, claveDispositivo
        FROM DISPOSITIVOS
    LOOP
        RAISE NOTICE 'idDispositivo: %, idUsuario: %, tipoDispositivo: %, claveDispositivo: %', 
        device_record.idDispositivo, device_record.idUsuario, 
        device_record.tipoDispositivo, device_record.claveDispositivo;
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE actualizarDispositivo(
    p_idDispositivo INT,
    p_idUsuario INT,
    p_tipoDispositivo VARCHAR,
    p_claveDispositivo VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE DISPOSITIVOS
    SET idUsuario = p_idUsuario,
        tipoDispositivo = p_tipoDispositivo,
        claveDispositivo = p_claveDispositivo
    WHERE idDispositivo = p_idDispositivo;
END;
$$;

CREATE OR REPLACE PROCEDURE borrarDispositivo(p_idDispositivo INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM DISPOSITIVOS WHERE idDispositivo = p_idDispositivo;
END;
$$;

CREATE OR REPLACE PROCEDURE insertarAcceso(
    p_idUsuario INT,
    p_idDispositivo INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ACCESO (idUsuario, idDispositivo)
    VALUES (p_idUsuario, p_idDispositivo);
END;
$$;

CREATE OR REPLACE PROCEDURE leerAccesos()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Leyendo:';
    FOR access_record IN
        SELECT idAcceso, idUsuario, idDispositivo, fecRegistro, fecActualizacion
        FROM ACCESO
    LOOP
        RAISE NOTICE 'idAcceso: %, idUsuario: %, idDispositivo: %, fecRegistro: %, fecActualizacion: %', 
        access_record.idAcceso, access_record.idUsuario, 
        access_record.idDispositivo, access_record.fecRegistro, 
        access_record.fecActualizacion;
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE actualizarAcceso(
    p_idAcceso INT,
    p_idUsuario INT,
    p_idDispositivo INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ACCESO
    SET idUsuario = p_idUsuario,
        idDispositivo = p_idDispositivo,
        fecActualizacion = CURRENT_TIMESTAMP
    WHERE idAcceso = p_idAcceso;
END;
$$;

CREATE OR REPLACE PROCEDURE borrarAcceso(p_idAcceso INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM ACCESO WHERE idAcceso = p_idAcceso;
END;
$$;

CALL insertar_usuario('Juan', 'Pérez', 'juanp', 'password123', 'juanp@example.com');

CALL leer_usuarios();

CALL actualizar_usuario(1, 'Juan', 'Pérez', 'juanp', 'newpassword123', 'juanp@example.com');

CALL borrar_usuario(1);

