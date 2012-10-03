# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package MT::Commercial::L10N::de;

use strict;
use base 'MT::Commercial::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (
## addons/Commercial.pack/lib/MT/Commercial/Util.pm
	'About' => 'Über', # Translate - New
	'_UTS_REPLACE_THIS' => '<p><strong>Ersetzen Sie diesen Text durch Ihre eigenen Informationen.</strong></p>', # Translate - New
	'_UTS_SAMPLE_ABOUT' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies.</p>
}, # Translate - New # OK
	'_UTS_EDIT_LINK' => q{
<!-- Entfernen Sie diesen Link nach der Bearbeitung -->
<p class="admin-edit-link">
<script type="text/javascript">document.write('<a href="' + adminurl + '?__mode=view&_type=page&id=' + page_id + '&blog_id=' + blog_id + '" target="_blank">Diesen Text anpassen</a>')</script>
</p>
}, # Translate - New # OK
	'_UTS_CONTACT' => 'Kontakt', # Translate - New # OK
	'_UTS_SAMPLE_CONTACT' => q{
<p>Wir freuen uns darauf, von Ihnen zu hören. Senden Sie Ihre E-Mail an email (at) domainname.de</p>
}, # Translate - New
	'Welcome to our new website!' => 'Willkommen auf unserer neuen Website!', # Translate - New # OK
	'_UTS_SAMPLE_WELCOME' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Aliquam erat volutpat. Ut placerat porta nibh. Donec vitae nulla. Pellentesque nisi leo, pretium a, gravida quis, sollicitudin non, eros. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies. Aliquam sagittis volutpat metus.</p>

