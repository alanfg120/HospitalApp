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
import { TurnoState } from "../../reducer/turno_reducer";
import { Observable, Subscription } from "rxjs";
import { Turno } from "../../models/turnos_model";
import { Router } from "@angular/router";
import { MqttService, IMqttMessage } from "ngx-mqtt";
import { requestMensaje, sendMensaje } from "../../actions/turno_actions";
import { Mensaje } from "../../models/mensaje_model";
import { Cita } from "../../models/cita_model";

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
  turno$: Observable<Turno> = this.store.select(state => state.turno.turno);
  mensajes$: Observable<Mensaje[]> = this.store.select(
    state => state.turno.mensajes
  );
  turno: Turno;
  infomessage: boolean;

  constructor(
    private store: Store<{ turno: TurnoState }>,
    public router: Router,
    private _mqttService: MqttService
  ) {}

  ngOnInit() {
    this.turno$.subscribe((data: Turno) => (this.turno = data));
    this.subscription = this._mqttService
      .observe("hospital")
      .subscribe((message: IMqttMessage) => {
        let mensaje: Mensaje;
        mensaje = JSON.parse(message.payload.toString());
        this.store.dispatch(requestMensaje({ mensaje }));
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
    console.log("unsubcribe");
  }
  sendMensajes() {
    console.log(this.turno.cedula);
    let mensaje = new Mensaje();
    mensaje.mensaje = this.text.nativeElement.value;
    mensaje.id = "7878";
    mensaje.fecha = Date.now().toString();
    mensaje.recibido = false;
    this.store.dispatch(sendMensaje({ mensaje, topic: this.turno.cedula }));
    this.text.nativeElement.value = "";
  }
}
