import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class MensajesService {

  constructor(public http:HttpClient
    ) { }
    getMensajes(){
      return this.http.get<string[]>(`${environment.apiUrl}/mensajes`)
    }
   addMensajes(index){
     return this.http.delete(`${environment.apiUrl}/mensajes/delete/${index}`)
   }
}