<p>Sed enim. Integer hendrerit, arcu ac pretium nonummy, velit turpis faucibus risus, pulvinar egestas enim elit sed ante. Curabitur orci diam, placerat a, faucibus id, condimentum vitae, magna. Etiam enim massa, convallis quis, rutrum vitae, porta quis, turpis.</p>
}, # Translate - New # OK
	'New design launched using Movable Type' => 'Neue Website auf Basis von Movable Type', # Translate - New # OK
	'_UTS_SAMPLE_NEWDESIGN' => q{ 
<p>Unsere Website hat ein neues Aussehen - dank <a href="http://www.movabletype.com/">Movable Type</a> und der Universellen Vorlagengruppe. Mit der Universellen Vorlagengruppe kann so gut wie jeder eine neue Website mit Movable Type anlegen. Neue Vorlagengruppe anlegen, "Universelle Vorlagengruppe" auswählen, "Veröffentlichen" klicken - fertig! So einfach war es noch nie. Danke, Movable Type!</p>
}, # Translate - New # OK

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => 'Zeige',
	'Date & Time' => 'Datum- und Uhrzeit',
	'Date Only' => 'Nur Datum',
	'Time Only' => 'Nur Uhrzeit',
	'Please enter all allowable options for this field as a comma delimited list' => 'Bitte geben Sie alle für dieses Feld zulässigen Optionen als kommagetrennte Liste ein.',
	'Custom Fields' => 'Eigene Felder',
	'[_1] Fields' => '[_1]-Felder',
	'Edit Field' => 'Feld bearbeiten',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Ungültige Datumsangabe \'[_1]\' - Datumsangaben müssen das Format JJJJ-MM-TT HH:MM:SS haben.',
	'Invalid date \'[_1]\'; dates should be real dates.' => 'Ungültige Datumsangabe \'[_1]\' - Datumsangaben sollten tatsächliche Daten sein',
	'Please enter valid URL for the URL field: [_1]' => 'Bitte geben Sie eine gültige Web-Adresse in das Feld [_1] ein.', # Translate - New # OK
	'Please enter some value for required \'[_1]\' field.' => 'Bitte füllen Sie das erforderliche Feld \'[_1]\' aus.',
	'Please ensure all required fields have been filled in.' => 'Bitte füllen Sie alle erforderlichen Felder aus.',
	'The template tag \'[_1]\' is an invalid tag name.' => '\'[_1]\' ist ein ungültiger Befehlsname.',
	'The template tag \'[_1]\' is already in use.' => 'Vorlagenbefehl \'[_1]\' bereits vorhanden',
	'The basename \'[_1]\' is already in use.' => 'Basisname \'[_1]\' bereits vorhanden',
	'Default value must be valid URL.' => 'Der Standardwert muss eine gültige Web-Adresse sein.', # Translate - New # OK
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'Speichern Sie genau die Informationen, die Sie möchten, indem Sie die Formulare und Felder von Einträgen, Seiten, Ordnern, Kategorien und Benutzerkonten frei anpassen.',
	' ' => '', # Translate - New # OK
	'Single-Line Text' => 'Einzeiliger Text',
	'Multi-Line Textfield' => 'Mehrzeiliger Text',
	'Checkbox' => 'Auswahlkästchen',
	'Date and Time' => 'Datum und Uhrzeit',
	'Drop Down Menu' => 'Drop-Down-Menü',
	'Radio Buttons' => 'Auswahlknöpfe',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => 'Wird der \'[_1]\'-Befehl im richtigen Kontext verwendet? Kann [_2] nicht finden',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => '\'[_1]\'-Befehl außerhalb des passenden Kontexts verwendet.',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'Verschiebe Metadatenspeicher für Seiten...',

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'Stelle eigene Felder aus MT::PluginData wieder her...',
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'Stelle Assetverknüpfungen aus eigenen Feldern wieder her...',
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'Stelle die Adressen der in eigenen Feldern verwendeten Assets wieder her...',

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => 'Konnte [_1]::[_2] nicht finden',

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'Feld',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => 'Datum wählen',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'Neues Feld',
	'The selected fields(s) has been deleted from the database.' => 'Gewählten Felder aus Datenbank gelöscht.',
	'Please ensure all required fields (highlighted) have been filled in.' => 'Bitte füllen Sie alle erforderlichen (hervorgehobenen) Felder aus.',
	'System Object' => 'Systemobjekt',
	'Select the system object this field is for' => 'Wählen Sie aus, auf welches Systemobjekt sich dieses Feld bezieht',
	'Select...' => 'Wählen...',
	'Required?' => 'Erforderlich?',
	'Should a value be chosen or entered into this field?' => 'Ist diese Option aktiv, muss das Formularfeld ausgefüllt werden.',
	'Default' => 'Standardwert',
	'You will need to first save this field in order to set a default value' => 'Um den Standardwert festlegen zu können, speichern Sie das Feld bitte vorher.',
	'_CF_BASENAME' => 'Basisname',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'Der Basisname wird für das Befüllen eigener Felder durch externe Software verwendet. Basisnamen müssen eindeutig sein.',
	'Unlock this for editing' => 'Zur Bearbeitung freischalten',
	'Warning: Changing this field\'s basename may cause serious data loss.' => 'Achtung: Änderungen des Basisnamens eines Feldes kann zu erheblichen Datenverlusten führen!',
	'Template Tag' => 'Vorlagenbefehl',
	'Create a custom template tag for this field.' => 'Einen eigenen Vorlagenbefehl für dieses Feld anlegen.',
	'Example Template Code' => 'Beispiel-Vorlagencode',
	'Save this field (s)' => 'Dieses Feld speichern (s)',
	'field' => 'Feld',
	'fields' => 'Felder',
	'Delete this field (x)' => 'Dieses Feld löschen (x)',

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'Felder gespeichert. Bitte laden Sie die Seite neu, um die Felder in ihrer neuen Reihenfolge angezeigt zu bekommen.',
	'Reorder Fields' => 'Felder anordnen',
	'Save field order' => 'Reihenfolge speichern',
	'Close field order widget' => 'Reihenfolgenwidget schließen',
	'open' => 'öffnen',
	'click-down and drag to move this field' => 'bei gedrückter Maustaste ziehen, um das Feld zu verschieben',
	'click to %toggle% this box' => 'klicken um das Feld an- oder abzuwählen',
	'use the arrow keys to move this box' => 'mit den Pfeiltasten verschieben',
	', or press the enter key to %toggle% it' => 'oder Enter drücken zum An- oder Abwählen',

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => 'Neues [_1] Feld',
	'Delete selected fields (x)' => 'Gewählte Felder löschen (x)',
	'No fields could be found.' => 'Keine Felder gefunden.',
	'System-Wide' => 'Systemweit',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => '[_1] wählen',
	'Remove [_1]' => '[_1] löschen',

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
	'[_1] [_2] on' => '[_1] [_2] zu', # Translate - New # OK
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="Peramlink dieses Eintrags">[_2]</a>',

