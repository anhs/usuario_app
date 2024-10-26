<?php

    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Permitir el acceso desde cualquier origen
    header("Access-Control-Allow-Origin: *");

    // Especificar métodos permitidos
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");

    // Permitir encabezados específicos
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header('Content-Type: application/json');
    header('Access-Control-Allow-Origin: *');
    header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method");

   
    require_once $_SERVER['DOCUMENT_ROOT'].'/conexiones_bd/index.php';
    require_once "backend/usuario.class.php";
    $conectar = new Conectar();

    $data =  isset( $_POST['dato']) ?  json_decode($_POST['dato']) :  [];

    switch ($data->accion) {
        case 'usuario':
            $user = new Usuario($conectar);
            return $user->getPerfiles();
        
        default:
            json_encode(
                [
                    "respuesta" => "danger",
                    "mensaje"  => "Accion no definida"
                ]
            );
            break;
    }
   

?>