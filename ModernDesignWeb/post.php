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
			<h1 class="title"></h1>
	<?php
        $odesilatel= $_POST["odesilatel"];
        $zprava= $_POST["zprava"];
        $adresa= $_POST["adresa"];
        
        

                if($odesilatel == "" || $zprava == "" || $adresa == "")
                        echo("<br>Nezadali jste své údaje správně!!!<br>");
                else
                    {
                        mail("chacke.headshot@gmail.com", "Vzkaz z webu od: ".$odesilatel,"<br>E-mail odesílatele: ".$adresa,"<br>Text zprávy: ".$zprava);
                        echo("<br>Váš E-mail byl úspěšně odeslán!!!<br>");
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


