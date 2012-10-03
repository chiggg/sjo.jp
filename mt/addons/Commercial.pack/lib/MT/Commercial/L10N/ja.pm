# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: ja.pm 71644 2008-01-22 09:57:24Z fyoshimatsu $

package MT::Commercial::L10N::ja;

use strict;
use base 'MT::Commercial::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

## addons/Commercial.pack/lib/MT/Commercial/Util.pm
	'About' => 'About', # Translate - New
	'_UTS_REPLACE_THIS' => '<p><strong>以下の文章はサンプルです。内容を適切に書き換えてください。</strong></p>', # Translate - New
    '_UTS_SAMPLE_ABOUT' => q{
<p>いろはにほへと ちりぬるを わかよたれそ つねならむ うゐのおくやま けふこえて あさきゆめみし ゑひもせす</p>
<p>色は匂へど 散りぬるを 我が世誰ぞ 常ならむ 有為の奥山 今日越えて 浅き夢見じ 酔ひもせず</p>
},
    '_UTS_EDIT_LINK' => q{
<!-- 以下のリンクは削除してください。 -->
<p class="admin-edit-link">
<script type="text/javascript">document.write('<a href="' + adminurl + '?__mode=view&_type=page&id=' + page_id + '&blog_id=' + blog_id + '" target="_blank">コンテンツを編集</a>')</script>
</p>
},
	'_UTS_CONTACT' => 'お問い合わせ', # Translate - New
    '_UTS_SAMPLE_CONTACT' => q{
<p>お問い合わせはメールで: email (at) domainname.com</p>
},
	'Welcome to our new website!' => '私たちの新しいウェブサイトへようこそ!', # Translate - New
	'_UTS_SAMPLE_WELCOME' => q{
<p>いろはにほへと ちりぬるを わかよたれそ つねならむ うゐのおくやま けふこえて あさきゆめみし ゑひもせす</p>
<p>色は匂へど 散りぬるを 我が世誰ぞ 常ならむ 有為の奥山 今日越えて 浅き夢見じ 酔ひもせず</p>
<p>あめ つち ほし そら やま かは みね たに くも きり むろ こけ ひと いぬ うへ すゑ ゆわ さる おふ せよ えのえを なれ ゐて</p>
},
	'New design launched using Movable Type' => 'Movable Type を利用してウェブサイトをリニューアルしました', # Translate - New
	'_UTS_SAMPLE_NEWDESIGN' => q{
<p>私たちのウェブサイトは、<a href="http://www.movabletype.jp">Movable Type</a>と汎用テンプレートセットを使って生まれ変わりました。汎用テンプレートセットを使えば、Movable Typeを使って新しいウェブサイトを誰でも簡単に、実際に数回のマウスクリックだけで立ち上げることができます。ウェブサイトのためのブログを作成して、汎用ウェブサイトのセットを選んで、再構築するだけです。ほらご覧のとおり！Movable Type のおかげでこんなに簡単にウェブサイトを作成できました！</p>
},

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'フィールド',

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => '[_1]::[_2]が見つかりませんでした。',

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => '表示',
	'Date & Time' => '日付と時刻',
	'Date Only' => '日付',
	'Time Only' => '時刻',
	'Please enter all allowable options for this field as a comma delimited list' => 'このフィールドで有効なすべてのオプションをカンマで区切って入力してください。',
	'Custom Fields' => 'カスタムフィールド',
	'[_1] Fields' => '[_1]フィールド',
	'Edit Field' => 'フィールドの編集',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => '日時が不正です。日時はYYYY-MM-DD HH:MM:SSの形式で入力してください。',
	'Invalid date \'[_1]\'; dates should be real dates.' => '日時が不正です。',
	'Please enter valid URL for the URL field: [_1]' => 'URLを入力してください。[_1]',
	'Please enter some value for required \'[_1]\' field.' => '「[_1]」は必須です。値を入力してください。',
	'Please ensure all required fields have been filled in.' => '必須のフィールドに値が入力されていません。',
	'The template tag \'[_1]\' is an invalid tag name.' => '[_1]というタグ名は不正です。',
	'The template tag \'[_1]\' is already in use.' => '[_1]というタグは既に存在します。',
	'The basename \'[_1]\' is already in use.' => '[_1]という名前はすでに使われています。',
	'Default value must be valid URL.' => '既定値にはURLを指定してください。',
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'ブログ記事、ウェブページ、フォルダ、カテゴリ、ユーザーのフォームとフィールドをカスタマイズして、必要な情報を格納することができます。',
	' ' => ' ',
	'Single-Line Text' => 'テキスト',
	'Multi-Line Textfield' => 'テキスト(複数行)',
	'Checkbox' => 'チェックボックス',
	'Date and Time' => '日付と時刻',
	'Drop Down Menu' => 'ドロップダウン',
	'Radio Buttons' => 'ラジオボタン',

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'MT::PluginDataに保存されているカスタムフィールドのデータを復元しています...',
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'カスタムフィールド([_1])に含まれるアイテムとの関連付けを復元しています...',
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'カスタムフィールド([_1])に含まれるアイテムのURLを復元しています...',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => '[_2]が見つかりませんでした。[_1]タグを正しいコンテキストで使用しているか確認してください。',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => '[_1]タグを正しいコンテキストで使用していません。',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'ウェブページのメタデータ格納先を変更しています...',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => '[_1]を選択',
	'Remove [_1]' => '[_1]を削除',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => '日付を選択',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'フィールドを作成',
	'The selected fields(s) has been deleted from the database.' => '選択されたフィールドはデータベースから削除されました。',
	'Please ensure all required fields (highlighted) have been filled in.' => 'すべての必須フィールドに値を入力してください。',
	'System Object' => 'システムオブジェクト',
	'Select the system object this field is for' => 'フィールドを追加するオブジェクトを選択してください。',
	'Select...' => '選択...',
	'Required?' => '必須?',
	'Should a value be chosen or entered into this field?' => 'フィールドに値は必須ですか?',
	'Default' => '既定値',
	'You will need to first save this field in order to set a default value' => '既定値を設定する前にフィールドを保存する必要があります。',
	'_CF_BASENAME' => 'ベースネーム',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'ベースネームはサードパーティのクライアントから利用されることがあります。名前は一意でなければなりません。',
	'Unlock this for editing' => 'ロックを解除して編集します',
	'Warning: Changing this field\'s basename may cause serious data loss.' => '警告: フィールド名を変更するとデータが失われます。',
	'Template Tag' => 'テンプレートタグ',
	'Create a custom template tag for this field.' => 'このフィールドの値を出力するテンプレートタグを作成します。',
	'Example Template Code' => 'テンプレートの例',
	'Save this field (s)' => 'このフィールドを保存 (s)',
	'field' => 'フィールド',
	'fields' => 'フィールド',
	'Delete this field (x)' => 'フィールドを削除 (x)',

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'フィールドの順序を保存しました。画面を更新してください。',
	'Reorder Fields' => 'フィールドの順序',
	'Save field order' => 'フィールドの順序を保存する',
	'Close field order widget' => '閉じる',
	'open' => '開く',
	'click-down and drag to move this field' => 'フィールドをドラッグして移動します。',
	'click to %toggle% this box' => '%toggle%ときはクリックします。',
	'use the arrow keys to move this box' => '矢印キーでボックスを移動します。',
	', or press the enter key to %toggle% it' => '%toggle%ときはENTERキーを押します。',

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => '[_1]フィールドを作成',
	'Delete selected fields (x)' => '選択されたフィールドを削除する (x)',
	'No fields could be found.' => 'フィールドが見つかりませんでした。',
	'System-Wide' => 'システム全体',

