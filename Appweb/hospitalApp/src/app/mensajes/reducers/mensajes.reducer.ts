import { createReducer, on } from "@ngrx/store";

import * as moment from "moment";
import { loadMensajes } from '../actions/mensajes_actions';




export interface MensajesState {

  mensajes: string[];
}

export const initialState: MensajesState = {
 mensajes: []
};

const _TurnoReducer = createReducer(
  initialState,
  on(loadMensajes, (state) => {
    return { ...state };
  }),

);

export function TurnoReducer(state, action) {
  return _TurnoReducer(state, action);
}
