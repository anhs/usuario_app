import { Component, OnInit } from '@angular/core';
import { ServicioGeneralService } from 'src/app/sevicios/servicio-general.service';

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})
export class InicioComponent implements OnInit {

  constructor(
    public request : ServicioGeneralService,
  ){

  }
  ngOnInit(): void {
    this.request.permisos = Object.keys(JSON.parse(sessionStorage.getItem('permisos') ?? ""));
  }

  salir(){
    sessionStorage.clear()
  }
}

