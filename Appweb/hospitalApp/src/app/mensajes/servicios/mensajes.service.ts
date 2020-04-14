import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { environment } from "src/environments/environment";
import { MensajesPersonalizados } from "../models/mensajesp_models";

@Injectable({
  providedIn: "root",
})
export class MensajesService {
  constructor(public http: HttpClient) {}
  getMensajes() {
    return this.http.get<MensajesPersonalizados[]>(
      `${environment.apiUrl}/mensajes/get`
    );
  }
  addMensajes(mensaje: MensajesPersonalizados) {
    return this.http.post(`${environment.apiUrl}/mensajes/new/`, mensaje);
  }
  deleteMensajes(id: string) {
    return this.http.delete(`${environment.apiUrl}/mensajes/delete/${id}`);
  }
  updateMensajes(mensaje:MensajesPersonalizados) {
    return this.http.put(`${environment.apiUrl}/mensajes/update`,mensaje);
  }
}
