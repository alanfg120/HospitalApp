import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of } from "rxjs";
import { map, catchError, concatMap, mergeMap } from "rxjs/operators";
import {
  loadMensajes,
  loadedMensajes,
  deleteMensajes,
  deleteMensajesDb,
} from "../actions/mensajes_actions";

import { MatSnackBar } from "@angular/material";
import { MensajesService } from "../servicios/mensajes.service";
import { saveMensajes, updateMensajesDb, updateMensajes } from '../actions/mensajes_actions';

@Injectable()
export class MensajesEffects {
  loadMensajes$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadMensajes.type),
      concatMap(() =>
        this._mensajes.getMensajes().pipe(
          map((mensajes) => {
            return loadedMensajes({ mensajes });
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );
  deleteMensajes$ = createEffect(() =>
    this.actions$.pipe(
      ofType(deleteMensajesDb),
      concatMap((action) =>
        this._mensajes.deleteMensajes(action.uuid).pipe(
          map(() => {
            this.snack("Mensaje Eliminado");
            return deleteMensajes({ index: action.index });
          }),
          catchError(() => {
            this.snack("Ocurrio un error")
            return EMPTY;
         })
        )
      )
    )
  );
  addmensaje$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(saveMensajes),
        concatMap((action) => {
          return this._mensajes.addMensajes(action.mensaje).pipe(
            map(() => this.snack("mensaje Guardado")),
            catchError(() => of(this.snack("Ocurrio un error")))
          );
        })
      ),
    { dispatch: false }
  );
  updatemensaje$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(updateMensajesDb),
        mergeMap((action) => {
          return this._mensajes.updateMensajes(action.mensaje).pipe(
            map(() => {
              this.snack("Mensaje Actualizado");
              return updateMensajes({mensaje:action.mensaje,index:action.index});
            }),
            catchError(() => {
              this.snack("Ocurrio un Error");
              return EMPTY
            })
          );
        })
      ),
   
  );
  constructor(
    private actions$: Actions,
    private _mensajes: MensajesService,
    private snackbar: MatSnackBar
  ) {}

  private snack(mensaje: string) {
    this.snackbar.open(mensaje, "Aceptar", { duration: 2000 });
  }
}
