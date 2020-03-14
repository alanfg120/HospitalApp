import { createReducer, on } from "@ngrx/store";
import { Usuario } from "../models/usuario_model";
import {
  authAction,
  errorAction,
  successAction
} from "../actions/login_action";

export interface LoginState {
  errorStatus?: any;
  usuario: Usuario;
}

export const initialState: LoginState = {
  usuario: new Usuario()
};

const _LoginReducer = createReducer(
  initialState,
  on(authAction, (state, { usuario }) => {
    return { ...state };
  }),
  on(errorAction, (state, { error }) => {
    return { ...state, errorStatus: error };
  }),
  on(successAction, (state, { usuario }) => {
    return { ...state, usuario };
  })
);

export function LoginReducer(state, action) {
  return _LoginReducer(state, action);
}
