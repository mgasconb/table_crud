
<form method='post' action="?menu=<?php echo $datos['controlador_clase']; ?>&submenu=validar_<?php echo $datos['controlador_metodo']; ?>" >
	<input id='id' name='id' type='hidden' value='<?php echo \core\Array_Datos::values('id', $datos); ?>' />
	Nombre: <select id='nombre' name='nombre' />
		<?php 
			if (\core\Distribuidor::get_metodo_invocado() == "form_insertar") {
				echo "<option >Elige un nombre</option>\n";
			}
			foreach ($datos['nombre'] as $nombre) {
				$selected = (\core\Array_Datos::values('nombre', $datos) == $nombre['nombre']) ? " selected='selected' " : "";
				echo "<option $selected>{$nombre['nombre']}</option>\n";
			}
		?>
	</select>
	<?php echo \core\HTML_Tag::span_error('nombre', $datos); ?>
	<br />
	Apellido paterno: <input id='apellidoPaterno' name='apellidoPaterno' type='text' size='100'  maxlength='100' value='<?php echo \core\Array_Datos::values('apellidoPaterno', $datos); ?>'/>
	<?php echo \core\HTML_Tag::span_error('apellidoPaterno', $datos); ?>
	<br />
	Apellido materno: <input id='apellidoMaterno' name='apellidoMaterno' type='text' size='20'  maxlength='20' value='<?php echo \core\Array_Datos::values('apellidoMaterno', $datos); ?>'/>
	<?php echo \core\HTML_Tag::span_error('apellidoMaterno', $datos); ?>
	<br />
	Correo: <input id='correo' name='correo' type='text' size='20'  maxlength='20' value='<?php echo \core\Array_Datos::values('correo', $datos); ?>'/>
	<?php echo \core\HTML_Tag::span_error('correo', $datos); ?>
	<br />        
        Nombre de usuario: <input id='username' name='username' type='text' size='20'  maxlength='20' value='<?php echo \core\Array_Datos::values('username', $datos); ?>'/>
	<?php echo \core\HTML_Tag::span_error('username', $datos); ?>
	<br />
        Contraseña: <input id='password' name='password' type='text' size='20'  maxlength='20' value='<?php echo \core\Array_Datos::values('password', $datos); ?>'/>
	<?php echo \core\HTML_Tag::span_error('password', $datos); ?>
	<br />
        Puntuación: <input id='puntuacion' name='puntuacion' type='text' size='20'  maxlength='20' value='<?php echo \core\Array_Datos::values('puntuacion', $datos); ?>'/>
	<?php echo \core\HTML_Tag::span_error('puntuacion', $datos); ?>
	<br />
	<?php echo \core\HTML_Tag::span_error('errores_validacion', $datos); ?>
	
	<input type='submit' value='Enviar'>
	<input type='reset' value='Limpiar'>
	<button type='button' onclick='location.assign("?menu=articulos&submenu=index");'>Cancelar</button>
</form>