import { Component, OnInit } from '@angular/core';
import { ServicioGeneralService } from  'src/app/sevicios/servicio-general.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(
    private request : ServicioGeneralService,
  ){

  }

  ngOnInit() {
    this.request.query(
      {
        body: {
          accion: 'usuario',
          data: ''
        },
      }
    ).subscribe((_) => {
        console.log(_)
    })
  }
  username: string = '';
  password: string = '';

  onSubmit() {
    // Manejo de la lógica de inicio de sesión
    console.log('Usuario:', this.username);
    console.log('Contraseña:', this.password);
  }
}
