/*Mi tabla*/
/*drop database if exists gasbiumi_table_crud;
create database if not exists gasbiumi_table_crud;
use gasbiumi_table_crud;
drop table if exists daw2_tabla;
CREATE TABLE `daw2_tabla` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) DEFAULT NULL,
  `apellidoMaterno` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `puntuacion` decimal(10,2) DEFAULT NULL,
  `dt_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;

INSERT INTO `daw2_tabla`
(`nombre`,
`apellidoPaterno`,
`apellidoMaterno`,
`correo`,
`username`,
`password`,
`puntuacion`)

VALUES

('miguel', 'gascon', 'biurrun', 'mgasconb@hotmail.com', 'gasbiumi', 'mgasconb', 50.3),
('carlos', 'gascon', 'biurrun', 'cgasconb@hotmail.com', 'gasbiuca', 'carlos', 465.23),
('daniel', 'aaa', 'aaa', 'daa@hotmail.com', 'daaa', 'daaa', 560.3),
('juan', 'aaa', 'aaa', 'jaaa@hotmail.com', 'jaaa', 'jaaa', 564.33),
('luis', 'aaa', 'aaa', 'laaa@hotmail.com', 'laaa', 'laaa',  2.78)
;


/* Tabla de usuarios de la aplicación*/

drop table if exists daw2_usuarios;
CREATE TABLE daw2_usuarios (
id int(11) NOT NULL AUTO_INCREMENT,
login varchar(30) NOT NULL,
email varchar(100) NOT NULL,
password char(32) NOT NULL,
fecha_alta timestamp not null default current_timestamp(),
fecha_confirmacion_alta datetime default null,
clave_confirmacion char(30) null,
PRIMARY KEY (id),
UNIQUE KEY login (login),
UNIQUE KEY email (email)
)
ENGINE=myisam DEFAULT CHARSET=utf8
;

insert into daw2_usuarios 
  (login, email, password, fecha_alta ,fecha_confirmacion_alta, clave_confirmacion) values
  ('admin', 'admin@email.com', md5('admin00'), default, now(), null)
, ('anonimo', 'anonimo@email.com', md5(''), default, now(), null)
, ('juan', 'juan@email.com', md5('juan00'), default, now(), null)
, ('anais', 'anais@email.com', md5('anais00'), default, now(), null)
;
