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
			<h1 class="title">Kontakt</h1>
			<p><h3>Modern Design</h3></p>
			<p>Jabloňová 227</p>
			<p>289 12, Sadská</p>
			<p>Tel: (+420) 257 250 255</p>
			<p><h3>Pavel Král</h3></p>
			<p>E-mail: chacke.headshot@gmail.com</p>
			<p>Tel: (+420) 255 275 250</p>
                        
                        
                        <form method = "POST" action = "post.php"><br>
                            <center><p>Vaše jméno:</p><input type="text" name="odesilatel"><br></center>
                            <center><p>Váš E-mail:</p><input type="text" name="adresa"><br></center>
                            <center><p>Obsah zprávy:</p> <textarea name= "zprava" cols="40" rows="10"></textarea></center> <br>
                            <center><input type="submit" value="Odeslat"></center> 
                        </form>
			
			
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