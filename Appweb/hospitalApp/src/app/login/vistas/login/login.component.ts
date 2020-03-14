import { Component, OnInit } from "@angular/core";
import { Usuario } from "../../models/usuario_model";
import { Store } from "@ngrx/store";
import { LoginState } from "../../reducers/login_reducer";
import { authAction } from "../../actions/login_action";
import { MatSnackBar } from "@angular/material";
import { HttpErrorResponse } from "@angular/common/http";
import { duration } from "moment";

@Component({
  selector: "app-login",
  templateUrl: "./login.component.html",
  styleUrls: ["./login.component.css"]
})
export class LoginComponent implements OnInit {
  usuario = new Usuario();
  errorStatus$ = this.store.select(state => state.login.errorStatus);
  constructor(
    private store: Store<{ login: LoginState }>,
    private snack: MatSnackBar
  ) {}
  ngOnInit() {
    this.errorStatus$.subscribe((error: HttpErrorResponse) => {
      if (error) {
        if (error.status == 400) this.snackBar("Datos incorrectos");
        if (error.status == 0)
          this.snackBar("Ocurrio un error con la conexión");
      }
    });
  }
  login(form) {
    if (form.valid) {
      this.store.dispatch(authAction({ usuario: this.usuario }));
    }
  }

  snackBar(mensaje: string) {
    this.snack.open(mensaje, "Aceptar", { duration: 2000 });
  }
}
