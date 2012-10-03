# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package MT::Commercial::L10N::fr;

use strict;
use base 'MT::Commercial::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (
## addons/Commercial.pack/lib/MT/Commercial/Util.pm
	'About' => 'A propos de', # Translate - New
	'_UTS_REPLACE_THIS' => '<p><strong>Remplacez ce texte d\'exemple par vos propres informations.</strong></p>', # Translate - New
	'_UTS_SAMPLE_ABOUT' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies.</p>
}, # Translate - New
	'_UTS_EDIT_LINK' => q{
<!-- retirer ce lien après l'édition -->
<p class="admin-edit-link">
<script type="text/javascript">document.write('<a href="' + adminurl + '?__mode=view&_type=page&id=' + page_id + '&blog_id=' + blog_id + '" target="_blank">Éditer ce contenu</a>')</script>
</p>
}, # Translate - New
	'_UTS_CONTACT' => 'Contacter', # Translate - New
	'_UTS_SAMPLE_CONTACT' => q{
<p>Nous adorerions avoir de vos nouvelles. Envoyez un email à email (at) nomdedomaine.com</p>
}, # Translate - New
	'Welcome to our new website!' => 'Bienvenue sur notre nouveau site !', # Translate - New
	'_UTS_SAMPLE_WELCOME' => q{
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Aliquam erat volutpat. Ut placerat porta nibh. Donec vitae nulla. Pellentesque nisi leo, pretium a, gravida quis, sollicitudin non, eros. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies. Aliquam sagittis volutpat metus.</p>

<p>Sed enim. Integer hendrerit, arcu ac pretium nonummy, velit turpis faucibus risus, pulvinar egestas enim elit sed ante. Curabitur orci diam, placerat a, faucibus id, condimentum vitae, magna. Etiam enim massa, convallis quis, rutrum vitae, porta quis, turpis.</p>
}, # Translate - New
	'New design launched using Movable Type' => 'Nouveau design lancé en utilisant Movable Type', # Translate - New
	'_UTS_SAMPLE_NEWDESIGN' => q{
<p>Notre nouveau site internet est habillé d'un nouvel habillage grâce à <a href="http://www.movabletype.com/">Movable Type</a> et les Groupes d'Habillages Universels. Les Groupes d'Habillages Universels rendent facile et accessible à n'importe qui la mise en place et l'animation d'un site internet utilisant Movable Type. Et cela ne vous prendra que quelques instants#160;! Sélectionnez-en un simplement pour votre nouveau site web et publiez. Voilà#160;! Merci Movable Type#160;!</p> 
}, # Translate - New

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => 'Afficher',
	'Date & Time' => 'Date & heure',
	'Date Only' => 'Date seulement',
	'Time Only' => 'Heure seulement',
	'Please enter all allowable options for this field as a comma delimited list' => 'Merci de saisir toutes les options autorisées pour ce champ dans une liste délimitée par des virgules',
	'Custom Fields' => 'Champs personnalisés',
	'[_1] Fields' => '[_1] champs',
	'Edit Field' => 'Modifier le champ',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Date invalide \'[_1]\'; les dates doivent être dans le format YYYY-MM-DD HH:MM:SS.',
	'Invalid date \'[_1]\'; dates should be real dates.' => 'Date invalide \'[_1]\'; les dates doivent être de vraies dates.',
	'Please enter valid URL for the URL field: [_1]' => 'Merci de saisir une URL correcte pour le champ URL : [_1]', # Translate - New
	'Please enter some value for required \'[_1]\' field.' => 'Merci de saisir une valeur pour le champ obligatoire \'[_1]\'.',
	'Please ensure all required fields have been filled in.' => 'Merci de vérifier que tous les champs obligatoires ont été remplis.',
	'The template tag \'[_1]\' is an invalid tag name.' => 'Le tag de gabarit \'[_1]\' est un nom de tag invalide',
	'The template tag \'[_1]\' is already in use.' => 'Le tag de gabarit \'[_1]\' est déjà utilisé.',
	'The basename \'[_1]\' is already in use.' => 'Le nom de base \'[_1]\' est déjà utilisé.',
	'Default value must be valid URL.' => 'La valeur par défaut doit être une URL valide.', # Translate - New
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'Personnalisez les champs des notes, pages, répertoires, catégories et auteurs pour stocker toutes les informations dont vous avez besoin.',
	' ' => ' ', # Translate - Case
	'Single-Line Text' => 'Texte sur une ligne',
	'Multi-Line Textfield' => 'Champ texte de plusieurs lignes',
	'Checkbox' => 'Case à cocher',
	'Date and Time' => 'Date et heure',
	'Drop Down Menu' => 'Menu déroulant',
	'Radio Buttons' => 'Boutons radio',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => 'Etes-vous sûr d\'avoir utilisé un tag \'[_1]\' dans le contexte approprié ? Impossible de trouver le [_2]',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => 'Vous avez utilisé un tag \'[_1]\' en dehors du contexte du contenu correct; ',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'Déplacement de l\'emplacement des métadonnées des pages en cours ...',

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'Restauration des données des champs personnalisés stockées dans MT:PluginData...',
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'Restauration des associations d\'éléments trouvés dans les champs personnalisés ([_1]) ...',
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'Restauration des URLs des éléments associés dans les champs personnalisés ([_1]) ...',

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => 'Impossible de trouver [_1]::[_2]',

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'Champ',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => 'Sélectionner la date',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'Nouveau champ',
	'The selected fields(s) has been deleted from the database.' => 'Les champs sélectionnés ont été effacés de la base de données.',
	'Please ensure all required fields (highlighted) have been filled in.' => 'Merci de vérifier que tous les champs obligatoires ont été remplis.',
	'System Object' => 'Objet système',
	'Select the system object this field is for' => 'Sélectionner l\'objet système auquel ce champ est rattaché',
	'Select...' => 'Sélectionnez...',
	'Required?' => 'Obligatoire?',
	'Should a value be chosen or entered into this field?' => 'Une valeur doit-elle être choisie ou saisie dans ce champ?',
	'Default' => 'Défaut',
	'You will need to first save this field in order to set a default value' => 'Vous devez d\'abord enregistrer ce champ pour pouvoir mettre une valeur par défaut',
	'_CF_BASENAME' => 'Nom de base',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'Le nom de base est utilisé pour entrer les données d\'un champs personnalisé à travers un logiciel tiers. Il doit être unique. ',
	'Unlock this for editing' => 'Déverrouiller pour modifier',
	'Warning: Changing this field\'s basename may cause serious data loss.' => 'Attention: Changer le nom de base du champ peut causer des pertes de données sérieuses.',
	'Template Tag' => 'Tag du gabarit',
	'Create a custom template tag for this field.' => 'Créer un tag de gabarit personnalisé pour ce champ.',
	'Example Template Code' => 'Code de gabarit exemple',
	'Save this field (s)' => 'Enregistrer ce champs (s)',
	'field' => 'champ',
	'fields' => 'Champs',
	'Delete this field (x)' => 'Supprimer ce champs (x)',

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'L\'ordre des champs a été sauvegardé. Merci de recharger cette page pour voir le nouvel ordre.',
	'Reorder Fields' => 'Réordonner les champs',
	'Save field order' => 'Enregistrer l\'ordre des champs',
	'Close field order widget' => 'Fermer le module de changement d\'ordre des champs',
	'open' => 'ouvrir',
	'click-down and drag to move this field' => 'gardez le clic maintenu et glissez le curseur pour déplacer ce champs',
	'click to %toggle% this box' => 'cliquez pour %toggle% cette boîte',
	'use the arrow keys to move this box' => 'utilisez les touches flêchées de votre clavier pour déplacer cette boîte',
	', or press the enter key to %toggle% it' => ', ou pressez la touche entrée pour la %toggle%',

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => 'Nouveau champ [_1]',
	'Delete selected fields (x)' => 'Effacer les champs sélectionnés (x)',
	'No fields could be found.' => 'Aucun champ n\'a été trouvé.',
	'System-Wide' => 'sur tout le système',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => 'Choisir [_1]',
	'Remove [_1]' => 'Supprimer [_1]',

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
	'[_1] [_2] on' => '[_1] [_2] sur', # Translate - New
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="Lien permanent vers ce commentaire">[_2]</a>',

