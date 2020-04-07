import { createReducer, on } from "@ngrx/store";
import * as moment from "moment";
import { loadMensajes, saveMensajes, deleteMensajes } from '../actions/mensajes_actions';




export interface MensajesState {
 mensajes: string[];
}

export const initialState: MensajesState = {
 mensajes: []
};

const _MensajeReducer = createReducer(
  initialState,
  on(loadMensajes, (state) => {
    return { ...state };
  }),
  on(saveMensajes,(state,{mensaje}) => {
    state.mensajes.push(mensaje)
    return { ...state};
  }),
  on(deleteMensajes,(state:MensajesState,{index,confirmar}) => {
    if(confirmar) state.mensajes.splice(index,1)
    return { ...state};
  }),
  
);

export function MensajeReducer(state, action) {
  return _MensajeReducer(state, action);
}
