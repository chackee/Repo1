<?php
session_start();
if (empty($_SESSION['id_uzivatele']))
        die('Máte nedostatečná oprávnění');

require('pripojeniDB.php');
Db::connect('localhost', 'Weby', 'kralp', '1aa23456');

$clanek = array(
        'clanky_id' => '',
        'titulek' => '',
        'obsah' => '',
);
if ($_POST)
{
        if (!$_POST['clanky_id'])
        {
                Db::query('
                        INSERT INTO clanky (titulek, obsah)
                        VALUES (?, ?)
                ', $_POST['nadpis'], $_POST['obsah']);
        }
        else
        {
                Db::query('
                        UPDATE clanky
                        SET titulek=?, obsah=?
                        WHERE clanky_id=?
                ', $_POST['nadpis'], $_POST['obsah'], $_POST['clanky_id']);
        }
        
}
else if (isset($_GET['url']))
{
        $nactenyClanek = Db::queryOne('
                SELECT *
                FROM clanky
                WHERE clanky_id =?
        ', $_GET['url']);
        if ($nactenyClanek)
                $clanek = $nactenyClanek;
        
}

?>

<html>
<head>
<meta http-equiv="content-language" content="cs"/>
<meta charset="utf-8"/>
<?php include_once('definiceStylu.php'); ?>
<title>Editor</title>
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
			<h1 class="title">Editor</h1>
			
                            
          
        <form style="text-align:center" method="post">
         <input type="hidden" name="clanky_id" value="<?= htmlspecialchars($clanek['clanky_id']) ?>" /><br />
                       Titulek<br />
                       <input type="text" name="nadpis" value="<?= htmlspecialchars($clanek['titulek']) ?>" /><br /><br /><br />
                       <textarea name="obsah"><?= htmlspecialchars($clanek['obsah']) ?></textarea>
                       <input type="submit" value="Odeslat" />
        </form>
                        
		</div>
	</div>
	<div id="bar">&nbsp;</div>
</div>
<div id="copy">
	<p id="legacy">Copyright &copy; Pavel Král 6.2.2016</p>
        <p id="links"><h3><a href='prepinacStylu.php?SETSTYLE=0' title='vyber styl 1' >Styl 1</a></h3> ..... <h3><a href='prepinacStylu.php?SETSTYLE=1' title='vyber styl 2' >Styl 2</a></h3></p>
</div>
  
  <script type="text/javascript" src="//tinymce.cachefly.net/4.0/tinymce.min.js"></script>
        <script type="text/javascript">
                tinymce.init({
                        selector: "textarea[name=obsah]",
                        plugins: [
                                "advlist autolink lists link image charmap print preview anchor",
                                "searchreplace visualblocks code fullscreen",
                                "insertdatetime media table contextmenu paste"
                        ],
                        toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
                        entities: "160,nbsp",
                        entity_encoding: "named",
                        entity_encoding: "raw"
                });
        </script>

  </body>
</html>