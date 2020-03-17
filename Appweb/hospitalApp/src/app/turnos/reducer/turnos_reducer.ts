import { createReducer, on } from "@ngrx/store";
import { Turno } from "../models/turnos_model";
import * as moment from "moment";
import { loadTurnos, loadedTurnos, sendMensaje, requestMensaje } from '../actions/turnos_actions';

let initialturnos: Turno[] = [];

export interface TurnosState {
  turnos: Turno[];
  isloading?: boolean;
}

export const initialState: TurnosState = {
  turnos: []
};

const _TurnosReducer = createReducer(
  initialState,
  on(loadTurnos, state => {
    return { ...state, isloading: true };
  }),

  on(loadedTurnos, (state, { turnos }) => {
    initialturnos = turnos;
    return { ...state, turnos, isloading: false };
  }),
  on(sendMensaje, (state, { mensaje,index }) => {
    state.turnos[index].mensajes.push(mensaje)
    return { ...state };
  }),
  on(requestMensaje, (state, { mensaje,index }) => {
    mensaje.recibido=true;
    state.turnos[index].mensajes.push(mensaje)
    return { ...state };
  })
);

export function TurnosReducer(state, action) {
  return _TurnosReducer(state, action);
}
