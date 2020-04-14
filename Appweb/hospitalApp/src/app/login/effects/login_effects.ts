import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of, pipe } from "rxjs";
import {
  map,
  mergeMap,
  catchError,
  switchMap,
  tap,
  exhaustMap
} from "rxjs/operators";
import {
  authAction,
  errorAction,
  successAction
} from "../actions/login_action";
import { LoginService } from "../services/login.service";
import { Usuario } from "../models/usuario_model";
import { Router } from "@angular/router";
import { logout } from "../actions/login_action";
import { MqttService } from "ngx-mqtt";

@Injectable()
export class LoginEffects {
  auth$ = createEffect(() =>
    this.actions$.pipe(
      ofType(authAction),
      exhaustMap(action =>
        this.loginService.auth(action.usuario).pipe(
          map((usuario: Usuario) => successAction({ usuario })),
          catchError(error => of(errorAction({ error })))
        )
      )
    )
  );
  success$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(successAction),
        tap(action => {
          sessionStorage.setItem("id_seccion", action.usuario.token);
          sessionStorage.setItem("id_conection", action.usuario.email);
          this.router.navigate(["Home"]);
        })
      ),
    { dispatch: false }
  );
  logout$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(logout),
        tap(() => {
          sessionStorage.removeItem("id_seccion");
          sessionStorage.removeItem("id_conection");
          this.router.navigate(["login"]);
          this._mqtt.disconnect(true)
        })
      ),
    { dispatch: false }
  );

  constructor(
    private actions$: Actions,
    private loginService: LoginService,
    private router: Router,
    private _mqtt: MqttService
  ) {}
}
