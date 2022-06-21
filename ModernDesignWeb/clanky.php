<?php
session_start();

require('pripojeniDB.php');
Db::connect('localhost', 'Weby', 'kralp', '1aa23456');

if (isset($_GET['odstranit']) && !empty($_SESSION['id_uzivatele']))
{
        Db::query('
                DELETE FROM clanky
                WHERE clanky_id=?
        ', $_GET['odstranit']);
        header('Location: clanky.php');
        exit();
}

$clanky = Db::queryAll('
        SELECT *
        FROM clanky
        ORDER BY clanky_id DESC
');

?>

<html>
  <head>
  <meta http-equiv="content-language" content="cs"/>
  <meta charset="utf-8"/>
  <?php include('definiceStylu.php'); ?>
  <title>Články</title>
  </head>
  
  
  
  <body>
      
      <div id="page">
	<div id="sidebar">
		<div id="logo">
			<img src="images/logo.png" alt="logo" width="90%" height="90%" /> 
			<h1 class="logo"></h1>
		</div>
		<div id="menu">
			<ul>
				<li class="first"><a href="administrace.php?odhlasit">Odhlásit</a></li>
                                <li><a href="administrace.php">Administrace</a></li>
			</ul>
		</div>
  
  
          
      
   
       
     
      </div>
	<div id="content">
		<div><img src="images/banner.png" alt="banner" width="450" height="200" /></div>
		<div class="boxed">
			<h1 class="title">Aktuality a novinky</h1>
			<p><h1>Seznam článků</h1>
       <br />
       <p>
        <table>
                                <?php
                                        foreach ($clanky as $clanek)
                                        {
                                                echo('<tr><td><h2>
                                                                
                                                                ' . htmlspecialchars($clanek['titulek']) . '
                                                        </h2>' );
                                                        if (!empty($_SESSION['id_uzivatele']))
                                                                echo(' <a href="editor.php?url=' . htmlspecialchars($clanek['clanky_id']) . '">Editovat</a>
                                                                           <a href="clanky.php?odstranit=' . htmlspecialchars($clanek['clanky_id']) . '">Odstranit</a>
                                                                ');
                                                echo('</td></tr>');
                                        }
                                ?>
                                </table></p>
			
		</div>
	</div>
	<div id="bar">&nbsp;</div>
</div>
<div id="copy">
	<p id="legacy">Copyright &copy; Pavel Král 6.2.2016</p>
        <p id="links"><a href='prepinacStylu.php?SETSTYLE=0' title='vyber styl 1' >Styl 1</a> ..... <a href='prepinacStylu.php?SETSTYLE=1' title='vyber styl 2' >Styl 2</a></p>
</div>
  </body>
</html>