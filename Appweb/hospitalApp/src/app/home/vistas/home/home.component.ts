import { Component, OnInit, OnDestroy } from "@angular/core";
import { Subscription } from "rxjs";
import { IMqttMessage, MqttService } from "ngx-mqtt";
import { Store } from "@ngrx/store";
import { TurnosState } from "src/app/turnos/reducer/turnos_reducer";
import { loadTurnos } from "src/app/turnos/actions/turnos_actions";
import { LoginState } from "../../../login/reducers/login_reducer";
import { logout } from "src/app/login/actions/login_action";
import { MatSnackBar } from "@angular/material";

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.css"]
})
export class HomeComponent implements OnInit {
  private subscription: Subscription;
  public message: any;
  constructor(
    private storeTurnos: Store<{ turnos: TurnosState }>,
    private storelogin: Store<{ login: LoginState }>,
    private snack: MatSnackBar,
    private mqtt: MqttService
  ) {}

  ngOnInit() {
    this.storeTurnos.dispatch(loadTurnos());
    this.mqtt.state.subscribe(conection => {
      switch (conection) {
        case 0:
          this.snack.open("Sin Conexion al servidor", "Aceptar", {});
          break;

        case 2:
          this.snack.open("conexion establecida", "Aceptar", {});
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
