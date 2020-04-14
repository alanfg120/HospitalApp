import { createReducer, on } from "@ngrx/store";
import * as moment from "moment";
import { loadMensajes, saveMensajes, deleteMensajes, loadedMensajes, updateMensajes } from '../actions/mensajes_actions';
import { MensajesPersonalizados } from '../models/mensajesp_models';



let initialmensajes: MensajesPersonalizados[] = [];

export interface MensajesState {
 mensajes: MensajesPersonalizados[];
 isloading?:boolean
}

export const initialState: MensajesState = {
 mensajes: [],
};

const _MensajeReducer = createReducer(
  initialState,
  on(loadMensajes, (state) => {
    return { ...state,isloading:true};
  }),
  on(saveMensajes,(state,{mensaje}) => {
    state.mensajes.push(mensaje)
    return { ...state};
  }),
  on(deleteMensajes,(state,{index}) => {
    state.mensajes.splice(index,1)
    return { ...state};
  }),
  on(loadedMensajes,(state,{mensajes}) => {
    initialmensajes=mensajes
    return { ...state,mensajes,isloading:false};
  }),
  on(updateMensajes,(state,{index,mensaje}) => {
    state.mensajes[index]=mensaje
    return { ...state};
  }),
  
);

export function MensajeReducer(state, action) {
  return _MensajeReducer(state, action);
}
