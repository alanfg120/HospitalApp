import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of } from "rxjs";
import { map, mergeMap, catchError, switchMap, tap } from "rxjs/operators";
import { loadMensajes,loadedMensajes } from '../actions/mensajes_actions';
import * as moment from "moment";

import { MatSnackBar } from "@angular/material";
import { MensajesService } from '../servicios/mensajes.service';

;

@Injectable()
export class MensajesEffects {
    loadMensajes$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadMensajes.type),
      mergeMap(() =>
        this._mensajes.getMensajes().pipe(
          map(mensajes => loadedMensajes({ mensajes })),
          catchError(() => EMPTY)
        )
      )
    )
  );

  constructor(
    private actions$: Actions,
    private _mensajes:MensajesService
  ) {}
}
