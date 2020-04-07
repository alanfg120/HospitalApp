import {
  Component,
  OnInit,
  OnDestroy,
  ViewChild,
  ElementRef,
  ViewChildren,
  QueryList,
  AfterViewInit
} from "@angular/core";
import { Store } from "@ngrx/store";

import { Observable, Subscription } from "rxjs";
import { Turno } from "../../models/turnos_model";
import { Router, RouterState } from "@angular/router";
import { MqttService, IMqttMessage } from "ngx-mqtt";
import { Mensaje } from "../../models/mensaje_model";
import { Cita } from "../../models/cita_model";
import { TurnosState } from "../../reducer/turnos_reducer";
import { getTurno } from "../../selectors/turnos_selector";
import { requestMensaje, sendMensaje } from "../../actions/turnos_actions";
import { debounceTime } from "rxjs/operators";


@Component({
  selector: "app-turno",
  templateUrl: "./turno.component.html",
  styleUrls: ["./turno.component.css"]
})
export class TurnoComponent implements OnInit, OnDestroy, AfterViewInit {
  @ViewChildren("messages") messages: QueryList<any>;
  @ViewChild("texto", { static: false }) text: ElementRef;
  @ViewChild("content", { static: false }) content: ElementRef;

  subscription: Subscription;
  //turno$: Observable<Turno> = this.store.select(state => state.turno.turno);
  params$ = this.storerouter.select((state: any) => state.router.state.params);
  mensajes$: Observable<Mensaje[]>;
  turno$: Observable<Turno>;
  infomessage: boolean;
  index: number;
  topic: string;
  constructor(
    private store: Store<{ turno: TurnosState }>,
    private storerouter: Store<{ router: RouterState }>,
    public router: Router,
    private _mqttService: MqttService
  ) {}

  ngOnInit() {
    this.params$.subscribe(param => {
      this.index = param.turno;
      this.turno$ = this.store.select(getTurno, parseInt(param.turno));
    });
    this.turno$
      .pipe(debounceTime(500))
      .subscribe(data => (this.topic = data.cedula));
    this.subscription = this._mqttService
      .observe("hospital")
      .subscribe((message: IMqttMessage) => {
        let mensaje: Mensaje;
        mensaje = JSON.parse(message.payload.toString());
        this.store.dispatch(requestMensaje({ mensaje, index: this.index }));
      });
  }
  ngAfterViewInit() {
    this.messages.changes.subscribe(this.scrollToBottom);
  }
  scrollToBottom = () => {
    try {
      this.content.nativeElement.scrollTop = this.content.nativeElement.scrollHeight;
    } catch (err) {}
  };
  ngOnDestroy() {
    this.subscription.unsubscribe();
  }
  sendMensajes() {
    let mensaje = new Mensaje();
    mensaje.mensaje = this.text.nativeElement.value;
    mensaje.recibido = false;
    this.store.dispatch(
      sendMensaje({ mensaje, topic: this.topic, index: this.index })
    );
    this.text.nativeElement.value = "";
  }
}
