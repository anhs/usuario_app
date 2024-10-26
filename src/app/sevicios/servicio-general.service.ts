import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment.development';
import * as CryptoJS from 'crypto-js';

@Injectable({
  providedIn: 'root'
})

export class ServicioGeneralService {

  constructor(private http: HttpClient) { }

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


}



export interface Peticion {
    ruta?:string,
    tipo?:string,
    body:Body
}

export interface Body{
  accion:string,
  data:string
}