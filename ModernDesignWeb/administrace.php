<?php
session_start();
if (!isset($_SESSION['id_uzivatele']))
{
        header('Location: index.php');
        exit();
}

if (isset($_GET['odhlasit']))
{
        session_destroy();
        header('Location: index.php');
        exit();
}
?>
<html>
  <head>
  <meta http-equiv="content-language" content="cs"/>
  <meta charset="utf-8"/>
  <?php include('definiceStylu.php'); ?>
  <title>Administrace</title>
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
				<li class="first"><a href="index.php">Úvod</a></li>
				<li><a href="onas.php">O nás</a></li>
				<li><a href="kniha.php">Návštěvní kniha</a></li>
				<li><a href="kontakt.php">Kontakt</a></li>
                                <li><h2><a href="administrace.php?odhlasit">Odhlásit</a></h2></li>
			</ul>
		</div>
  
  

   
        
          
      
   
   </div>
	<div id="content">
		<div><img src="images/banner.png" alt="banner" width="450" height="200" /></div>
		<div class="boxed">
			<h1 class="title">Administrace</h1>
                        <p></p>
			<p></p>
                        
                        
                        
                        <h2><a href="editor.php">Vytvořit novinku</a></h2>
                        <h2><a href="clanky.php">Seznam novinek</a></h2>
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
        
                        
     
      