## addons/Commercial.pack/config.yaml
	'Universal Website' => '汎用ウェブサイト',
	'Themes that are compatible with the Universal Website template set.' => '汎用ウェブサイトテンプレートセットに対応したテーマ',
	'Blog Index' => 'ブログのメインページ',
	'Blog Entry Listing' => 'ブログ記事のリスト',
	'Navigation' => 'ナビゲーション',
	'Homepage Image' => 'ホームページの画像',
	'Powered By (Footer)' => 'Powered By (フッター)',
	'Sign In (In Header)' => 'サインイン (ヘッダー)',
	'Search (In Navigation)' => '検索 (ナビゲーション)',
	'Recent Entries Expanded' => '最近のブログ記事 (拡張)',

## addons/Commercial.pack/templates/comment_throttle.mtml

## addons/Commercial.pack/templates/entry.mtml

## addons/Commercial.pack/templates/navigation.mtml
	'Home' => 'ホーム',

## addons/Commercial.pack/templates/footer-email.mtml

## addons/Commercial.pack/templates/sidebar.mtml
	'Recent Assets' => 'アイテム',
	'Recent Comments' => '最近のコメント',
	'Category Archives' => 'カテゴリアーカイブ',

## addons/Commercial.pack/templates/sidebar_3col.mtml

