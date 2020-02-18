import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of } from "rxjs";
import { map, mergeMap, catchError, switchMap, tap } from "rxjs/operators";

import * as moment from "moment";

import { MatSnackBar } from "@angular/material";
import { loadTurnos, loadedTurnos } from "../actions/turnos_actions";
import { TurnosService } from "../services/turnos.service";

@Injectable()
export class TurnosEffects {
  loadIngresos$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadTurnos.type),
      mergeMap(() =>
        this.turnosService.getTurnos().pipe(
          map(turnos => loadedTurnos({ turnos })),
          catchError(() => EMPTY)
        )
      )
    )
  );

  constructor(
    private actions$: Actions,
    private turnosService: TurnosService,
  
  ) {}
}
