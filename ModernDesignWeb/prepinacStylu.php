<?php
  // Nastavení cookie na časový interval
if(isset($_REQUEST["SETSTYLE"])){
if(setcookie("testcookie",true)){
setcookie("STYLE",$_REQUEST["SETSTYLE"],time()+31622400,"/");
} else {
$_SESSION["STYLE"]=$_REQUEST["SETSTYLE"];
}
}

// Návrat na titulní stránku
header("Location: ".$_SERVER["HTTP_REFERER"]);
?>