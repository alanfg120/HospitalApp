import { createAction, props } from "@ngrx/store";
import { Turno } from '../models/turnos_model';

export const loadTurnos = createAction("[Ingresos Componet] LoadIngresos");

export const loadedTurnos = createAction(
  "[Turnos Componet] LoadedTurnos",
  props<{ turnos: Turno[] }>()
);

