import { Component, OnInit, OnDestroy } from "@angular/core";
import { Subscription } from "rxjs";
import { IMqttMessage, MqttService } from "ngx-mqtt";
import { Store } from "@ngrx/store";
import { TurnosState } from "src/app/turnos/reducer/turnos_reducer";
import { loadTurnos } from "src/app/turnos/actions/turnos_actions";
import { LoginState } from "../../../login/reducers/login_reducer";
import { logout } from "src/app/login/actions/login_action";
import { MatSnackBar } from "@angular/material";
import { MensajesState } from 'src/app/mensajes/reducers/mensajes.reducer';
import { loadMensajes } from '../../../mensajes/actions/mensajes_actions';

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.css"]
})
export class HomeComponent implements OnInit {
  private subscription: Subscription;
  public message: any;
  snackbar;
  constructor(
    private storeTurnos: Store<{ turnos: TurnosState }>,
    private storelogin: Store<{ login: LoginState }>,
    private storemensajes: Store<{ mensajes: MensajesState }>,
    private snack: MatSnackBar,
    private mqtt: MqttService
  ) {}

  ngOnInit() {
    let conexion = 0;
    this.storeTurnos.dispatch(loadTurnos());
    this.storemensajes.dispatch(loadMensajes());
  
    this.mqtt.state.subscribe(conection => {
      
      switch (conection) {
        case 0:
          conexion++;
          if(conexion == 1)
          this.snack.open("Sin Conexion al servidor",'',{horizontalPosition:'left'});
          break;

        case 2:
           this.snack.open("conexion establecida", "Aceptar", {duration:2000,horizontalPosition:'left'});
           conexion = 0;
          break;

        default:
          break;
      }
    });
  }

  outlogin() {
    this.storelogin.dispatch(logout());
  }
}
