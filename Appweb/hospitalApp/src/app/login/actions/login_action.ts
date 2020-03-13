import { createAction, props } from "@ngrx/store";
import { Usuario } from '../models/usuario_model';


export const authAction = createAction(
  "[Login Componet] Auth",
  props<{ usuario: Usuario  }>()
);