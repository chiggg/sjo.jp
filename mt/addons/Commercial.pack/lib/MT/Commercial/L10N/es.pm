# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package MT::Commercial::L10N::es;

use strict;
use base 'MT::Commercial::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (
## addons/Commercial.pack/lib/MT/Commercial/Util.pm
	'About' => 'Sobre mi',
	'_UTS_REPLACE_THIS' => '<p><strong>Reemplace el texto de ejemplo con sus propios datos.</strong></p>',
	'_UTS_SAMPLE_ABOUT' => '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies.</p>
',
	'_UTS_EDIT_LINK' => '
<!-- borrar este enlace después de la edición -->
<p class="admin-edit-link">
<script type="text/javascript">document.write(\'<a href="\' + adminurl + \'?__mode=view&_type=page&id=\' + page_id + \'&blog_id=\' + blog_id + \'" target="_blank">Editar este contenido</a>\')</script>
</p>
',
	'_UTS_CONTACT' => 'Contacto',
	'_UTS_SAMPLE_CONTACT' => '<p>Nos encantará tener noticias suyas. Envíenos un mensaje a correo (arroba) dominio.com</p>',
	'Welcome to our new website!' => '¡Bienvenido a nuestro nuevo sitio!',
	'_UTS_SAMPLE_WELCOME' => '
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Aliquam erat volutpat. Ut placerat porta nibh. Donec vitae nulla. Pellentesque nisi leo, pretium a, gravida quis, sollicitudin non, eros. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies. Aliquam sagittis volutpat metus.</p>

<p>Sed enim. Integer hendrerit, arcu ac pretium nonummy, velit turpis faucibus risus, pulvinar egestas enim elit sed ante. Curabitur orci diam, placerat a, faucibus id, condimentum vitae, magna. Etiam enim massa, convallis quis, rutrum vitae, porta quis, turpis.</p>
',
	'New design launched using Movable Type' => 'Nuevo diseño lanzado utilizando Movable Type',
	'_UTS_SAMPLE_NEWDESIGN' => '
<p>Nuestro sitio tiene un nuevo diseño gracias a <a href="http://www.movabletype.com/">Movable Type</a> y el Conjunto de Plantillas Universal. Este conjunto le permite a cualquier persona poner en marcha un nuevo web con Movable Type. Es realmente fácil, y solo con un par de clics. Seleccione un nombre para su nuevo sitio, seleccione el Conjunto de Plantillas Universal y publique. ¡Voilà! El nuevo sitio. ¡Gracias Movable Type!</p>
',

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => 'Mostrar',
	'Date & Time' => 'Fecha & Hora',
	'Date Only' => 'Fecha solo',
	'Time Only' => 'Hora solo',
	'Please enter all allowable options for this field as a comma delimited list' => 'Por favor, introduzca todas las opciones permitidas a este campo en forma de lista de elementos separados por comas',
	'Custom Fields' => 'Campos personalizados',
	'[_1] Fields' => 'Campos de [_1]',
	'Edit Field' => 'Editar campo',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Fecha no válida \'[_1]\'; las fechas deben estar en el formato YYYY-MM-DD HH:MM:SS.',
	'Invalid date \'[_1]\'; dates should be real dates.' => 'Fecha no válida \'[_1]\'; debe ser una fecha real.',
	'Please enter valid URL for the URL field: [_1]' => 'Por favor, introduzca una URL válida en el campo de la URL: [_1]',
	'Please enter some value for required \'[_1]\' field.' => 'Por favor, introduzca un valor en el campo obligatorio \'[_1]\'.',
	'Please ensure all required fields have been filled in.' => 'Por favor, asegúrese de que todos los campos se han introducido.',
	'The template tag \'[_1]\' is an invalid tag name.' => 'La etiqueta de plantilla \'[_1]\' es un nombre de etiqueta inválido.',
	'The template tag \'[_1]\' is already in use.' => 'La etiqueta de plantilla \'[_1]\' ya está en uso.',
	'The basename \'[_1]\' is already in use.' => 'El nombre base \'[_1]\' ya está en uso.',
	'Default value must be valid URL.' => 'El valor por defecto debe ser una URL válida.',
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'Personalice los formularios y campos de las entradas, páginas, carpetas, categorías y usuarios, guardando los datos exactos que necesite.',
	' ' => ' ',
	'Single-Line Text' => 'Texto - Una sola línea',
	'Multi-Line Textfield' => 'Texto - Varias líneas',
	'Checkbox' => 'Casilla',
	'Date and Time' => 'Fecha y Hora',
	'Drop Down Menu' => 'Menú desplegable',
	'Radio Buttons' => 'Botones radiales',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => '¿Está seguro de que ha utilizado la etiqueta \'[_1]\' en el contexto adecuado? No se encontró el [_2]',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => 'Ha utilizado una etiqueta \'[_1]\' fuera del contexto del contenido correcto;',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'Trasladando los metadatos de las páginas...',

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'Restaurando los datos de los campos personalizados guardados en MT::PluginData...',
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'Restaurando las asociaciones de los ficheros multimedia de los campos personalizados ( [_1] ) ...',
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'Restaurando url de los ficheros multimedia asociados en los campos personalizados ( [_1] )...',

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => 'Falló al buscar [_1]::[_2]',

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'Campo',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => 'Seleccionar fecha',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'Nuevo campo',
	'The selected fields(s) has been deleted from the database.' => 'Los campos seleccionados han sido borrados de la base de datos.',
	'Please ensure all required fields (highlighted) have been filled in.' => 'Por favor, asegúrese de que todos los campos obligatorios (resaltados) han sido introducidos.',
	'System Object' => 'Objeto del sistema',
	'Select the system object this field is for' => 'Seleccione el objeto del sistema para el cual es el campo',
	'Select...' => 'Seleccionar...',
	'Required?' => '¿Obligatorio?',
	'Should a value be chosen or entered into this field?' => '¿Debería seleccionarse o introducirse un valor en este campo?',
	'Default' => 'Predefinido',
	'You will need to first save this field in order to set a default value' => 'Primero deberá guardar este campo para configurarle su valor predefinido.',
	'_CF_BASENAME' => 'Nombre base',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'El nombre base se utiliza para introducir datos de campos personalizados a través de un cliente de otro fabricante. Debe ser único.',
	'Unlock this for editing' => 'Desbloquear para la edición',
	'Warning: Changing this field\'s basename may cause serious data loss.' => 'Cuidado: El cambio del nombre base del campo podría causar la pérdida de datos.',
	'Template Tag' => 'Etiqueta de plantilla',
	'Create a custom template tag for this field.' => 'Crea una etiqueta de plantilla personalizada para este campo.',
	'Example Template Code' => 'Código de ejemplo',
	'Save this field (s)' => 'Guardar este campo (s)',
	'field' => 'campo',
	'fields' => 'campos',
	'Delete this field (x)' => 'Borrar este campo (x)',

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'Se ha guardado el orden de las entradas. Por favor, recargue la página para ver el nuevo ordenamiento.',
	'Reorder Fields' => 'Reordenar campos',
	'Save field order' => 'Guardar orden de los campos',
	'Close field order widget' => 'Cerrar widget de orden de los campos',
	'open' => 'abrir',
	'click-down and drag to move this field' => 'haga clic y arrastre el campo para moverlo',
	'click to %toggle% this box' => 'haga clic para %toggle% esta casilla',
	'use the arrow keys to move this box' => 'use las flechas para mover esta caja',
	', or press the enter key to %toggle% it' => ', o presione la tecla enter para %toggle%',

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => 'Nuevo campo - [_1]',
	'Delete selected fields (x)' => 'Borrar campos seleccionados (x)',
	'No fields could be found.' => 'No se encontraron campos.',
	'System-Wide' => 'Todo el sistema',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => 'Seleccionar [_1]',
	'Remove [_1]' => 'Borrar [_1]',

## addons/Commercial.pack/templates/notify-entry.mtml

## addons/Commercial.pack/templates/blog_index.mtml

## addons/Commercial.pack/templates/main_index.mtml

## addons/Commercial.pack/templates/page.mtml

## addons/Commercial.pack/templates/entry_summary.mtml

## addons/Commercial.pack/templates/comment_response.mtml

## addons/Commercial.pack/templates/commenter_notify.mtml

## addons/Commercial.pack/templates/recent_entries_expanded.mtml
	'By [_1] | Comments ([_2])' => 'Por [_1] | Commentarios ([_2]) ', # Translate - New

## addons/Commercial.pack/templates/footer-email.mtml

## addons/Commercial.pack/templates/entry_detail.mtml

## addons/Commercial.pack/templates/verify-subscribe.mtml

## addons/Commercial.pack/templates/new-ping.mtml

## addons/Commercial.pack/templates/comment_detail.mtml
	'[_1] [_2] on' => '[_1] [_2] en',
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="Enlace permanente a este comentario">[_2]</a>',

## addons/Commercial.pack/templates/comment_form.mtml

## addons/Commercial.pack/templates/comment_throttle.mtml

## addons/Commercial.pack/templates/new-comment.mtml

## addons/Commercial.pack/templates/entry_listing.mtml

## addons/Commercial.pack/templates/contact.mtml

## addons/Commercial.pack/templates/footer.mtml
	'Powered By (Footer)' => 'Powered By (Pie)',
	'Footer Links' => 'Enlaces del pie',

## addons/Commercial.pack/templates/tags.mtml

## addons/Commercial.pack/templates/navigation.mtml
	'Home' => 'Inicio',

## addons/Commercial.pack/templates/entry_metadata.mtml

## addons/Commercial.pack/templates/entry.mtml

## addons/Commercial.pack/templates/recover-password.mtml

## addons/Commercial.pack/templates/javascript.mtml

## addons/Commercial.pack/templates/rss.mtml

## addons/Commercial.pack/templates/archive_index.mtml

## addons/Commercial.pack/templates/sign_in_top.mtml
	'You are signed in as' => 'Se ha identificado como',
	'.  <a href="[_1]">Sign Out</a>' => '.  <a href="[_1]">Salir</a>', # Translate - New
	'Sign Out' => 'Salir',

## addons/Commercial.pack/templates/trackbacks.mtml
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a> de [_3]',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Enviado desde <a href="[_1]">[_2]</a>',

## addons/Commercial.pack/templates/sidebar.mtml
	'Recent Entries Expanded' => 'Entradas recientes expandidas',
	'Recent Assets' => 'Multimedia reciente',
	'Recent Comments' => 'Comentarios recientes',
	'Category Archives' => 'Archivos por categoría',

## addons/Commercial.pack/templates/powered_by_footer.mtml

## addons/Commercial.pack/templates/categories.mtml

## addons/Commercial.pack/templates/comments.mtml

## addons/Commercial.pack/templates/search_results.mtml

## addons/Commercial.pack/templates/search_top.mtml

## addons/Commercial.pack/templates/header.mtml
	'Sign In (In Header)' => 'Identificación (en la cabecera)',
	'Navigation' => 'Navegación',
	'Search (In Navigation)' => 'Buscar (en la navegación)',
	'Homepage Image' => 'Imagen de la página de inicio',

## addons/Commercial.pack/templates/sidebar_2col.mtml

## addons/Commercial.pack/templates/sidebar_3col.mtml

## addons/Commercial.pack/templates/dynamic_error.mtml

## addons/Commercial.pack/templates/footer_links.mtml
	'Links' => 'Enlaces',

## addons/Commercial.pack/templates/comment_preview.mtml

## addons/Commercial.pack/templates/commenter_confirm.mtml

## addons/Commercial.pack/config.yaml
	'Universal Website' => 'Sitio universal',
	'Themes that are compatible with the Universal Website template set.' => 'Temas que son compatibles con el sistema de las plantillas del Sitio Universal', # Translate - New
	'Blog Index' => 'Índice del blog',
	'Blog Entry Listing' => 'Lista de entradas',

);

1;

