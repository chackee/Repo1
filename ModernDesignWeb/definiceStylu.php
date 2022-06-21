<?php
  $styleSheets = array(); 

// Nadefinování stylů

$styleSheets[0]["styl"]='<link rel="stylesheet" type="text/css" href="styl.css" />';

$styleSheets[1]["styl"]='<link rel="stylesheet" type="text/css" href="styl2.css" />';

// defaultní styl
$defaultStyleSheet=0;

// Nastavení relace a stylu
if(!isset($_COOKIE["STYLE"]))
{
        if(isset($_SESSION["STYLE"]))
            {
                echo $styleSheets[$_SESSION["STYLE"]]["styl"];
            } 
        else 
            {
                echo $styleSheets[$defaultStyleSheet]["styl"];
            }
} 
else 
{
    echo $styleSheets[$_COOKIE["STYLE"]]["styl"];
}
?>
<?php
?>
