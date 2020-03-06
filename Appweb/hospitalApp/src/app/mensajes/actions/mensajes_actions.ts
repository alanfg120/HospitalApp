import { createAction, props } from "@ngrx/store";


export const loadMensajes = createAction("[Mensajes Componet] LoadingMensajes");

export const loadedMensajes = createAction(
  "[Mensajes Componet] LoadedMensajes",
  props<{ mensajes: string[] }>()
);

