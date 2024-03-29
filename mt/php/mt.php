<?php
# Movable Type (r) (C) 2004-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: mt.php.pre 1234 2008-01-15 09:41:35Z takayama $

define('VERSION', '4.13');
define('VERSION_ID', '4.13');
define('PRODUCT_VERSION', '4.13');
define('PRODUCT_NAME', 'Movable Type');

global $Lexicon;
$Lexicon = array();

class MT {
    var $mime_types = array(
        '__default__' => 'text/html',
        'css' => 'text/css',
        'txt' => 'text/plain',
        'rdf' => 'text/xml',
        'rss' => 'text/xml',
        'xml' => 'text/xml',
    );
    var $blog_id;
    var $db;
    var $config;
    var $debugging = false;
    var $caching = false;
    var $conditional = false;
    var $log = array();
    var $id;
    var $request;
    var $http_error;
    var $cfg_file;

    /***
     * Constructor for MT class. Also declares a global variable
     * '$mt' and assigns itself to that. There can only be one
     * instance of this class.
     */
    function MT($blog_id = null, $cfg_file = null) {
        error_reporting(E_ALL ^ E_NOTICE);
        global $mt;
        if (isset($mt)) {
            die("Only one instance of the MT class can be created.");
        }
        $this->id = md5(uniqid('MT',true));
        $this->init($blog_id, $cfg_file);
    }

    function init($blog_id = null, $cfg_file = null) {
        if (isset($blog_id)) {
            $this->blog_id = $blog_id;
        }

        if (!file_exists($cfg_file)) {
            $mtdir = dirname(dirname(__FILE__));
            $cfg_file = $mtdir . DIRECTORY_SEPARATOR . "mt-config.cgi";
        }

        $this->configure($cfg_file);
        $this->init_addons();
        $this->configure_from_db();

        $lang = substr(strtolower($this->config('DefaultLanguage')), 0, 2);
        if (!@include_once("l10n_$lang.php"))
            include_once("l10n_en.php");

        if (extension_loaded('mbstring')) {
            $charset = $this->config('PublishCharset');
            mb_internal_encoding($charset);
            mb_http_output($charset);
        }
    }

    function init_addons() {
        $mtdir = dirname(dirname(__FILE__));
        $path = $mtdir . DIRECTORY_SEPARATOR . "addons";
        if (is_dir($path)) {
            $ctx =& $this->context();
            if ($dh = opendir($path)) {
                while (($file = readdir($dh)) !== false) {
                    if ($file == "." || $file == "..") {
                        continue;
                    }
                    $plugin_dir = $path . DIRECTORY_SEPARATOR . $file
                        . DIRECTORY_SEPARATOR . 'php';
                    if (is_dir($plugin_dir))
                        $ctx->add_plugin_dir($plugin_dir);
                }
                closedir($dh);
            }
        }
    }

    function init_plugins() {
        $plugin_paths = $this->config('PluginPath');
        $ctx =& $this->context();

        foreach ($plugin_paths as $path) {
            if ($dh = opendir($path)) {
                 while (($file = readdir($dh)) !== false) {
                     if ($file == "." || $file == "..")
                         continue;
                     $plugin_dir = $path . DIRECTORY_SEPARATOR . $file
                         . DIRECTORY_SEPARATOR . 'php';
                     if (is_dir($plugin_dir))
                         $ctx->add_plugin_dir($plugin_dir);
                 }
                 closedir($dh);
            }
        }

        $plugin_dir = $this->config('PHPDir') . DIRECTORY_SEPARATOR
            . 'plugins';
        if (is_dir($plugin_dir))
            $ctx->add_plugin_dir($plugin_dir);

        # Load any php directories found during the 'init_addons' loop
        foreach ($ctx->plugins_dir as $plugin_dir)
            if (is_dir($plugin_dir))
                $this->load_plugin($plugin_dir);
    }

    function load_plugin($plugin_dir) {
        $ctx =& $this->context();
        // global filters have to be handled differently from
        // tag attributes, so this causes them to be recognized
        // as they should...
        if ($dh = opendir($plugin_dir)) {
            while (($file = readdir($dh)) !== false) {
                if (preg_match('/^modifier\.(.+?)\.php$/', $file, $matches)) {
                    $ctx->add_global_filter($matches[1]);
                } elseif (preg_match('/^init\.(.+?)\.php$/', $file, $matches)) {
                    // load 'init' plugin file
                    require_once($file);
                }
            }
            closedir($dh);
        }
    }

