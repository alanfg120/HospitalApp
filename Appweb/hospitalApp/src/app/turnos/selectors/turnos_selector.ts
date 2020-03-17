import { createFeatureSelector, createSelector, props } from '@ngrx/store';
import { TurnosState } from '../reducer/turnos_reducer';

export const getTurnosState = createFeatureSelector<TurnosState>('turnos');

export const getTurnos = createSelector(
  getTurnosState,
  (state: TurnosState) => state.turnos
);
export const getTurno = createSelector(
  getTurnosState,
  (state: TurnosState,index) => state.turnos[index]
);

