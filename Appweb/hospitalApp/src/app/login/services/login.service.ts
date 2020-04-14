import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { Usuario } from "../models/usuario_model";
import { environment } from "src/environments/environment";

@Injectable({
  providedIn: "root"
})
export class LoginService {
  constructor(public http: HttpClient) {}
  auth(usuario: Usuario) {
    return this.http.post(`${environment.apiUrl}/usuarios/login/administradores`, usuario);
  }
}