    /***
     * Retreives a handle to the database and assigns it to
     * the member variable 'db'.
     */
    function &db() {
        if (isset($this->db)) return $this->db;

        require_once("mtdb_".$this->config('DBDriver').".php");
        $mtdbclass = 'MTDatabase_'.$this->config('DBDriver');
        $this->db = new $mtdbclass($this->config('DBUser'),
            $this->config('DBPassword'), $this->config('Database'),
            $this->config('DBHost'), $this->config('DBPort'), $this->config('DBSocket'));
        return $this->db;
    }

    function config($id, $value = null) {
        $id = strtolower($id);
        if (isset($value))
            $this->config[$id] = $value;
        return $this->config[$id];
    }

    /***
     * Loads configuration data from mt.cfg and mt-db-pass.cgi files.
     * Stores content in the 'config' member variable.
     */
    function configure($file = null) {
        if (isset($this->config)) return $config;

        $this->cfg_file = $file;

        $cfg = array();
        $type_array = array('pluginpath', 'alttemplate', 'outboundtrackbackdomains', 'memcachedservers');
        if ($fp = file($file)) {
            foreach ($fp as $line) {
                // search through the file
                if (!ereg('^\s*\#',$line)) {
                    // ignore lines starting with the hash symbol
                    if (preg_match('/^\s*(\S+)\s+(.*)$/', $line, $regs)) {
                        $key = strtolower(trim($regs[1]));
                        $value = trim($regs[2]);
                        if (in_array($key, $type_array)) {
                            $cfg[$key][] = $value;
                        } else {
                            $cfg[$key] = $value;
                        }
                    }
                }
            }
        } else {
            die("Unable to open configuration file $file");
        }

        // setup directory locations
        // location of mt.php
        $cfg['phpdir'] = realpath(dirname(__FILE__));
        // path to MT directory
        $cfg['mtdir'] = realpath(dirname($file));
        // path to handlers
        $cfg['phplibdir'] = $cfg['phpdir'] . DIRECTORY_SEPARATOR . 'lib';

        $cfg['dbhost'] or $cfg['dbhost'] = 'localhost'; // default to localhost
        $driver = $cfg['objectdriver'];
        $driver = preg_replace('/^DB[ID]::/', '', $driver);
        $driver or $driver = 'mysql';
        $cfg['dbdriver'] = strtolower($driver);
    
        if ((strlen($cfg['database'])<1 || strlen($cfg['dbuser'])<1)) {
            if (($cfg['dbdriver'] != 'sqlite') && ($cfg['dbdriver'] != 'mssqlserver')) {
                die("Unable to read database or username");
            }
        }

        $this->config =& $cfg;
        $this->config_defaults();

        // read in the database password
        if (!isset($cfg['dbpassword'])) {
            $db_pass_file = $cfg['mtdir'] . DIRECTORY_SEPARATOR . 'mt-db-pass.cgi';
            if (file_exists($db_pass_file)) {
                $password = implode('', file($db_pass_file));
                $password = trim($password, "\n\r\0");
                $cfg['dbpassword'] = $password;
            }
        }

        // set up include path
        // add MT-PHP 'plugins' and 'lib' directories to the front
        // of the existing PHP include path:
        if (strtoupper(substr(PHP_OS, 0,3) == 'WIN')) {
            $path_sep = ';';
        } else {
            $path_sep = ':';
        }
        ini_set('include_path',
            $cfg['phpdir'] . DIRECTORY_SEPARATOR . "lib" . $path_sep .
            $cfg['phpdir'] . DIRECTORY_SEPARATOR . "extlib" . $path_sep .
            $cfg['phpdir'] . DIRECTORY_SEPARATOR . "extlib" . DIRECTORY_SEPARATOR . "smarty" . DIRECTORY_SEPARATOR . "libs" . $path_sep .
            ini_get('include_path')
        );
    }

