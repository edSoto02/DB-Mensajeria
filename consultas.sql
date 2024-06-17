SELECT * FROM USUARIOS;

SELECT * FROM DISPOSITIVOS WHERE idUsuario = 1;

SELECT * FROM CONTACTOS WHERE idUsuario = 1;

SELECT * FROM PARTICIPANTES WHERE idUsuario = 1;

SELECT * FROM MENSAJES WHERE idConversacion = 1;

SELECT * FROM ACCESO WHERE idUsuario = 1;

SELECT * FROM PARTICIPANTES WHERE idConversacion = 1;

SELECT * FROM CONVERSACION_ELIMINADA WHERE idUsuario = 1;

SELECT DISTINCT U.idUsuario, U.nombre, U.apellido
FROM MENSAJES M
JOIN USUARIOS U ON M.idUsuario = U.idUsuario
WHERE M.idConversacion = 1;

SELECT * 
FROM MENSAJES_ELIMINADOS ME
JOIN MENSAJES M ON ME.idMensaje = M.idMensaje
WHERE ME.idUsuario = 1;

SELECT C.idConversacion, C.titulo, P.idUsuario, U.nombre, U.apellido
FROM CONVERSACION C
JOIN PARTICIPANTES P ON C.idConversacion = P.idConversacion
JOIN USUARIOS U ON P.idUsuario = U.idUsuario;

SELECT * 
FROM REPORTES 
WHERE idUsuario = 1;

SELECT M.idUsuario, COUNT(M.idMensaje) as total_mensajes
FROM MENSAJES M
WHERE M.idConversacion = 1
GROUP BY M.idUsuario;

SELECT M.idConversacion, M.idMensaje, M.idUsuario, M.mensaje, M.fechEnvio
FROM MENSAJES M
JOIN (
    SELECT idConversacion, idMensaje
    FROM (
        SELECT idConversacion, idMensaje, ROW_NUMBER() OVER (PARTITION BY idConversacion ORDER BY fechEnvio DESC) as rn
        FROM MENSAJES
    ) subquery
    WHERE rn <= 5
) AS last_messages ON M.idConversacion = last_messages.idConversacion AND M.idMensaje = last_messages.idMensaje
ORDER BY M.idConversacion, M.fechEnvio DESC;

SELECT U.idUsuario, U.nombre, U.apellido
FROM USUARIOS U
LEFT JOIN MENSAJES M ON U.idUsuario = M.idUsuario
WHERE M.idUsuario IS NULL;

SELECT idConversacion, AVG(fechEnvio - LAG(fechEnvio) OVER (PARTITION BY idConversacion ORDER BY fechEnvio)) as avg_response_time
FROM MENSAJES
GROUP BY idConversacion;

SELECT C.idConversacion, C.titulo, COUNT(P.idParticipante) as num_participantes
FROM CONVERSACION C
JOIN PARTICIPANTES P ON C.idConversacion = P.idConversacion
GROUP BY C.idConversacion
HAVING COUNT(P.idParticipante) > 10;

SELECT U.idUsuario, U.nombre, U.apellido, COUNT(M.idMensaje) as num_mensajes
FROM USUARIOS U
JOIN MENSAJES M ON U.idUsuario = M.idUsuario
WHERE M.fechEnvio >= NOW() - INTERVAL '1 month'
GROUP BY U.idUsuario, U.nombre, U.apellido
ORDER BY num_mensajes DESC;

SELECT C.idConversacion, C.titulo, COUNT(M.idMensaje) as num_mensajes
FROM CONVERSACION C
JOIN MENSAJES M ON C.idConversacion = M.idConversacion
WHERE M.fechEnvio >= NOW() - INTERVAL '1 week'
GROUP BY C.idConversacion, C.titulo
ORDER BY num_mensajes DESC;

SELECT idConversacion
FROM PARTICIPANTES
WHERE idUsuario IN (1, 2)
GROUP BY idConversacion
HAVING COUNT(DISTINCT idUsuario) = 2;

