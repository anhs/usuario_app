import { ComponentRef, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment.development';
import * as CryptoJS from 'crypto-js';
import { ToastrService } from 'ngx-toastr';
import { Peticion } from "./../interfaces/respuesta_inter";


@Injectable({
  providedIn: 'root'
})

export class ServicioGeneralService {

  datosPersonales:any;
  permisos:Array<string|any> = [];

  constructor(private http: HttpClient,
              private toastr: ToastrService
  ) { }

  query( peticion:Peticion): Observable<any> {

    let url = environment.apiUrl + "peticiones.php";

    const formData = new FormData();
    formData.append('dato',JSON.stringify(peticion.body) )

    if(peticion.tipo =="get"){

      return this.http.get(url);
    }
 
      return this.http.post(
        url,
        formData
      );
    
  }

  encriptarContraseña(contraseña: string): string {
    const hash = CryptoJS.SHA256(contraseña);
    return hash.toString(CryptoJS.enc.Hex);  // Convertir el hash a una cadena hexadecimal
  }

  mensajeServidor(tipo: 'success' | 'error' | 'info' | 'warning', mensaje: string, titulo:string){

        this.toastr[tipo](mensaje, titulo);
    
  }

}

