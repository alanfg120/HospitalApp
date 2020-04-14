import { createFeatureSelector, createSelector, props } from '@ngrx/store';
import { MensajesState } from '../reducers/mensajes.reducer';

export const getMensajesSelector = createFeatureSelector<MensajesState>('mensajes');

export const getMensajes = createSelector(
  getMensajesSelector,
  (state: MensajesState) => state.mensajes
);




