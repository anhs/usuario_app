<?php

    error_reporting(E_ALL);
    ini_set('display_errors', '1');
   
    require_once $_SERVER['DOCUMENT_ROOT'].'/conexiones_bd/index.php';
    
    $conectar =  new Conectar();
    print_r($conectar->queryLst("SELECT * FROM db_users.perfiles;")); exit();

?>