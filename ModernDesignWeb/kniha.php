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
			</ul>
		</div>
		
		
		
	</div>
	<div id="content">
		<div><img src="images/banner.png" alt="banner" width="450" height="200" /></div>
		<div class="boxed">
			<h1 class="title">Návštěvní kniha</h1>
			<p><h4><center>Napište nám váš názor<center></h4></p>
			
                 <form action="kniha.php" method="POST">
                        <center><p>Předmět:</p><input type="text" name="Predmet"></center><br> 
			<center><p>Jméno:</p><input type="text" name="Jmeno"></center><br> 
			<center><p>Váš text:</p><textarea name="Zprava" cols="40" rows="10"></textarea></center>
			<center><input type="submit" name="odeslat" value="Odeslat"></center>
                 </form>
                 
    <?php 
      if(isset($_POST['odeslat']))
    {
        Db::query
        ("
        INSERT INTO kniha(`Jmeno`,`Predmet`,`Zprava`)
        VALUES('".$_POST['Jmeno']."','".$_POST['Predmet']."','".$_POST['Zprava']."')
        ");
    }
    ?>
                                    
    <?php
            
           $vypis = Db::queryAll("SELECT * FROM kniha");

           foreach ($vypis AS $promenna)
		{
?>
	<p><i><b>Předmět: </b></i><br>
		<?php echo($promenna["Predmet"]); ?>
		<br><b><i>Autor: </i></b><br>
		<?php echo($promenna["Jmeno"]);?>
	</p> 
	<p>
                <b><i>Text: </i></b><br>
		<?php echo($promenna["Zprava"]); ?>
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
	<p id="links"><a href='prepinacStylu.php?SETSTYLE=0' title='vyber styl 1' >Styl 1</a> ..... <a href='prepinacStylu.php?SETSTYLE=1' title='vyber styl 2' >Styl 2</a></p>
</div>
</body>
</html>
