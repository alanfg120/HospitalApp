import { createAction, props } from "@ngrx/store";
import { MensajesPersonalizados } from '../models/mensajesp_models';


export const loadMensajes = createAction("[Mensajes Componet] LoadingMensajes");

export const loadedMensajes = createAction(
  "[Mensajes Componet] LoadedMensajes",
  props<{ mensajes: MensajesPersonalizados[]}>()
);

export const saveMensajes = createAction(
  "[Mensajes Componet] SaveMensajes",
  props<{ mensaje: MensajesPersonalizados}>()
);

export const deleteMensajes = createAction(
  "[Mensajes Componet] DeleteMensajes",
  props<{ index:number}>()
);

export const deleteMensajesDb = createAction(
  "[Mensajes Componet] DeleteMensajesDB",
  props<{ index:number,uuid:string}>()
);

export const updateMensajesDb = createAction(
  "[Mensajes Componet] UpdateMensajeDB",
  props<{mensaje:MensajesPersonalizados,index:number}>()
);

export const updateMensajes = createAction(
  "[Mensajes Componet]  UpdateMensaje",
  props<{mensaje:MensajesPersonalizados,index:number}>()
);