    function configure_from_db() {
        $cfg =& $this->config;
        $mtdb =& $this->db();
        $db_config = $mtdb->fetch_config();
        if ($db_config) {
            $data = $db_config['config_data'];
            $data = preg_split('/[\r?\n]/', $data);
            foreach ($data as $line) {
                // search through the file
                if (!ereg('^\s*\#',$line)) {
                    // ignore lines starting with the hash symbol
                    if (preg_match('/^\s*(\S+)\s+(.*)$/', $line, $regs)) {
                        $key = strtolower(trim($regs[1]));
                        $value = trim($regs[2]);
                        if (($key == 'PluginSwitch') || ($key == 'PluginSchemaVersion')) { # special case for hash
                            if (preg_match('/^(.+)=(.+)$/', $value, $match))
                                $cfg[$key][trim($match[1])] = trim($match[2]);
                        } else {
                            $cfg[$key] or $cfg[$key] = $value;
                        }
                    }
                }
            }
            if ($cfg['dbdriver'] == 'mysql' or $cfg['dbdriver'] == 'postgres') {
                if ($cfg['sqlsetnames']) {
                    $Charset = array( 
                        'postgres' => array('utf-8' => 'UNICODE', 'shift_jis' => 'SJIS', 'euc-jp' => 'EUC_JP'),
                        'mysql' => array('utf-8' => 'utf8', 'shift_jis' => 'sjis', 'euc-jp' => 'ujis'));
                    $lang = $Charset[$cfg['dbdriver']][strtolower($cfg['publishcharset'])];
                    if ($lang) {
                        $mtdb->query("SET NAMES '$lang'");
                    }
                }
            }           
        }
    }

    function config_defaults() {
        $cfg =& $this->config;
        // assign defaults:
        if (substr($cfg['cgipath'], strlen($cfg['cgipath']) - 1, 1) != '/')
            $cfg['cgipath'] .= '/'; 
        isset($cfg['staticwebpath']) or
            $cfg['staticwebpath'] = $cfg['cgipath'] . 'mt-static/';
        isset($cfg['publishcharset']) or
            $cfg['publishcharset'] = 'UTF-8';
        isset($cfg['trackbackscript']) or
            $cfg['trackbackscript'] = 'mt-tb.cgi';
        isset($cfg['adminscript']) or
            $cfg['adminscript'] = 'mt.cgi';
        isset($cfg['commentscript']) or
            $cfg['commentscript'] = 'mt-comments.cgi';
        isset($cfg['atomscript']) or
            $cfg['atomscript'] = 'mt-atom.cgi';
        isset($cfg['xmlrpcscript']) or
            $cfg['xmlrpcscript'] = 'mt-xmlrpc.cgi';
        isset($cfg['searchscript']) or
            $cfg['searchscript'] = 'mt-search.cgi';
        isset($cfg['defaultlanguage']) or
            $cfg['defaultlanguage'] = 'ja';
        isset($cfg['globalsanitizespec']) or
            $cfg['globalsanitizespec'] = 'a href,b,i,br/,p,strong,em,ul,ol,li,blockquote,pre';
        isset($cfg['signonurl']) or
            $cfg['signonurl'] = 'https://www.typekey.com/t/typekey/login?';
        isset($cfg['signoffurl']) or
            $cfg['signoffurl'] = 'https://www.typekey.com/t/typekey/logout?';
        isset($cfg['identityurl']) or
            $cfg['identityurl'] = 'http://profile.typekey.com/';
        isset($cfg['publishcommentericon']) or
            $cfg['publishcommentericon'] = '1';
        isset($cfg['allowcomments']) or
            $cfg['allowcomments'] = '1';
        isset($cfg['allowpings']) or
            $cfg['allowpings'] = '1';
        isset($cfg['indexbasename']) or
            $cfg['indexbasename'] = 'index';
        isset($cfg['typekeyversion']) or
            $cfg['typekeyversion'] = '1.1';
        isset($cfg['assetcachedir']) or
            $cfg['assetcachedir'] = 'assets_c';
        isset($cfg['userpicthumbnailsize']) or
            $cfg['userpicthumbnailsize'] = '100';
        isset($cfg['pluginpath']) or
            $cfg['pluginpath'] = array($this->config('MTDir') . DIRECTORY_SEPARATOR . 'plugins');
    }

