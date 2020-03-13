import { Injectable } from "@angular/core";
import { Actions, createEffect, ofType } from "@ngrx/effects";
import { EMPTY, of, pipe } from "rxjs";
import {
  map,
  mergeMap,
  catchError,
  switchMap,
  tap,
  exhaustMap
} from "rxjs/operators";
import { MqttService } from "ngx-mqtt";
import { sendMensaje, requestMensaje } from "../actions/turno_actions";

@Injectable()
export class TurnoEffects {
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
  
  constructor(private actions$: Actions, private _mqttService: MqttService) {}
}
