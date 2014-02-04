/*drop database if exists gasbiumi_table_crud;
create database if not exists gasbiumi_table_crud;
use gasbiumi_table_crud;*/

/*drop database if exists daw2;
create database daw2;*/

# create user daw2_user identified by 'daw2_user';
# Concedemos al usuario daw2_user todos los permisos sobre esa base de datos
# grant all privileges on daw2.* to daw2_user;

use u130051890_table;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).


set names utf8;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).


set sql_mode = 'traditional';# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).


/*Parte de esmvcphp3.0*/

/*
 * @file: tables_and_user.sql
 * @author: jequeto@gmail.com
 * @since: 2012 enero
*/


drop table if exists daw2_usuarios;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

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
;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).



/*
 * Un rol es igual que un grupo de trabajo o grupo de usuarios.
 * Todos los usuarios serán miembros del rol usuario.
 */


drop table if exists daw2_roles;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

create table daw2_roles
( id integer unsigned auto_increment not null
, rol varchar(50) not null
, descripcion varchar(255) null
, primary key (id)
, unique (rol)
)
CHARACTER SET utf8 COLLATE utf8_general_ci
engine=myisam;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).



/* seccion y subseccion se validarán en v_negocios_permisos */
drop table if exists daw2_roles_permisos;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

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
engine=myisam;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).



drop table if exists daw2_usuarios_roles;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

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
engine=myisam;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).




-- Algunos hosting no dan el permiso de trigger por lo que habrá que implementarlo en programación php.
drop trigger if exists daw2_t_usuarios_ai;# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

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
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

delimiter ;



drop table if exists daw2_usuarios_permisos;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

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
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).



drop table if exists daw2_menu;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

create table daw2_menu
( id integer unsigned not null
, es_submenu_de_id integer unsigned null
, nivel integer unsigned not null comment '1 menu principal, 2 submenú, ...'
, orden integer unsigned null comment 'Orden en que aparecerán'
, texto varchar(50) not null comment 'Texto a mostrar en el item del menú'
, accion_controlador varchar(50) not null
, accion_metodo varchar(50) null comment 'null si es una entrada de nivel 1 con submenu de nivel 2'
, title varchar(255) null
, primary key (id)
, foreign key (es_submenu_de_id) references daw2_menu(id)
, unique (es_submenu_de_id, texto) -- Para evitar repeticiones de texto
, unique (accion_controlador, accion_metodo) -- Si una acción/funcionalidad solo debe aparecer una vez en el menú
)
CHARACTER SET utf8 COLLATE utf8_general_ci
engine=myisam;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).



/*
 * @file: dables_and_user.sql
 * @author: jequeto@gmail.com
 * @since: 2012 enero
*/

-- use daw2;

set names utf8;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

set sql_mode = 'traditional';
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).





insert into daw2_roles
  (rol					, descripcion) values
  ('administradores'	,'Administradores de la aplicación')
, ('usuarios'			,'Todos los usuarios incluido anónimo')
, ('usuarios_logueados'	,'Todos los usuarios excluido anónimo')
;
# 3 filas afectadas.



insert into daw2_usuarios 
  (login, email, password, fecha_alta ,fecha_confirmacion_alta, clave_confirmacion) values
  ('admin', 'admin@email.com', md5('admin00'), default, now(), null)
, ('anonimo', 'anonimo@email.com', md5(''), default, now(), null)
, ('juan', 'juan@email.com', md5('juan00'), default, now(), null)
, ('anais', 'anais@email.com', md5('anais00'), default, now(), null)
;
# 4 filas afectadas.



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
# 7 filas afectadas.


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
# 2 filas afectadas.



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
# 7 filas afectadas.



truncate table daw2_menu;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

insert into daw2_menu
  (id, es_submenu_de_id	, nivel	, orden	, texto, accion_controlador, accion_metodo, title) values
  (1 , null				, 1		, null	, 'Inicio', 'inicio', 'index', null)
, (2 , null				, 1		, null	, 'Internacional', 'inicio', 'internacional', null)
, (3 , null				, 1		, null	, 'Libros', 'libros', 'index', null)
, (4 , null				, 1		, null	, 'Revista', 'revista', 'index', null)
, (5 , null				, 1		, null	, 'Usuarios', 'usuarios', 'index', null)
, (6 , null				, 1		, null	, 'Categorías', 'categorias', 'index', null)
, (7 , null				, 1		, null	, 'Artículos', 'articulos', null, null)
, (8 , 7				, 2		, null	, 'listado', 'articulos', 'index', null)
, (9 , 7				, 2		, null	, 'recuento por categoría', 'articulos', 'recuento_por_categoria', null)
;
# 9 filas afectadas.



/*
 * @file: views.sql
 * @author: jequeto@gmail.com
 * @since: 2014 enero
*/

/*
Vista que recuperará todos los permisos de los que disfruta un usuario,
recopilando los asignados directamente en la tabla usuarios_permisos,
y los asignados indirectamente en la tabla usuarios_roles.
*/
create or replace view daw2_v_usuarios_permisos_roles
as
-- de usuarios_permisos
select
		 up.login
		,up.controlador
		,up.metodo
		,null as rol -- rol donante del permiso
from daw2_usuarios_permisos up
union distinct
-- de usuarios_roles
select
		 ur.login
		,rp.controlador
		,rp.metodo
		,ur.rol -- rol donante del permiso
from daw2_usuarios_roles ur inner join daw2_roles_permisos rp on ur.rol=rp.rol
order by login, controlador, metodo, rol
;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).


/*
Vista que devolverá una relación única de los permisos que tiene asignados
un usuario, sumados los directos más los indirectos (a través de los roles que 
tiene asignados).
*/
create or replace view daw2_v_usuarios_permisos
as
select distinct
		login
		,controlador
		,metodo
from daw2_v_usuarios_permisos_roles
order by login, controlador, metodo
;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).





create or replace view daw2_v_menu_submenu
(orden_nivel_1, orden_nivel_2, texto_menu, texto_submenu, accion_controlador, accion_metodo, title)
as
-- Items de nivel 1
select
	nivel as orden_nivel_1, null, texto as texto_menu, null, accion_controlador, accion_metodo, title
from daw2_menu
where nivel = 1
union
-- Items de nivel 2 o submenus
select
	m.nivel as orden_nivel_1, sm.orden as orden_nivel_2, m.texto as texto_menu, sm.texto as texto_submenu, sm.accion_controlador, sm.accion_metodo, sm.title
from daw2_menu as sm inner join daw2_menu as m on sm.es_submenu_de_id=m.id
where sm.nivel = 2
order by orden_nivel_1, orden_nivel_2, texto_menu, texto_submenu
;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).




/*
* @file: dables_and_user.sql
* @author: jequeto@gmail.com
* @since: 2012 enero
*/

/*Mi parte*/

/*Password = user+00*/
drop table if exists daw2_tabla;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).

CREATE TABLE `daw2_tabla` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) DEFAULT NULL,
  `apellidoMaterno` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL, 
  `puntuacion` decimal(10,2) DEFAULT NULL,
  `dt_registro` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;
# MySQL ha devuelto un conjunto de valores vacío (es decir: cero columnas).


INSERT INTO `daw2_tabla`
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
# 5 filas afectadas.
