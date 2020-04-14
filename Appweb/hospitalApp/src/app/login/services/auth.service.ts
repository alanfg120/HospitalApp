import { Injectable } from "@angular/core";
import { MqttService } from "ngx-mqtt";
import {
  Router,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  CanActivate
} from "@angular/router";
import { Store } from "@ngrx/store";
import { LoginState } from "../reducers/login_reducer";

@Injectable({
  providedIn: "root"
})
export class AuthService implements CanActivate {
  constructor(
    private router: Router,
    private _mqtt: MqttService,
    private store: Store<{ login: LoginState }>
  ) {}

  canActivate(netx: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    if (sessionStorage.getItem("id_seccion")) {
      this._mqtt.connect({ clientId: sessionStorage.getItem("id_conection") });
      return true;
    } else {
      this.router.navigate(["login"]);
      return false;
    }
  }
}
