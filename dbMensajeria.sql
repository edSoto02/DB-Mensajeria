CREATE TABLE USUARIOS(
    idUsuario SERIAL NOT NULL,
    nombre VARCHAR(255) NOT NULL,	
    apellido VARCHAR(255) NOT NULL, 	
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,	
    email VARCHAR(255) NOT NULL,
    CONSTRAINT idUsuario_PK PRIMARY KEY (idUsuario)      	
);

CREATE TABLE DISPOSITIVOS(
    idDispositivo SERIAL NOT NULL, 	
    idUsuario INT NOT NULL,	
    tipoDispositivo	VARCHAR(255) NOT NULL, 	
    claveDispositivo VARCHAR(255) NOT NULL,
    CONSTRAINT idDipositivo_pk PRIMARY KEY (idDispositivo),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario) 
);

CREATE TABLE CONTACTOS(
    idContacto SERIAL NOT NULL,
    idUsuario INT NOT NULL, 	
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,  	
    teléfono VARCHAR(255) NOT NULL,	
    email VARCHAR(255) NOT NULL,
    CONSTRAINT idContacto_pk PRIMARY KEY (idContacto),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)
);

CREATE TABLE CONTACTO_USUARIO(
    idUsContacto SERIAL  NOT NULL,	
    idUsuario INT NOT NUULL,	
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,	
    fecCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT idUsContacto_pk PRIMARY KEY (idUsContacto),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)
);

CREATE TABLE CONVERSACION(
    idConversacion SERIAL NOT NULL,	
    titulo VARCHAR(255) NOT NULL,	
    idUsuario INT NOT NULL,
    idCanal	VARCHAR(255) NOT NULL,
    fechCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fechEliminacion TIMESTAMP,
    CONSTRAINT idConversacion_pk PRIMARY KEY (idConversacion),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)

);

CREATE TABLE PARTICIPANTES(
    idParticipante SERIAL NOT NULL,	
    idConversacion INT NOT NULL,
    idUsuario INT NOT NULL,
    tipoUsuario  VARCHAR(255) NOT NULL CHECK (tipoUsuario IN ('USER', 'ADMIN', 'MODERADOR')),
    CONSTRAINT idParticipante_pk PRIMARY KEY (idParticipante),
    CONSTRAINT idConversacion_fk FOREIGN KEY (idConversacion) REFERENCES CONVERSACION (idConversacion),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)

);

CREATE TABLE MENSAJES(
    idMensaje SERIAL NOT NULL,	
    idConversacion INT NOT NULL,	
    idUsuario INT NOT NULL,	
    tipoMensaje	VARCHAR(10) CHECK (tipoMensaje IN ('TEXT', 'IMAGE', 'VIDEO')),
    mensaje VARCHAR(255) NOT NULL,
    fechEnvio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,	
    fechEliminacion TIMESTAMP,
    CONSTRAINT idMensaje_pk PRIMARY KEY (idMensaje),
    CONSTRAINT idConversacion_fk FOREIGN KEY (idConversacion) REFERENCES CONVERSACION (idConversacion),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)

);

CREATE TABLE MENSAJES_ELIMINADOS(
    idMsj SERIAL NOT NULL,	
    idMensaje INT NOT NULL,	
    idUsuario INT NOT NULL,	
    fechEliminado TIMESTAMP,
    CONSTRAINT idMsj_pk PRIMARY KEY (idMsj),
    CONSTRAINT idMensaje_fk FOREIGN KEY (idMensaje) REFERENCES MENSAJES (idMesaje),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)
);

CREATE TABLE CONVERSACION_ELIMINADA(
    idConv SERIAL NOT NULL,	
    idConversacion INT NOT NULL,	
    idUsuario INT NOT NULL,	
    fechElimimacion TIMESTAMP,
    CONSTRAINT idConv_pk PRIMARY KEY (idConv),
    CONSTRAINT idConversacion_fk FOREIGN KEY (idConversacion) REFERENCES CONVERSACION (idConversacion),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)
 
);

CREATE TABLE ACCESO(
    idAcceso SERIAL NOT NULL,	
    idUsuario INT NOT NULL,	
    idDispositivo INT NOT NULL,		
    fecRegistro	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecActualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT idAcceso_pk PRIMARY KEY (idAcceso),
    CONSTRAINT idDispositivo_fk FOREIGN KEY (idDispositivo) REFERENCES DISPOSITIVOS (idDispositivo),  
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)

);

CREATE TABLE USUARIOS_BLOQUEADOS(
    idUsBloqueo SERIAL NOT NULL,	 	
    idUsuario INT NOT NULL,
    idParticipante INT NOT NULL,
    telefono VARCHAR(255) NOT NULL,	
    fechaBloqueo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT idUsBloqueo_pk PRIMARY KEY (idUsBloqueo), 
    CONSTRAINT idParticipante_fk FOREIGN KEY (idParticipante) REFERENCES PARTICIPANTES (idParticipante),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)

);

CREATE TABLE REPORTES(
    idReporte SERIAL NOT NULL,	
    idUsuario INT NOT NULL,	
    idParticipante INT NOT NULL,	
    tipoReporte VARCHAR(255) NOT NULL,	
    nota VARCHAR(255) NOT NULL,	
    fechReporte TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT idReporte_pk PRIMARY KEY (idReporte),
    CONSTRAINT idParticipante_fk FOREIGN KEY (idParticipante) REFERENCES PARTICIPANTES (idParticipante),
    CONSTRAINT idUsuario_fk FOREIGN KEY (idUsuario) REFERENCES USUARIOS (idUsuario)
);




