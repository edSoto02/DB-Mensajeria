### Proyecto de Base de Datos para Sistema de Mensajería
Descripción del Proyecto.

Este proyecto consiste en el diseño, implementación y poblamiento de una base de datos relacional para un sistema de mensajería. La base de datos está diseñada para gestionar usuarios, dispositivos, contactos, conversaciones, mensajes y otras entidades relacionadas en un entorno de mensajería. La base de datos sigue las mejores prácticas de normalización para asegurar integridad y eficiencia en las operaciones.

![SQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/sql-%2307405e.svg?style=for-the-badge&logo=sql&logoColor=white)
![SQL](https://img.shields.io/badge/PLSQL-F80000?style=for-the-badge&logo=oracle&logoColor=black)
![SQL](https://img.shields.io/badge/Udemy-EC5252?style=for-the-badge&logo=Udemy&logoColor=white)
![SQL](https://img.shields.io/badge/W3Schools-04AA6D?style=for-the-badge&logo=W3Schools&logoColor=white)
![SQL](https://img.shields.io/badge/VSCode-0078D4?style=for-the-badge&logo=visual%20studio%20code&logoColor=white)


### Funcionalidad de la Base de Datos
La base de datos permite realizar las siguientes operaciones:

* Gestión de Usuarios: Registro, actualización, eliminación y consulta de usuarios.

* Gestión de Dispositivos: Registro, actualización, eliminación y consulta de dispositivos asociados a los usuarios.

* Gestión de Contactos: Manejo de la lista de contactos de los usuarios.

* Gestión de Conversaciones y Mensajes: Creación y manejo de conversaciones y mensajes entre usuarios, incluyendo la capacidad de eliminar mensajes y conversaciones.

* Gestión de Accesos: Registro y seguimiento de los accesos de los usuarios desde diferentes dispositivos.

* Bloqueo y Reportes de Usuarios: Capacidad de bloquear usuarios y generar reportes de actividades sospechosas o abusivas.

### Tecnologías Utilizadas.

* Gestor de Base de Datos: PostgreSQL.
  
* Lenguaje de Consulta: SQL
  
  * DDL (Data Definition Language): Para la creación y definición de las tablas.
  * DML (Data Manipulation Language): Para la inserción, actualización y eliminación de datos.
  * Procedimientos Almacenados (Stored Procedures): Para encapsular la lógica de negocios y operaciones CRUD.
  * Vistas: Para crear consultas predefinidas sobre los datos.
  * Consultas Avanzadas: Uso de Common Table Expressions (CTEs), CASE, y otras funcionalidades avanzadas de SQL.

### Estructura de la Base de Datos
La base de datos está compuesta por las siguientes tablas principales:

* USUARIOS.

* DISPOSITIVOS.

* CONTACTOS.

* CONTACTO_USUARIO.

* CONVERSACION.

* PARTICIPANTES.

* MENSAJES.

* MENSAJES_ELIMINADOS.

* CONVERSACION_ELIMINADA.

* ACCESO.

* USUARIOS_BLOQUEADOS.

* REPORTES.

Cada tabla está diseñada con claves primarias y foráneas para mantener la integridad referencial y asegurar la consistencia de los datos.

### Procedimientos Almacenados y Vistas.

El proyecto incluye procedimientos almacenados para realizar operaciones CRUD en cada una de las tablas, lo que facilita la gestión y manipulación de los datos. Además, se han creado vistas para facilitar la consulta y visualización de los datos más relevantes.

### Poblamiento de Datos
Se han insertado registros de ejemplo en cada una de las tablas para simular un entorno real y demostrar la funcionalidad de la base de datos.

<h4 align="center">
:construction: Proyecto en construcción :construction:
</h4>

#### Este proyecto puede ser usado y ampliado segun las necesidades de cada usuario o quien sea que lo pueda usar.