## addons/Commercial.pack/templates/blog_index.mtml

## addons/Commercial.pack/templates/comments.mtml

## addons/Commercial.pack/templates/new-comment.mtml

## addons/Commercial.pack/templates/footer.mtml
	'Footer Links' => 'フッターのリンク',

## addons/Commercial.pack/templates/sidebar_2col.mtml

## addons/Commercial.pack/templates/categories.mtml

## addons/Commercial.pack/templates/trackbacks.mtml
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a>([_3])からのトラックバック',
	'Tracked on <a href="[_1]">[_2]</a>' => '<a href="[_1]">[_2]</a>',

## addons/Commercial.pack/templates/recent_entries_expanded.mtml
    'By [_1] | Comments ([_2])' => '[_1] | コメント([_2])',

## addons/Commercial.pack/templates/entry_detail.mtml

## addons/Commercial.pack/templates/sign_in_top.mtml
	'You are signed in as' => 'ユーザー:', # Translate - New
	'.  <a href="[_1]">Sign Out</a>' => '  <a href="[_1]">サインアウト</a>', # Translate - Case

## addons/Commercial.pack/templates/comment_response.mtml

## addons/Commercial.pack/templates/archive_index.mtml

## addons/Commercial.pack/templates/search_top.mtml

## addons/Commercial.pack/templates/commenter_notify.mtml

## addons/Commercial.pack/templates/header.mtml

## addons/Commercial.pack/templates/notify-entry.mtml

## addons/Commercial.pack/templates/powered_by_footer.mtml

## addons/Commercial.pack/templates/tags.mtml

## addons/Commercial.pack/templates/rss.mtml

## addons/Commercial.pack/templates/main_index.mtml

## addons/Commercial.pack/templates/entry_listing.mtml

## addons/Commercial.pack/templates/commenter_confirm.mtml

## addons/Commercial.pack/templates/entry_summary.mtml

## addons/Commercial.pack/templates/recover-password.mtml

## addons/Commercial.pack/templates/page.mtml

## addons/Commercial.pack/templates/verify-subscribe.mtml

## addons/Commercial.pack/templates/new-ping.mtml

## addons/Commercial.pack/templates/comment_form.mtml

## addons/Commercial.pack/templates/contact.mtml

## addons/Commercial.pack/templates/footer_links.mtml
	'Links' => 'リンク', # Translate - New

## addons/Commercial.pack/templates/comment_preview.mtml

## addons/Commercial.pack/templates/search_results.mtml

## addons/Commercial.pack/templates/javascript.mtml

## addons/Commercial.pack/templates/dynamic_error.mtml

## addons/Commercial.pack/templates/comment_detail.mtml
	'[_1] [_2] on' => '[_1] [_2]: ',
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="コメントのURL">[_2]</a>',
);

1;

