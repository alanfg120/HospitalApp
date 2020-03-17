import { createAction, props } from "@ngrx/store";
import { Turno } from '../models/turnos_model';
import { Mensaje } from '../models/mensaje_model';

export const loadTurnos = createAction("[Turnos Componet] LoadingTurnos");

export const loadedTurnos = createAction(
  "[Turnos Componet] LoadedTurnos",
  props<{ turnos: Turno[] }>()
);

export const sendMensaje = createAction(
  "[Turno Componet] SendMensaje",
  props<{ mensaje: Mensaje,topic:string,index:number}>()
);
export const requestMensaje = createAction(
  "[Turno Componet] RequestMensaje",
  props<{ mensaje: Mensaje,index:number }>()
); 