import { createReducer, on } from "@ngrx/store";
import { Turno } from "../models/turnos_model";
import * as moment from "moment";
import {
  loadTurno,
  requestMensaje,
  sendMensaje
} from "../actions/turno_actions";
import { Mensaje } from "../models/mensaje_model";
import { Cita } from '../models/cita_model';

let turno = new Turno();
turno.nombre = "ALan";
turno.cedula = "123456";
turno.numero = "1";
turno.email = "alan@h.com";
turno.observaciones = "Hola Como Vas";
turno.tipocita = "Odontologia";

export interface TurnoState {
  turno: Turno;
  isloading?: boolean;
  mensajes: Mensaje[];
  cita?:Cita; 
}

export const initialState: TurnoState = {
  turno: turno,
  mensajes: []
};

const _TurnoReducer = createReducer(
  initialState,
  on(loadTurno, (state, { turno }) => {
    return { ...state, turno };
  }),
  on(requestMensaje, (state, { mensaje }) => {
    mensaje.recibido = true;
    return { ...state, mensajes: state.mensajes.concat(mensaje) };
  }),
  on(sendMensaje, (state, { mensaje }) => {
    return { ...state, mensajes: state.mensajes.concat(mensaje) };
  })
);

export function TurnoReducer(state, action) {
  return _TurnoReducer(state, action);
}
