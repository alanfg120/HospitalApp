import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of } from "rxjs";
import { map, mergeMap, catchError, switchMap, tap } from "rxjs/operators";
import { loadTurnos, loadedTurnos, sendMensaje } from "../actions/turnos_actions";
import { TurnosService } from "../services/turnos.service";
import * as moment from 'moment';
import { MqttService } from 'ngx-mqtt';


@Injectable()
export class TurnosEffects {
  loadIngresos$ = createEffect(() =>
    this.actions$.pipe(
      ofType(loadTurnos.type),
      mergeMap(() =>
        this.turnosService.getTurnos().pipe(
          map(turnos => {
            turnos.forEach((turno,index)=>{
        
              turno.numero = (index+1).toString() 
            }
              )
            return loadedTurnos({ turnos })
          }),
          catchError(() => EMPTY)
        )
      )
    )
  );
  sendMessageMqtt$ = createEffect(
    () =>
      this.actions$.pipe(
        ofType(sendMensaje),
        tap(action => {
          this._mqttService.unsafePublish(
            action.topic,
            JSON.stringify(action.mensaje)
          );
        })
      ),
    { dispatch: false }
  );

  constructor(
    private actions$: Actions,
    private turnosService: TurnosService,
    private _mqttService: MqttService
  ) {}
}