    function configure_paths($blog_site_path) {
        if (preg_match('/^\./', $blog_site_path)) {
            // relative address, so tack on the MT dir in front
            $blog_site_path = $this->config('MTDir') .
                DIRECTORY_SEPARATOR . $blog_site_path;
        }
        $this->config('PHPTemplateDir') or
            $this->config('PHPTemplateDir', $blog_site_path .
            DIRECTORY_SEPARATOR . 'templates');
        $this->config('PHPCacheDir') or
            $this->config('PHPCacheDir', $blog_site_path .
            DIRECTORY_SEPARATOR . 'cache');

        $ctx =& $this->context();
        $ctx->template_dir = $this->config('PHPTemplateDir');
        $ctx->compile_dir = $ctx->template_dir . '_c';
        $ctx->cache_dir = $this->config('PHPCacheDir');
    }

    /***
     * Mainline handler function.
     */
    function view($blog_id = null) {
        if ($this->debugging) {
            require_once("MTUtil.php");
        }
        $blog_id or $blog_id = $this->blog_id;

        $ctx =& $this->context();
        $this->init_plugins();
        $ctx->caching = $this->caching;

        // Some defaults...
        $mtdb =& $this->db();
        $ctx->mt->db =& $mtdb;

        // Set up our customer error handler
        set_error_handler(array(&$this, 'error_handler'));

        // User-specified request through request variable
        $path = $this->request;

        // Apache request
        if (!$path && $_SERVER['REQUEST_URI']) {
            $path = $_SERVER['REQUEST_URI'];
            // strip off any query string...
            $path = preg_replace('/\?.*/', '', $path);
            // strip any duplicated slashes...
            $path = preg_replace('!/+!', '/', $path);
        }

        // IIS request by error document...
        if (preg_match('/IIS/', $_SERVER['SERVER_SOFTWARE'])) {
            // assume 404 handler
            if (preg_match('/^\d+;(.*)$/', $_SERVER['QUERY_STRING'], $matches)) {
                $path = $matches[1];
                $path = preg_replace('!^http://[^/]+!', '', $path);
                if (preg_match('/\?(.+)?/', $path, $matches)) {
                    $_SERVER['QUERY_STRING'] = $matches[1];
                    $path = preg_replace('/\?.*$/', '', $path);
                }
            }
        }

        // now set the path so it may be queried
        $this->request = $path;

        // When we are invoked as an ErrorDocument, the parameters are
        // in the environment variables REDIRECT_*
        if (isset($_SERVER['REDIRECT_QUERY_STRING'])) {
            // todo: populate $_GET and QUERY_STRING with REDIRECT_QUERY_STRING
            $_SERVER['QUERY_STRING'] = getenv('REDIRECT_QUERY_STRING');
        }

        if (preg_match('/\.(\w+)$/', $path, $matches)) {
            $req_ext = strtolower($matches[1]);
        }

        $this->blog_id = $blog_id;

        $data =& $this->resolve_url($path);
        if (!$data) {
            // 404!
            $this->http_error = 404;
            header("HTTP/1.1 404 Not found");
            return $ctx->error("Page not found - $path", E_USER_ERROR);
        }

        $info =& $data['fileinfo'];
        $fi_path = $info['fileinfo_url'];
        $fid = $info['fileinfo_id'];
        $at = $info['fileinfo_archive_type'];
        $ts = $info['fileinfo_startdate'];
        $tpl_id = $info['fileinfo_template_id'];
        $cat = $info['fileinfo_category_id'];
        $auth = $info['fileinfo_author_id'];
        $entry_id = $info['fileinfo_entry_id'];
        $blog_id = $info['fileinfo_blog_id'];
        $blog =& $data['blog'];
        if ($at == 'index') {
            $at = null;
            $ctx->stash('index_archive', true);
        } else {
            $ctx->stash('index_archive', false);
        }
        $tts = $data['template']['template_modified_on'];
        if ($tts) {
            $tts = offset_time(datetime_to_timestamp($tts), $blog);
        }
        $ctx->stash('template_timestamp', $tts);
        $ctx->stash('template_created_on', $data['template']['template_created_on']);

        $columns_map = array(
            'layout-wt'  => 2,
            'layout-tw'  => 2,
            'layout-wm'  => 2,
            'layout-mw'  => 2,
            'layout-wtt' => 3,
            'layout-twt' => 3);
        $page_layout = $data['blog']['blog_page_layout'];
        $columns = 0;
        if(array_key_exists($page_layout, $columns_map))
             $columns = $columns_map[$page_layout];
        $vars =& $ctx->__stash['vars'];
        $vars['page_columns'] = $columns;
        $vars['page_layout'] = $page_layout;

        $this->configure_paths($blog['blog_site_path']);

        // start populating our stash
        $ctx->stash('blog_id', $blog_id);
        $ctx->stash('blog', $blog);
        $ctx->stash('build_template_id', $tpl_id);

        // conditional get support...
        if ($this->caching) {
            $this->cache_modified_check = true;
        }
        if ($this->conditional) {
            $last_ts = $blog['blog_children_modified_on'];
            $last_modified = $ctx->_hdlr_date(array('ts' => $last_ts, 'format' => '%a, %d %b %Y %H:%M:%S GMT', 'language' => 'en', 'utc' => 1), $ctx);
            $this->doConditionalGet($last_modified);
        }

        $cache_id = $blog_id.';'.$fi_path;
        if (!$ctx->is_cached('mt:'.$tpl_id, $cache_id)) {
            if (isset($at) && ($at != 'Category')) {
                global $_archivers;
                require_once("archive_lib.php");
                global $_archivers;
                if (!isset($_archivers[$at])) {
                    // 404
                    $this->http_errr = 404;
                    header("HTTP/1.1 404 Not Found");
                    return $ctx->error("Page not found - $at", E_USER_ERROR);
                }
                $archiver = $_archivers[$at];
                $archiver->template_params($ctx);
            }

            if ($cat) {
                $archive_category = $mtdb->fetch_category($cat);
                $ctx->stash('category', $archive_category);
                $ctx->stash('archive_category', $archive_category);
            }
            if ($auth) {
                $archive_author = $mtdb->fetch_author($auth);
                $ctx->stash('author', $archive_author);
                $ctx->stash('archive_author', $archive_author);
            }
            if (isset($at)) {
                if (($at != 'Category') && isset($ts)) {
                    list($ts_start, $ts_end) = $archiver->get_range($ctx, $ts);
                    $ctx->stash('current_timestamp', $ts_start);
                    $ctx->stash('current_timestamp_end', $ts_end);
                }
                $ctx->stash('current_archive_type', $at);
            }
    
            if (isset($entry_id) && ($entry_id) && ($at == 'Individual' || $at == 'Page')) {
                if ($at == 'Individual') {
                    $entry =& $mtdb->fetch_entry($entry_id);
                } elseif($at == 'Page') {
                    $entry =& $mtdb->fetch_page($entry_id);
                }
                $ctx->stash('entry', $entry);
                $ctx->stash('current_timestamp', $entry['entry_authored_on']);
            }

            if ($at == 'Category') {
                $vars =& $ctx->__stash['vars'];
                $vars['archive_class'] = "category-archive";
                $vars['category_archive'] = 1;
                $vars['main_template'] = 1;
                $vars['archive_template'] = 1;
                $vars['module_category-monthly_archives'] = 1;
            }
        }

        $output = $ctx->fetch('mt:'.$tpl_id, $cache_id);

        $this->http_error = 200;
        header("HTTP/1.1 200 OK");
        // content-type header-- need to supplement with charset
        $content_type = $ctx->stash('content_type');

        if (!isset($content_type)) {
            $content_type = $this->mime_types['__default__'];
            if ($req_ext && (isset($this->mime_types[$req_ext]))) {
                $content_type = $this->mime_types[$req_ext];
            }
        }
        $charset = $this->config('PublishCharset');
        if (isset($charset)) {
            if (!preg_match('/charset=/', $content_type))
                $content_type .= '; charset=' . $charset;
        }
        header("Content-Type: $content_type");

        // finally, issue output
        $output = preg_replace('/^\s*/', '', $output);
        echo $output;

        if ($this->debugging) {
            $this->log("Queries: ".$mtdb->num_queries);
            $this->log("Queries executed:");
            $queries = $mtdb->savedqueries;
            foreach ($queries as $q) {
                $this->log($q);
            }
            $this->log_dump();
        }
        restore_error_handler();
    }

