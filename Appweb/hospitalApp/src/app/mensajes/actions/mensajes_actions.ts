import { createAction, props } from "@ngrx/store";


export const loadMensajes = createAction("[Mensajes Componet] LoadingMensajes");

export const loadedMensajes = createAction(
  "[Mensajes Componet] LoadedMensajes",
  props<{ mensajes: string[] }>()
);

export const saveMensajes = createAction(
  "[Mensajes Componet] SaveMensajes",
  props<{ mensaje: string}>()
);
export const deleteMensajes = createAction(
  "[Mensajes Componet] DeleteMensajes",
  props<{ index:number,confirmar:boolean}>()
);
export const deleteMensajesDb = createAction(
  "[Mensajes Componet] DeleteMensajesDB",
  props<{ index:number}>()
);

