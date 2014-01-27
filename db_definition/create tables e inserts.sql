drop database if exists gasbiumi_table_crud;
create database if not exists gasbiumi_table_crud;
use gasbiumi_table_crud;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) DEFAULT NULL,
  `apellidoMaterno` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `puntuacion` decimal(10,2) DEFAULT NULL,
  `dt_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`)
) ;

INSERT INTO `usuarios`
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