<?php //netteCache[01]000373a:2:{s:4:"time";s:21:"0.64356500 1391945511";s:9:"callbacks";a:2:{i:0;a:3:{i:0;a:2:{i:0;s:19:"Nette\Caching\Cache";i:1;s:9:"checkFile";}i:1;s:59:"C:\php\pear\data\ApiGen\templates\default\combined.js.latte";i:2;i:1391944925;}i:1;a:3:{i:0;a:2:{i:0;s:19:"Nette\Caching\Cache";i:1;s:10:"checkConst";}i:1;s:25:"Nette\Framework::REVISION";i:2;s:22:"released on 2013-12-31";}}}?><?php

// source file: C:\php\pear\data\ApiGen\templates\default\combined.js.latte

?><?php
// prolog Nette\Latte\Macros\CoreMacros
list($_l, $_g) = Nette\Latte\Macros\CoreMacros::initRuntime($template, 'dmdpjphfuz')
;
// prolog Nette\Latte\Macros\UIMacros

// snippets support
if (!empty($_control->snippetMode)) {
	return Nette\Latte\Macros\UIMacros::renderSnippets($_control, $_l, get_defined_vars());
}

//
// main template
// ?>

var ApiGen = ApiGen || {};
ApiGen.config = <?php echo Nette\Templating\Helpers::escapeJs($config->template) ?>;

<?php $scripts = array('jquery.min.js', 'jquery.cookie.js', 'jquery.sprintf.js', 'jquery.autocomplete.js', 'jquery.sortElements.js', 'main.js') ;$dir = dirname($template->getFile()) ?>

<?php $iterations = 0; foreach ($scripts as $script) { echo file_get_contents("$dir/js/$script") ?>

<?php $iterations++; } 