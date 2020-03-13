import { createReducer, on } from "@ngrx/store";
import { authAction } from "../actions/login_action";

export interface LoginState {}

export const initialState: LoginState = {};

const _LoginReducer = createReducer(
  initialState,
  on(authAction, (state,{usuario}) => {
    return { ...state,usuario};
  })
);

export function LoginReducer(state, action) {
  return _LoginReducer(state, action);
}