## addons/Commercial.pack/templates/comment_form.mtml

## addons/Commercial.pack/templates/comment_throttle.mtml

## addons/Commercial.pack/templates/new-comment.mtml

## addons/Commercial.pack/templates/entry_listing.mtml

## addons/Commercial.pack/templates/contact.mtml

## addons/Commercial.pack/templates/footer.mtml
	'Powered By (Footer)' => 'Powered By (Pied de Page)', # Translate - New
	'Footer Links' => 'Liens de Pied de Page', # Translate - New

## addons/Commercial.pack/templates/tags.mtml

## addons/Commercial.pack/templates/navigation.mtml
	'Home' => 'Accueil',

## addons/Commercial.pack/templates/entry.mtml

## addons/Commercial.pack/templates/recover-password.mtml

## addons/Commercial.pack/templates/javascript.mtml

## addons/Commercial.pack/templates/rss.mtml

## addons/Commercial.pack/templates/archive_index.mtml

## addons/Commercial.pack/templates/sign_in_top.mtml
	'You are signed in as' => 'Vous êtes identifié comme étant', # Translate - New
	'Sign Out' => 'Se Déconnecter', # Translate - Case

## addons/Commercial.pack/templates/trackbacks.mtml
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a> de [_3]',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Tracké le <a href="[_1]">[_2]</a>',

