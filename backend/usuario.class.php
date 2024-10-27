<?php

final class Usuario{

    private $conectar;
    public function __construct( $conectar ) {
        $this->conectar = $conectar;
    }

    public function getUsuarios(bool $json = true){

        $sql = "SELECT * FROM db_users.vstUsuarios;";
        return $this->conectar->queryLst($sql,$json);
    }

    public function getPerfiles(){
        $sql = "SELECT * FROM db_users.perfiles;";
        return $this->conectar->queryLst($sql);
    }

    public function registroUsuario($datos){
        
        $this->conectar->validarDatos($datos,"accion");
        $this->conectar->validarDatos($datos,"nombre", array("tipo"=> "text",'requerido' => true));
        $this->conectar->validarDatos($datos,"telefono");
        $this->conectar->validarDatos($datos,"direccion");
        $this->conectar->validarDatos($datos,"usuario",array("tipo"=> "text",'requerido' => true));
        $this->conectar->validarDatos($datos,"correo",array("tipo"=> "text",'requerido' => true));
        
        $this->conectar->validarDatos($datos,"contrasena",array("tipo"=> "text",'requerido' => true));

        $sql = "CALL db_users.prGuardarUsuario($datos->accion, $datos->nombre, $datos->telefono, $datos->direccion, $datos->usuario, $datos->correo, $datos->contrasena,1,1);";
    
        return $this->conectar->queryCRUD($sql);
    }

    public function login($datos){

        $this->conectar->validarDatos($datos,"usuario",array("tipo"=> "text",'requerido' => true));
        $this->conectar->validarDatos($datos,"contrasena",array("tipo"=> "text",'requerido' => true));
        $sql = "CALL prLogin($datos->usuario,$datos->contrasena);";

        $rs =  $this->conectar->queryCRUD($sql,false);

        if($rs['respuesta'] == "success"){
            $token = $this->conectar->generateToken();
            $sqlSession ="CALL prSession({$rs['idUsuario']}, '{$token}', 1);";
            $rs = $this->conectar->queryCRUD($sqlSession,false);
            $rs['token'] = $token;
            $rs['datos'] = $this->getUsuarios(false)['datos'];
        }
        return jsRespuesta($rs); 
    }
}

?>