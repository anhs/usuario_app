import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Respuesta } from 'src/app/interfaces/respuesta_inter';
import { ServicioGeneralService } from  'src/app/sevicios/servicio-general.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  username: string = '';
  password: string = '';

  constructor(
    private request : ServicioGeneralService,
    private router: Router
  ){

  }

  ngOnInit() {

  }

  onSubmit() {
    this.request.query({
      body:{
        accion: 'login',
        data: {"usuario" : this.username,"contrasena" : this.request.encriptarContraseña(this.password)}
      }
    }).subscribe((res:Respuesta) => {
        this.request.mensajeServidor(res.respuesta,res.mensaje,"información");
        if (res.respuesta == "success"){
            this.router.navigate(['/inicio']);
            sessionStorage.setItem('token', res.token ?? "");
            sessionStorage.setItem('idSession', res.idSession ?? "");
            this.request.datosPersonales = res.datos[0]
            this.request.permisos = Object.keys(JSON.parse(this.request.datosPersonales.permisos_perfil));
            sessionStorage.setItem('permisos', this.request.datosPersonales.permisos_perfil ?? "");
            
        }
    })

  }
}