    function &resolve_url($path) {
        $data =& $this->db->resolve_url($path, $this->blog_id);
        if ( isset($data)
            && isset($data['fileinfo']['fileinfo_entry_id'])
            && is_numeric($data['fileinfo']['fileinfo_entry_id'])
        ) {
            if (strtolower($data['templatemap']['templatemap_archive_type']) == 'page') {
                $entry = $this->db->fetch_page($data['fileinfo']['fileinfo_entry_id']);
            } else {
                $entry = $this->db->fetch_entry($data['fileinfo']['fileinfo_entry_id']);
            }
            require_once('function.mtentrystatus.php');
            if (!isset($entry) || $entry['entry_status'] != STATUS_RELEASE)
                return;
        }
        return $data;
    }

    function doConditionalGet($last_modified) {
        // Thanks to Simon Willison...
        //   http://simon.incutio.com/archive/2003/04/23/conditionalGet
        // A PHP implementation of conditional get, see 
        //   http://fishbowl.pastiche.org/archives/001132.html
        $etag = '"'.md5($last_modified).'"';
        // Send the headers
        header("Last-Modified: $last_modified");
        header("ETag: $etag");
        // See if the client has provided the required headers
        $if_modified_since = isset($_SERVER['HTTP_IF_MODIFIED_SINCE']) ?
            stripslashes($_SERVER['HTTP_IF_MODIFIED_SINCE']) :
            false;
        $if_none_match = isset($_SERVER['HTTP_IF_NONE_MATCH']) ?
            stripslashes($_SERVER['HTTP_IF_NONE_MATCH']) : 
            false;
        if (!$if_modified_since && !$if_none_match) {
            return;
        }
        // At least one of the headers is there - check them
        if ($if_none_match && $if_none_match != $etag) {
            return; // etag is there but doesn't match
        }
        if ($if_modified_since && $if_modified_since != $last_modified) {
            return; // if-modified-since is there but doesn't match
        }
        // Nothing has changed since their last request - serve a 304 and exit
        header('HTTP/1.1 304 Not Modified');
        exit;
    }

