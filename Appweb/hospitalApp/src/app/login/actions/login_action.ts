import { createAction, props } from "@ngrx/store";
import { Usuario } from "../models/usuario_model";
import { HttpErrorResponse } from "@angular/common/http";

export const authAction = createAction(
  "[Login Componet] Auth",
  props<{ usuario: Usuario }>()
);
export const errorAction = createAction(
  "[Login Componet] Error",
  props<{ error: HttpErrorResponse }>()
);
export const successAction = createAction(
  "[Login Componet] Success",
  props<{ usuario: Usuario }>()
);
export const logout = createAction("[Login Componet] Logout");
