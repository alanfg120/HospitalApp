import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { environment } from "src/environments/environment";
import { Turno } from "../models/turnos_model";
import { Observable } from "rxjs";
import { Mensaje } from "../models/mensaje_model";

@Injectable({
  providedIn: "root"
})
export class TurnosService {
  constructor(private http: HttpClient) {}

  getTurnos(): Observable<Turno[]> {
    return this.http.get<Turno[]>(`${environment.apiUrl}/turnos`);
  }

  updateTurno(mensaje: Mensaje, cedula: string) {
    return this.http.put(`${environment.apiUrl}/turnos/update/mensaje`, {
      cedula,
      mensaje
    });
  }
}