    function display($tpl, $cid = null) {
        $ctx =& $this->context();
        $this->init_plugins();
        $blog =& $ctx->stash('blog');
        if (!$blog) {
            $db =& $this->db();
            $ctx->mt->db =& $db;
            $blog =& $db->fetch_blog($this->blog_id);
            $ctx->stash('blog', $blog);
            $ctx->stash('blog_id', $this->blog_id);
            $this->configure_paths($blog['blog_site_path']);
        }
        return $ctx->display($tpl, $cid);
    }

    function fetch($tpl, $cid = null) {
        $ctx =& $this->context();
        $this->init_plugins();
        $blog =& $ctx->stash('blog');
        if (!$blog) {
            $db =& $this->db();
            $ctx->mt->db =& $db;
            $blog =& $db->fetch_blog($this->blog_id);
            $ctx->stash('blog', $blog);
            $ctx->stash('blog_id', $this->blog_id);
            $this->configure_paths($blog['blog_site_path']);
        }
        return $ctx->fetch($tpl, $cid);
    }

    function log_dump() {
        if ($_SERVER['REMOTE_ADDR']) {
            // web view...
            echo "<div class=\"debug\" style=\"border:1px solid red; margin:0.5em; padding: 0 1em; text-align:left; background-color:#ddd; color:#000\"><pre>";
            echo implode("\n", $this->log);
            echo "</pre></div>\n\n";
        } else {
            // console view...
            $stderr = fopen('php://stderr', 'w'); 
            fwrite($stderr,implode("\n", $this->log)); 
            echo (implode("\n", $this->log)); 
            fclose($stderr);
        }
    }

    function error_handler($errno, $errstr, $errfile, $errline) {
        if ($errno & (E_ALL ^ E_NOTICE)) {
            $errstr = htmlentities($errstr);
            $errfile = htmlentities($errfile);
            $mtphpdir = $this->config('PHPDir');
            $ctx =& $this->context();
            $ctx->stash('blog_id', $this->blog_id);
            $ctx->stash('blog', $this->db->fetch_blog($this->blog_id));
            $ctx->stash('error_message', $errstr."<!-- file: $errfile; line: $errline; code: $errno -->");
            $ctx->stash('error_code', $errno);
            $http_error = $this->http_error;
            if (!$http_error) {
                $http_error = 500;
            }
            $ctx->stash('http_error', $http_error);
            $ctx->stash('error_file', $errfile);
            $ctx->stash('error_line', $errline);
            $ctx->template_dir = $mtphpdir . DIRECTORY_SEPARATOR . 'tmpl';
            $ctx->caching = 0;
            $ctx->stash('StaticWebPath', $this->config('StaticWebPath'));
            $ctx->stash('PublishCharset', $this->config('PublishCharset'));
            $charset = $this->config('PublishCharset');
            $out = $ctx->tag('Include', array('type' => 'dynamic_error'));
            if (isset($out)) {
                header("Content-type: text/html; charset=".$charset);
                echo $out;
            } else {
                header("HTTP/1.1 500 Server Error");
                header("Content-type: text/plain");
                echo "Error executing error template.";
            }
            exit;
        }
    }

