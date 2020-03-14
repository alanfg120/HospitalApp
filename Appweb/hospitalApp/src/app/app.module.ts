import { BrowserModule } from "@angular/platform-browser";
import { NgModule } from "@angular/core";

import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { StoreModule } from "@ngrx/store";
import { TurnosReducer } from "./turnos/reducer/turnos_reducer";
import { EffectsModule } from "@ngrx/effects";
import { TurnosEffects } from "./turnos/effects/turnos_effect";
import { StoreDevtoolsModule } from "@ngrx/store-devtools";
import { HttpClientModule } from "@angular/common/http";
import { MqttModule, IMqttServiceOptions } from "ngx-mqtt";
import { TurnoReducer } from "./turnos/reducer/turno_reducer";
import { TurnoEffects } from "./turnos/effects/turno.effects";
import { LoginReducer } from "./login/reducers/login_reducer";
import { LoginEffects } from "./login/effects/login_effects";
import { Interceptor } from "./interceptor_http";
import { StoreRouterConnectingModule, routerReducer } from "@ngrx/router-store";
import { CustomSerializer } from "./router-store/custom-route-serializer";

export const MQTT_SERVICE_OPTIONS: IMqttServiceOptions = {
  hostname: "192.168.0.17",
  port: 9001,
  path: "/mqtt",
  username: "alice",
  password: "secret",
  connectOnCreate: false,
  keepalive:10,
  reconnectPeriod:10
  //protocol: "wss"
};

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    StoreModule.forRoot({
      turnos: TurnosReducer,
      turno: TurnoReducer,
      login: LoginReducer,
      router: routerReducer
    }),
    EffectsModule.forRoot([TurnosEffects, TurnoEffects, LoginEffects]),
    StoreDevtoolsModule.instrument({
      maxAge: 25
    }),
    MqttModule.forRoot(MQTT_SERVICE_OPTIONS),
    Interceptor,
    StoreRouterConnectingModule.forRoot({ serializer: CustomSerializer })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {}
