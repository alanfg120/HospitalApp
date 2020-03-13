import { createAction, props } from "@ngrx/store";
import { Turno } from '../models/turnos_model';
import { Mensaje } from '../models/mensaje_model';
import { Cita } from '../models/cita_model';

export const loadTurno = createAction(
  "[Turno Componet] LoadTurno",
  props<{ turno: Turno }>()
);
export const loadDoctores = createAction(
  "[Turno Componet] LoadDoctores",
  props<{ doctotes: string[] }>()
);

export const requestMensaje = createAction(
  "[Turno Componet] RequestMensaje",
  props<{ mensaje: Mensaje }>()
);
export const sendMensaje = createAction(
  "[Turno Componet] SendMensaje",
  props<{ mensaje: Mensaje,topic:string }>()
);
export const sendCita = createAction(
  "[Turno Componet] SendCita",
  props<{ cita: Cita }>()
);


