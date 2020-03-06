import { createAction, props } from "@ngrx/store";
import { Turno } from '../models/turnos_model';
import { Mensaje } from '../models/mensaje_model';

export const loadTurno = createAction(
  "[Turno Componet] LoadTurno",
  props<{ turno: Turno }>()
);

export const requestMensaje = createAction(
  "[Turno Componet] RequestMensaje",
  props<{ mensaje: Mensaje }>()
);
export const sendMensaje = createAction(
  "[Turno Componet] SendMensaje",
  props<{ mensaje: Mensaje }>()
);


