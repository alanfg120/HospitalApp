import { createReducer, on } from "@ngrx/store";
import { Turno } from "../models/turnos_model";
import * as moment from "moment";
import { loadTurnos, loadedTurnos } from "../actions/turnos_actions";

let initialturnos: Turno[] = [];
export interface IngresosState {
  turnos: Turno[];
  isloading?: boolean;
}

export const initialState: IngresosState = {
  turnos: []
};

const _TurnosReducer = createReducer(
  initialState,
  on(loadTurnos, state => {
    return { ...state, isloading: true };
  }),

  on(loadedTurnos, (state, { turnos }) => {
    initialturnos = turnos.reverse();
    return { ...state, turnos, isloading: false };
  })
);

export function TurnosReducer(state, action) {
  return _TurnosReducer(state, action);
}
