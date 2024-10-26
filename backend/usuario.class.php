<?php

final class Usuario{

    private $conectar;
    public function __construct( $conectar ) {
        $this->conectar = $conectar;
    }

    public function getUsuarios(){

        $sql = "SELECT * FROM db_users.vstUsuarios;";
        return $this->conectar->queryLst($sql);
    }

    public function getPerfiles(){
        $sql = "SELECT * FROM db_users.perfiles;";
        return $this->conectar->queryLst($sql);
    }
}

?>