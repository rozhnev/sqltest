<?php
header('Content-Type: application/xml');

$host  = $_SERVER['HTTP_HOST'];
$today = date('Y-m-d');

require 'vendor/autoload.php';
$smarty = new Smarty;

$sqlog = new SQLog($site == 'PHPIZE' ? 'php':'sql');

$sitemap = [
   [
      'loc' => 'https://sqltest.online/',
      'lastmod' => $today,
      'changefreq' => 'monthly',
      'priority' => '0.8',
   ],
   [
      'loc' => 'https://sqltest.online/about.php',
      'lastmod' => $today,
      'changefreq' => 'monthly',
      'priority' => '0.3',
   ],
   [
      'loc' => 'https://sqltest.online/disclaimer.php',
      'lastmod' => $today,
      'changefreq' => 'monthly',
      'priority' => '0.3',
   ]
];

$smarty->assign("SITEMAP", $sitemap);
$smarty->display('sitemap.tpl');
?>