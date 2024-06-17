CREATE VIEW VistaUsuariosConMensajes AS
WITH CantidadMensajes AS (
    SELECT idUsuario, COUNT(idMensaje) as total_mensajes
    FROM MENSAJES
    GROUP BY idUsuario
)
SELECT U.idUsuario, U.nombre, U.apellido, U.email, COALESCE(CM.total_mensajes, 0) as total_mensajes
FROM USUARIOS U
LEFT JOIN CantidadMensajes CM ON U.idUsuario = CM.idUsuario;

CREATE VIEW VistaMensajesConUsuarios AS
SELECT M.idMensaje, M.idConversacion, M.idUsuario, U.nombre, U.apellido, M.tipoMensaje, M.mensaje, M.fechEnvio, M.fechEliminacion
FROM MENSAJES M
JOIN USUARIOS U ON M.idUsuario = U.idUsuario;

CREATE VIEW VistaConversacionesConParticipantes AS
WITH NumeroParticipantes AS (
    SELECT idConversacion, COUNT(idParticipante) as total_participantes
    FROM PARTICIPANTES
    GROUP BY idConversacion
)
SELECT C.idConversacion, C.titulo, C.idUsuario, C.idCanal, C.fechCreacion, C.fechEliminacion, COALESCE(PC.total_participantes, 0) as total_participantes
FROM CONVERSACION C
LEFT JOIN NumeroParticipantes PC ON C.idConversacion = PC.idConversacion;

CREATE VIEW VistaUsuariosBloqueados AS
SELECT UB.idUsBloqueo, UB.idUsuario, U.nombre AS nombre_usuario, U.apellido AS apellido_usuario,
       UB.idParticipante, P.idUsuario AS idUsuario_bloqueado, UB.telefono, UB.fechaBloqueo
FROM USUARIOS_BLOQUEADOS UB
JOIN USUARIOS U ON UB.idUsuario = U.idUsuario
JOIN PARTICIPANTES P ON UB.idParticipante = P.idParticipante;

CREATE VIEW VistaReportes AS
SELECT R.idReporte, R.idUsuario, U.nombre AS nombre_reportador, U.apellido AS apellido_reportador,
       R.idParticipante, P.idUsuario AS idUsuario_reportado, R.tipoReporte, R.nota, R.fechReporte
FROM REPORTES R
JOIN USUARIOS U ON R.idUsuario = U.idUsuario
JOIN PARTICIPANTES P ON R.idParticipante = P.idParticipante;
