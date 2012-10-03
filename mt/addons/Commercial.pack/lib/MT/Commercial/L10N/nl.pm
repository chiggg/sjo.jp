# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package MT::Commercial::L10N::nl;

use strict;
use base 'MT::Commercial::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (
## addons/Commercial.pack/lib/MT/Commercial/Util.pm
	'About' => 'Over', # Translate - New
	'_UTS_REPLACE_THIS' => '<p><strong>Vervang de voorbeeldtekst door uw eigen informatie.</strong></p>', # Translate - New
	'_UTS_SAMPLE_ABOUT' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies.</p>
}, # Translate - New
	'_UTS_EDIT_LINK' => q{
<!-- verwijder deze link na het bewerken -->
<p class="admin-edit-link">
<script type="text/javascript">document.write('<a href="' + adminurl + '?__mode=view&_type=page&id=' + page_id + '&blog_id=' + blog_id + '" target="_blank">Deze tekst aanpassen</a>')</script>
</p>
}, # Translate - New
	'_UTS_CONTACT' => 'Contact', # Translate - New
	'_UTS_SAMPLE_CONTACT' => q{
<p>Laat ons iets horen!  Stuur e-mail naar e-mail (at) domeinnaam.com</p>
}, # Translate - New
	'Welcome to our new website!' => 'Welkom op onze nieuwe website!', # Translate - New
	'_UTS_SAMPLE_WELCOME' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Aliquam erat volutpat. Ut placerat porta nibh. Donec vitae nulla. Pellentesque nisi leo, pretium a, gravida quis, sollicitudin non, eros. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies. Aliquam sagittis volutpat metus.</p>

