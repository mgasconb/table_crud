/*drop database if exists gasbiumi_table_crud;
create database if not exists gasbiumi_table_crud;
use gasbiumi_table_crud;*/

drop database if exists daw2;
create database daw2;

# create user daw2_user identified by 'daw2_user';
# Concedemos al usuario daw2_user todos los permisos sobre esa base de datos
# grant all privileges on daw2.* to daw2_user;

use daw2;

set names utf8;

set sql_mode = 'traditional';

/*Parte de esmvcphp3.0*/

/*
 * @file: tables_and_user.sql
 * @author: jequeto@gmail.com
 * @since: 2012 enero
*/


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


/*
 * Un rol es igual que un grupo de trabajo o grupo de usuarios.
 * Todos los usuarios serán miembros del rol usuario.
 */


drop table if exists daw2_roles;
create table daw2_roles
( id integer unsigned auto_increment not null
, rol varchar(50) not null
, descripcion varchar(255) null
, primary key (id)
, unique (rol)
)
CHARACTER SET utf8 COLLATE utf8_general_ci
engine=myisam;


/* seccion y subseccion se validarán en v_negocios_permisos */
drop table if exists daw2_roles_permisos;
create table daw2_roles_permisos
( id integer unsigned auto_increment not null
, rol varchar(50) not null
, controlador varchar(50) not null comment "Si vale * equivale a todos los controladores"
, metodo varchar(50) null comment "Si vale * equivale a todos los métodos de un controlador"
, primary key (id)
, unique(rol, controlador, metodo) -- Evita que a un rol se le asinge más de una vez un mismo permiso
, foreign key (rol) references daw2_roles(rol) on delete cascade on update cascade
-- , foreign key (controlador, metodo) references daw2_metodos(controlador, metodo) on delete cascade on update cascade
)
CHARACTER SET utf8 COLLATE utf8_general_ci
engine=myisam;


drop table if exists daw2_usuarios_roles;
create table daw2_usuarios_roles
( id integer unsigned auto_increment not null
, login varchar(20) not null
, rol varchar(50) not null

, primary key (id)
, unique (login, rol) -- Evita que a un usuario se le asigne más de una vez el mismo rol
, foreign key ( login) references daw2_usuarios(login) on delete cascade on update cascade
, foreign key ( rol) references daw2_roles(rol) on delete cascade on update cascade
)
CHARACTER SET utf8 COLLATE utf8_general_ci
engine=myisam;



-- Algunos hosting no dan el permiso de trigger por lo que habrá que implementarlo en programación php.
drop trigger if exists daw2_t_usuarios_ai;
delimiter //
create trigger daw2_t_usuarios_ai after insert on daw2_usuarios
for each row
begin
	insert into daw2_usuarios_roles (login, rol) values ( new.login, 'usuarios');
	if (new.login != "anonimo") then
		insert into daw2_usuarios_roles (login,  rol) values ( new.login, 'usuarios_logueados');
	end if;
end;

//
delimiter ;



drop table if exists daw2_usuarios_permisos;
create table daw2_usuarios_permisos
( id integer unsigned auto_increment not null
, login varchar(20) not null
, controlador varchar(50) not null comment "Si vale * equivale a todos los controladores"
, metodo varchar(50) null comment "Si vale * equivale a todos los métodos de un controlador"

, primary key (id)
, unique(login, controlador, metodo) -- Evita que a un usuario se le asignen más de una vez un permiso
, foreign key (login) references daw2_usuarios(login) on delete cascade on update cascade
-- , foreign key (controlador, metodo) references daw2_metodos(controlador, metodo) on delete cascade on update cascade

)
CHARACTER SET utf8 COLLATE utf8_general_ci
engine=myisam;


/*
 * @file: dables_and_user.sql
 * @author: jequeto@gmail.com
 * @since: 2012 enero
*/

-- use daw2;

set names utf8;
set sql_mode = 'traditional';




insert into daw2_roles
  (rol					, descripcion) values
  ('administradores'	,'Administradores de la aplicación')
, ('usuarios'			,'Todos los usuarios incluido anónimo')
, ('usuarios_logueados'	,'Todos los usuarios excluido anónimo')
;


insert into daw2_usuarios 
  (login, email, password, fecha_alta ,fecha_confirmacion_alta, clave_confirmacion) values
  ('admin', 'admin@email.com', md5('admin00'), default, now(), null)
, ('anonimo', 'anonimo@email.com', md5(''), default, now(), null)
, ('juan', 'juan@email.com', md5('juan00'), default, now(), null)
, ('anais', 'anais@email.com', md5('anais00'), default, now(), null)
;


insert into daw2_roles_permisos
  (rol					,controlador		,metodo) values
  ('administradores'	,'*'				,'*')
, ('usuarios'			,'inicio'			,'*')
, ('usuarios'			,'mensajes'			,'*')
, ('usuarios_logueados' ,'usuarios'			,'desconectar')
, ('usuarios_logueados' ,'usuarios'			,'form_cambiar_password')
, ('usuarios_logueados' ,'usuarios'			,'form_cambiar_password_validar')
, ('usuarios_logueados' ,'categorias'			,'index')

;

insert into daw2_usuarios_roles
  (login		,rol) values
  ('admin'		,'administradores')
, ('juan'		,'administradores')
-- , ('anonimo'	,'usuarios')
-- , ('juan'		,'usuarios')
-- , ('juan'		,'usuarios_logueados')
-- , ('anais'		,'usuarios')
-- , ('anais'		,'usuarios_logueados')
;


insert into daw2_usuarios_permisos
  (login			,controlador			,metodo) values
  ('anonimo'		,'usuarios'				,'form_login')
, ('anonimo'		,'usuarios'				,'form_login_validar')
, ('anonimo'		,'usuarios'				,'form_login_email')
, ('anonimo'		,'usuarios'				,'form_login_email_validar')
, ('anonimo'		,'usuarios'				,'confirmar_alta')
, ('anonimo'		,'usuarios'				,'form_insertar_externo')
, ('anonimo'		,'usuarios'				,'form_insertar_externo_validar')
;


/*
 * @file: views.sql
 * @author: jequeto@gmail.com
 * @since: 2014 enero
*/


/*Mi parte*/

/*Password = user+00*/
drop table if exists daw2_ranking;
CREATE TABLE `daw2_ranking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) DEFAULT NULL,
  `apellidoMaterno` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL, 
  `puntuacion` decimal(10,2) DEFAULT NULL,
  `dt_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;

INSERT INTO `daw2_ranking`
(`nombre`,
`apellidoPaterno`,
`apellidoMaterno`,
`correo`,
`username`,
`password`,
`puntuacion`)

VALUES

('miguel', 'gascon', 'biurrun', 'mgasconb@hotmail.com', 'gasbiumi', '57c121e25c962050269a0fedae41d5bf', 50.3),
('carlos', 'gascon', 'biurrun', 'cgasconb@hotmail.com', 'gasbiuca', '7e3f40511b178afb7f9e2c1a7a9e55af', 465.23),
('daniel', 'aaa', 'aaa', 'daa@hotmail.com', 'daaa', 'b59ece568af00848f7425a6a93f5c2e0', 560.3),
('juan', 'aaa', 'aaa', 'jaaa@hotmail.com', 'jaaa', '5c47a79da5ece33687f062ac2260b9cb', 564.33),
('luis', 'aaa', 'aaa', 'laaa@hotmail.com', 'laaa', '1e9043ac94d1f91538f37cfb535fcbff',  2.78)
;


