import { createAction, props } from "@ngrx/store";
import { Turno } from '../models/turnos_model';

export const loadTurnos = createAction("[Turnos Componet] LoadingTurnos");

export const loadedTurnos = createAction(
  "[Turnos Componet] LoadedTurnos",
  props<{ turnos: Turno[] }>()
);