<p>Sed enim. Integer hendrerit, arcu ac pretium nonummy, velit turpis faucibus risus, pulvinar egestas enim elit sed ante. Curabitur orci diam, placerat a, faucibus id, condimentum vitae, magna. Etiam enim massa, convallis quis, rutrum vitae, porta quis, turpis.</p>
}, # Translate - New
	'New design launched using Movable Type' => 'Nieuw design gelanceerd met Movable Type', # Translate - New
	'_UTS_SAMPLE_NEWDESIGN' => q{
<p>Onze website zit in een volledig nieuw kleedje dankzij <a href="http://www.movabletype.com/">Movable Type</a> en de Universele Set Sjablonen. Met de Universele Set Sjablonen kan iedereen in een paar minuten van start gaan met een nieuwe website op Movable Type. Dit alles in slechts een paar klikken. Maak een nieuwe blog aan, selecteer de Universele Set Sjablonen en publiceer de site.  Voila: on nieuwe website!. Bedankt Movable Type!</p>
}, # Translate - New

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => 'Toon',
	'Date & Time' => 'Datum en tijd',
	'Date Only' => 'Enkel datum',
	'Time Only' => 'Enkel tijd',
	'Please enter all allowable options for this field as a comma delimited list' => 'Gelieve alle toegestane waarden voor dit veld in te vullen als een lijst gescheiden door komma\'s',
	'Custom Fields' => 'Extra velden',
	'[_1] Fields' => 'Velden bij [_1]',
	'Edit Field' => 'Veld bewerken',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Ongeldige datum \'[_1]\'; datums moeten in het formaat YYYY-MM-DD HH:MM:SS staan.',
	'Invalid date \'[_1]\'; dates should be real dates.' => 'Ongeldige datum \'[_1]\'; datums moeten echte datums zijn.',
	'Please enter valid URL for the URL field: [_1]' => 'Gelieve een geldige URL in te vullen in het URL veld: [_1]',
	'Please enter some value for required \'[_1]\' field.' => 'Gelieve een waarde in te vullen voor het verplichte \'[_1]\' veld.',
	'Please ensure all required fields have been filled in.' => 'Kijk na of alle verplichte velden ingevuld zijn.',
	'The template tag \'[_1]\' is an invalid tag name.' => 'Sjabloontag \'[_1]\' is een ongeldige tagnaam.',
	'The template tag \'[_1]\' is already in use.' => 'De sjabloontag \'[_1]\' is al in gebruik.',
	'The basename \'[_1]\' is already in use.' => 'De basisnaam \'[_1]\' is al in gebruik',
	'Default value must be valid URL.' => 'Standaardwaarde moet een geldige URL zijn.',
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'Pas de formulieren en velden aan voor berichten, pagina\'s, mappen, categoriën en gebruikers aan en sla exact die informatie op die u nodig heeft.',
	' ' => '', # Translate - New
	'Single-Line Text' => 'Een regel tekst',
	'Multi-Line Textfield' => 'Meerdere regels tekst',
	'Checkbox' => 'Checkbox',
	'Date and Time' => 'Datum en tijd',
	'Drop Down Menu' => 'Uitklapmenu',
	'Radio Buttons' => 'Radiobuttons',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => 'Bent u zeker dat u een \'[_1]\' tag gebruikte in de juiste context?  We vonden geen [_2]',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => 'U gebruikte een \'[_1]\' tag buiten de correcte context;',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'Metadata opslag voor pagina\'s word verplaatst...',

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'Custom Fields data opgeslagen in MT::PluginData aan het terugzetten...',
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'Mediabestand-associaties aan het terugzetten die werden gevonden in gepersonaliseerde velden ( [_1] ) ...',
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'URL van de mediabestand aan het terugzetten geassocieerd via gepersonaliseerde velden ( [_1] )',

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => 'Kon [_1]::[_2] niet vinden',

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'Veld',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => 'Selecteer datum',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'Nieuw weld',
	'The selected fields(s) has been deleted from the database.' => 'Geselecteerd(e) veld(en) verwijderd uit de database.',
	'Please ensure all required fields (highlighted) have been filled in.' => 'Gelieve te controleren dat alle verplichte velden (gekleurd) ingevuld zijn.',
	'System Object' => 'Systeemobject',
	'Select the system object this field is for' => 'Selecteer het systeemobject waar dit veld voor dient',
	'Select...' => 'Selecteer...',
	'Required?' => 'Verplicht?',
	'Should a value be chosen or entered into this field?' => 'Moet er een waarde gekozen of ingevuld worden in dit veld?',
	'Default' => 'Standaard',
	'You will need to first save this field in order to set a default value' => 'U moet dit veld eerst opslaan om een standaardwaarde te kunnen instellen',
	'_CF_BASENAME' => 'Basename',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'De basisnaam wordt gebruikt om gepersonaliseerde veld informatie in te voeren via een cliënt van derden.  Hij moet uniek zijn.',
	'Unlock this for editing' => 'Maak dit aanpasbaar',
	'Warning: Changing this field\'s basename may cause serious data loss.' => 'Waarschuwing: de basinaam van dit veld aanpassen kan leiden tot ernstig gegevensverlies.',
	'Template Tag' => 'Sjabloontag',
	'Create a custom template tag for this field.' => 'Maak een gepersonaliseerde sjabloontag aan voor dit veld',
	'Example Template Code' => 'Voorbeeldsjablooncode',
	'Save this field (s)' => 'Dit veld opslaan (s)',
	'field' => 'veld',
	'fields' => 'velden',
	'Delete this field (x)' => 'Dit veld verwijderen (x)',

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'De volgorde van uw velden is opgeslagen.  Vernieuw deze pagina om de nieuwe volgorde te zien.',
	'Reorder Fields' => 'Velden rangschikken',
	'Save field order' => 'Volgorde opslaan',
	'Close field order widget' => 'Widged volgorde velden sluiten',
	'open' => 'open',
	'click-down and drag to move this field' => 'klik en sleep om dit veld te verplaatsen',
	'click to %toggle% this box' => 'klik om dit vakje te %schakelen%',
	'use the arrow keys to move this box' => 'gebruik de pijltjestoetsen om dit vakje te verplaatsen',
	', or press the enter key to %toggle% it' => ', of druk op de enter-toets om het te %schakelen%',

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => 'Nieuw [_1] veld',
	'Delete selected fields (x)' => 'Geselecteerde velden verwijderen (x)',
	'No fields could be found.' => 'Er werden geen velden gevonden.',
	'System-Wide' => 'Over heel het systeem',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => 'Kies [_1]',
	'Remove [_1]' => 'Verwijder [_1]',

## addons/Commercial.pack/templates/notify-entry.mtml

## addons/Commercial.pack/templates/blog_index.mtml