## addons/Commercial.pack/templates/sidebar.mtml
	'Recent Entries Expanded' => 'Entrées étendues récentes', # Translate - New
	'Recent Assets' => 'Éléments récents',
	'Recent Comments' => 'Commentaires récents',
	'Category Archives' => 'Archives par Catégories',

## addons/Commercial.pack/templates/powered_by_footer.mtml

## addons/Commercial.pack/templates/categories.mtml

## addons/Commercial.pack/templates/comments.mtml

## addons/Commercial.pack/templates/search_results.mtml

## addons/Commercial.pack/templates/search_top.mtml

## addons/Commercial.pack/templates/header.mtml
	'Sign In (In Header)' => 'S\'identifier (Dans l\'En-tête de la Page)', # Translate - New
	'Navigation' => 'Navigation',
	'Search (In Navigation)' => 'Rechercher (Dans la Navigation)', # Translate - New
	'Homepage Image' => 'Image de Page d\'Accueil', # Translate - New

## addons/Commercial.pack/templates/sidebar_2col.mtml

## addons/Commercial.pack/templates/sidebar_3col.mtml

## addons/Commercial.pack/templates/dynamic_error.mtml

## addons/Commercial.pack/templates/footer_links.mtml
	'Links' => 'Liens', # Translate - New

## addons/Commercial.pack/templates/comment_preview.mtml

## addons/Commercial.pack/templates/commenter_confirm.mtml

## addons/Commercial.pack/config.yaml
	'Universal Website' => 'Site Universel', # Translate - New
	'Blog Index' => 'Index du Blog', # Translate - New
	'Blog Entry Listing' => 'Liste des Notes du Blog', # Translate - New
	'By [_1] | Comments ([_2])' => 'Par [_1] | Commentaires ([_1])', # Translate - New
	'.  <a href="[_1]">Sign Out</a>' => '<a href="[_1]">Se Déconnecter</a>', # Translate - New
	'Themes that are compatible with the Universal Website template set.' => 'Thèmes étant compatibles avec les groupes de gabarits de Sites Universels.', # Translate - New	
	);

1;

