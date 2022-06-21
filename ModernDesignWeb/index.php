<?php
require_once("pripojeniDB.php");
Db::connect('localhost','Weby','kralp','1aa23456');
?>
<html>
<head>
<meta http-equiv="content-language" content="cs"/>
<meta charset="utf-8"/>
<?php include('definiceStylu.php'); ?>
<title>Modern Design</title>
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
                                <li><a href="administrace.php">Administrace</a></li>
			</ul>
		</div>
    
    <?php
    
    if(isset($_POST['odeslat']))
    {
        $promenna=
        Db::querySingle
        ("
        SELECT COUNT(*) FROM uzivatele
        WHERE jmeno='".$_POST['jmeno']."' AND heslo='".$_POST['heslo']."'
        ");
        
        if($promenna)
        {
            session_start();
            $_SESSION["id_uzivatele"]=$promenna; //tohle přihlašuje
        }
        
        
        
    }
    
    
    if (isset($_SESSION['id_uzivatele'])) //kontroluje jestli jsme přihlášení
    { 
        
    }  else
        {
    ?>
    <form action="index.php" method="POST">
		<h4>    Jméno:</h4>
		    <input type="text" name="jmeno">
		<h4>    Heslo:</h4>
		    <input type="password" name="heslo">
		    <center><input type="submit" value="Přihlásit" name="odeslat"></center>
    </form>
    <?php
    }
    ?>
		
		
	</div>
	<div id="content">
		<div><img src="images/banner.png" alt="banner" width="450" height="200" /></div>
		<div class="boxed">
			<h1 class="title">Aktuality a novinky</h1>
	<?php
            
           $vypis = Db::queryAll("SELECT * FROM clanky");

           foreach ($vypis AS $promenna)
		{
?>
	<p><i><b><h1><?php echo($promenna["titulek"]); ?></h1></b></i>
		
                 <?php echo($promenna["obsah"]);?>
	</p> 
	
<?php 
                }
?>
		</div>
	</div>
	<div id="bar">&nbsp;</div>
</div>
<div id="copy">
	<p id="legacy">Copyright &copy; Pavel Král 6.2.2016</p>
        <p id="links"><a href='prepinacStylu.php?SETSTYLE=0' title='vyber styl 1' >Styl 1</a>        <a href='prepinacStylu.php?SETSTYLE=1' title='vyber styl 2' >Styl 2</a></p>
        
</div>
    <?php
    ?>
</body>
</html>