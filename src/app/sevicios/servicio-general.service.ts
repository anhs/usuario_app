import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ServicioGeneralService {

  constructor(private http: HttpClient) { }

  query( peticion:Peticion): Observable<any> {

    if(peticion.tipo =="get"){
      return this.http.get(peticion.url);
    }else(peticion.tipo == "post"){
      return this.http.post(
        peticion.url,
        peticion.body
      )
    }
  }
}


export interface Peticion {
    url:string,
    tipo:string,
    body:any | null
}