## addons/Commercial.pack/templates/main_index.mtml

## addons/Commercial.pack/templates/page.mtml

## addons/Commercial.pack/templates/entry_summary.mtml

## addons/Commercial.pack/templates/comment_response.mtml

## addons/Commercial.pack/templates/commenter_notify.mtml

## addons/Commercial.pack/templates/recent_entries_expanded.mtml

## addons/Commercial.pack/templates/footer-email.mtml

## addons/Commercial.pack/templates/entry_detail.mtml

## addons/Commercial.pack/templates/verify-subscribe.mtml

## addons/Commercial.pack/templates/new-ping.mtml

## addons/Commercial.pack/templates/comment_detail.mtml
	'[_1] [_2] on' => '[_1] [_2] op', # Translate - New
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="Permalink naar deze reactie">[_2]</a>',

## addons/Commercial.pack/templates/comment_form.mtml

## addons/Commercial.pack/templates/comment_throttle.mtml

## addons/Commercial.pack/templates/new-comment.mtml

## addons/Commercial.pack/templates/entry_listing.mtml

## addons/Commercial.pack/templates/contact.mtml

## addons/Commercial.pack/templates/footer.mtml
	'Powered By (Footer)' => 'Aangedreven door (voettekst)', # Translate - New
	'Footer Links' => 'Links in voettekst', # Translate - New

## addons/Commercial.pack/templates/tags.mtml

## addons/Commercial.pack/templates/navigation.mtml
	'Home' => 'Hoofdpagina',

## addons/Commercial.pack/templates/entry.mtml

## addons/Commercial.pack/templates/recover-password.mtml

## addons/Commercial.pack/templates/javascript.mtml

## addons/Commercial.pack/templates/rss.mtml

## addons/Commercial.pack/templates/archive_index.mtml

## addons/Commercial.pack/templates/sign_in_top.mtml
	'You are signed in as' => 'U bent aangemeld als', # Translate - New
	'Sign Out' => 'Afmelden', # Translate - Case

## addons/Commercial.pack/templates/trackbacks.mtml
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a> van [_3]',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Getracked op <a href="[_1]">[_2]</a>',

## addons/Commercial.pack/templates/sidebar.mtml
	'Recent Entries Expanded' => 'Recent aangepaste berichten', # Translate - New
	'Recent Assets' => 'Recente mediabestanden',
	'Recent Comments' => 'Recente reacties',
	'Category Archives' => 'Archieven per categorie',

## addons/Commercial.pack/templates/powered_by_footer.mtml

## addons/Commercial.pack/templates/categories.mtml

## addons/Commercial.pack/templates/comments.mtml

## addons/Commercial.pack/templates/search_results.mtml

## addons/Commercial.pack/templates/search_top.mtml

## addons/Commercial.pack/templates/header.mtml
	'Sign In (In Header)' => 'Registratie (in hoofding)', # Translate - New
	'Navigation' => 'Navigatie',
	'Search (In Navigation)' => 'Zoeken (in navigatie)', # Translate - New
	'Homepage Image' => 'Afbeelding op hoofdpagina', # Translate - New

## addons/Commercial.pack/templates/sidebar_2col.mtml

## addons/Commercial.pack/templates/sidebar_3col.mtml

## addons/Commercial.pack/templates/dynamic_error.mtml

## addons/Commercial.pack/templates/footer_links.mtml
	'Links' => 'Links', # Translate - New

## addons/Commercial.pack/templates/comment_preview.mtml

## addons/Commercial.pack/templates/commenter_confirm.mtml

## addons/Commercial.pack/config.yaml
	'Universal Website' => 'Universele website', # Translate - New
	'Themes that are compatible with the Universal Website template set.' => 'Designs die compatibel zijn met de Universele Website sjabloonset.', # Translate - New
	'Blog Index' => 'Blog index', # Translate - New
	'Blog Entry Listing' => 'Overzicht blogberichten', # Translate - New

## addons/Commercial.pack/templates/recent_entries_expanded.mtml
	'By [_1] | Comments ([_2])' => 'Door [_1] | Reacties ([_2])', # Translate - New
	'.  <a href="[_1]">Sign Out</a>' => '.  <a href="[_1]">Afmelden</a>', # Translate - New
	

);

1;