## addons/Commercial.pack/templates/comment_form.mtml

## addons/Commercial.pack/templates/comment_throttle.mtml

## addons/Commercial.pack/templates/new-comment.mtml

## addons/Commercial.pack/templates/entry_listing.mtml

## addons/Commercial.pack/templates/contact.mtml

## addons/Commercial.pack/templates/footer.mtml
	'Powered By (Footer)' => 'Powered by (Fußzeile)', # Translate - New # OK
	'Footer Links' => 'Fußzeilen-Links', # Translate - New # OK

## addons/Commercial.pack/templates/tags.mtml

## addons/Commercial.pack/templates/navigation.mtml
	'Home' => 'Startseite',

## addons/Commercial.pack/templates/entry.mtml

## addons/Commercial.pack/templates/recover-password.mtml

## addons/Commercial.pack/templates/javascript.mtml

## addons/Commercial.pack/templates/rss.mtml

## addons/Commercial.pack/templates/archive_index.mtml

## addons/Commercial.pack/templates/sign_in_top.mtml
	'You are signed in as' => 'Sie sind angemeldet als', # Translate - New # OK
	'Sign Out' => 'Abmelden', # Translate - Case # OK

## addons/Commercial.pack/templates/trackbacks.mtml
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a> von [_3]',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Gesehen auf <a href="[_1]">[_2]</a>',

## addons/Commercial.pack/templates/sidebar.mtml
	'Recent Entries Expanded' => 'Neueste Einträge (erweitert)', # Translate - New # OK
	'Recent Assets' => 'Neue Assets',
	'Recent Comments' => 'Neueste Kommentare',
	'Category Archives' => 'Kategoriearchive',

## addons/Commercial.pack/templates/powered_by_footer.mtml

## addons/Commercial.pack/templates/categories.mtml

## addons/Commercial.pack/templates/comments.mtml

## addons/Commercial.pack/templates/search_results.mtml

## addons/Commercial.pack/templates/search_top.mtml

## addons/Commercial.pack/templates/header.mtml
	'Sign In (In Header)' => 'Anmelden (in Kopfzeile)', # Translate - New # OK
	'Navigation' => 'Navigation',
	'Search (In Navigation)' => 'Suche (in Navigation)', # Translate - New # OK
	'Homepage Image' => 'Homepage-Bild', # Translate - New # OK

## addons/Commercial.pack/templates/sidebar_2col.mtml

## addons/Commercial.pack/templates/sidebar_3col.mtml

## addons/Commercial.pack/templates/dynamic_error.mtml

## addons/Commercial.pack/templates/footer_links.mtml
	'Links' => 'Links', # Translate - New # OK

## addons/Commercial.pack/templates/comment_preview.mtml

## addons/Commercial.pack/templates/commenter_confirm.mtml

## addons/Commercial.pack/config.yaml
	'Universal Website' => 'Universelle Website', # Translate - New # OK
	'Blog Index' => 'Blog-Index', # Translate - New # OK
	'Blog Entry Listing' => 'Blog-Eintragsverzeichnis', # Translate - New # OK
	'By [_1] | Comments ([_2])' => 'Von [_1] | Kommentare ([_2])', # Translate - New # OK
	'.  <a href="[_1]">Sign Out</a>' => '. <a href="[_1]">Abmelden</a>', # Translate - New # OK
	'Themes that are compatible with the Universal Website template set.' => 'Mit der Universellen Vorlagengruppe kompatible Designvorlagen', # Translate - New # OK
);

1;