SELECT D.idDispositivo, D.tipoDispositivo, U.idUsuario, U.nombre, U.apellido
FROM DISPOSITIVOS D
JOIN USUARIOS U ON D.idUsuario = U.idUsuario
LEFT JOIN ACCESO A ON D.idDispositivo = A.idDispositivo AND A.fecRegistro >= NOW() - INTERVAL '1 month'
WHERE A.idAcceso IS NULL;

SELECT U.idUsuario, U.nombre, U.apellido,
    CASE
        WHEN COUNT(M.idMensaje) = 0 THEN 'No messages'
        WHEN COUNT(M.idMensaje) BETWEEN 1 AND 10 THEN 'Few messages'
        WHEN COUNT(M.idMensaje) BETWEEN 11 AND 50 THEN 'Moderate messages'
        ELSE 'Many messages'
    END AS message_category
FROM USUARIOS U
LEFT JOIN MENSAJES M ON U.idUsuario = M.idUsuario
GROUP BY U.idUsuario, U.nombre, U.apellido;

SELECT C.idConversacion, C.titulo, M.idMensaje, M.mensaje, M.fechEnvio
FROM CONVERSACION C
JOIN MENSAJES M ON C.idConversacion = M.idConversacion
WHERE M.fechEnvio = (
    SELECT MAX(fechEnvio)
    FROM MENSAJES
    WHERE idConversacion = C.idConversacion
);

WITH UserMessageCount AS (
    SELECT idUsuario, COUNT(idMensaje) as total_messages
    FROM MENSAJES
    GROUP BY idUsuario
)
SELECT U.idUsuario, U.nombre, U.apellido, UMC.total_messages
FROM USUARIOS U
JOIN UserMessageCount UMC ON U.idUsuario = UMC.idUsuario
ORDER BY UMC.total_messages DESC;

SELECT idConversacion,
    COUNT(CASE WHEN tipoMensaje = 'TEXT' THEN 1 END) as text_messages,
    COUNT(CASE WHEN tipoMensaje = 'IMAGE' THEN 1 END) as image_messages,
    COUNT(CASE WHEN tipoMensaje = 'VIDEO' THEN 1 END) as video_messages
FROM MENSAJES
GROUP BY idConversacion;

WITH MessageIntervals AS (
    SELECT idConversacion, fechEnvio,
        LAG(fechEnvio) OVER (PARTITION BY idConversacion ORDER BY fechEnvio) as prev_message_time
    FROM MENSAJES
)
SELECT idConversacion, AVG(EXTRACT(EPOCH FROM (fechEnvio - prev_message_time))) as avg_response_time_seconds
FROM MessageIntervals
WHERE prev_message_time IS NOT NULL
GROUP BY idConversacion;

SELECT idUsuario, COUNT(DISTINCT idDispositivo) as num_devices, DATE(fecRegistro) as access_date
FROM ACCESO
GROUP BY idUsuario, DATE(fecRegistro)
HAVING COUNT(DISTINCT idDispositivo) > 1;

SELECT U.idUsuario, U.nombre, U.apellido,
    CASE
        WHEN COUNT(R.idReporte) > 1 THEN 'Reported multiple times'
        ELSE 'Reported once or not at all'
    END AS report_status
FROM USUARIOS U
LEFT JOIN REPORTES R ON U.idUsuario = R.idUsuario
GROUP BY U.idUsuario, U.nombre, U.apellido;

SELECT C.idConversacion, C.titulo
FROM CONVERSACION C
WHERE EXISTS (
    SELECT 1
    FROM MENSAJES M
    WHERE M.idConversacion = C.idConversacion
)
AND NOT EXISTS (
    SELECT 1
    FROM PARTICIPANTES P
    WHERE P.idConversacion = C.idConversacion
    AND P.idUsuario IN (
        SELECT idUsuario
        FROM ACCESO
        WHERE fecRegistro >= NOW() - INTERVAL '1 month'
    )
);