    /***
     * Retreives a context and rendering object.
     */
    function &context() {
        static $ctx;
        if (isset($ctx)) return $ctx;

        require_once('MTViewer.php');
        $ctx = new MTViewer($this);
        $ctx->mt =& $this;
        $mtphpdir = $this->config('PHPDir');
        $mtlibdir = $this->config('PHPLibDir');
        $ctx->compile_check = 1;
        $ctx->caching = false;
        $ctx->plugins_dir[] = $mtlibdir;
        $ctx->plugins_dir[] = $mtphpdir . DIRECTORY_SEPARATOR . "plugins";
        if ($this->debugging) {
            $ctx->debugging_ctrl = 'URL';
            $ctx->debug_tpl = $mtphpdir . DIRECTORY_SEPARATOR .
                'extlib' . DIRECTORY_SEPARATOR .
                'smarty' . DIRECTORY_SEPARATOR . "libs" . DIRECTORY_SEPARATOR .
                'debug.tpl';
        }
        #if (isset($this->config('SafeMode')) && ($this->config('SafeMode'))) {
        #    // disable PHP support
        #    $ctx->php_handling = SMARTY_PHP_REMOVE;
        #}
        return $ctx;
    }

    function log($msg = null) {
        $this->log[] = $msg;
    }

    function translate($str, $params = null) {
        return translate_phrase($str, $params);
    }

    function translate_templatized_item($str) {
        return translate_phrase($str[1]);
    }

    function translate_templatized($tmpl) {
        $cb = array($this, 'translate_templatized_item');
        $out = preg_replace_callback('/<(?:_|mt)_trans phrase="(.+?)".*?>/i', $cb, $tmpl);
        return $out;
    }
}

function is_valid_email($addr) {
    if (preg_match('/[ |\t|\r|\n]*\"?([^\"]+\"?@[^ <>\t]+\.[^ <>\t][^ <>\t]+)[ |\t|\r|\n]*/', $addr, $matches)) {
        return $matches[1];
    } else {
        return 0;
    }
}

$spam_protect_map = array(':' => '&#58;', '@' => '&#64;', '.' => '&#46;');
function spam_protect($str) {
    global $spam_protect_map;
    return strtr($str, $spam_protect_map);
}

function datetime_to_timestamp($dt) {
    $dt = preg_replace('/[^0-9]/', '', $dt);
    $ts = mktime(substr($dt, 8, 2), substr($dt, 10, 2), substr($dt, 12, 2), substr($dt, 4, 2), substr($dt, 6, 2), substr($dt, 0, 4));
    return $ts;
}

function offset_time($ts, $blog = null, $dir = null) {
    if (isset($blog)) {
        if (!is_array($blog)) {
            global $mt;
            $blog = $mt->db->fetch_blog($blog);
        }
        $offset = $blog['blog_server_offset'];
    } else {
        global $mt;
        $offset = $mt->config('TimeOffset');
    }
    intval($offset) or $offset = 0;
    $tsa = localtime($ts);

    if ($tsa[8]) {  // daylight savings offset
        $offset++;
    }
    if ($dir == '-') {
        $offset *= -1;
    }
    $ts += $offset * 3600;
    return $ts;
}
function _strip_index($url, $blog) {
    global $mt;
    $index = $mt->config('IndexBasename');
    $ext = $blog['blog_file_extension'];
    if ($ext != '') $ext = '.' . $ext;
    $index = preg_quote($index . $ext);
    $url = preg_replace("/\/$index(#.*)?$/", '/$1', $url);
    return $url;
}

function translate_phrase_param($str, $params = null) {
    if (is_array($params) && (strpos($str, '[_') !== false)) {
        for ($i = 1; $i <= count($params); $i++) {
            $str = preg_replace("/\\[_$i\\]/", $params[$i-1], $str);
        }
    }
    return $str;
}
?>
