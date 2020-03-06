import { Component, OnInit, OnDestroy } from "@angular/core";
import { Subscription } from "rxjs";
import { IMqttMessage, MqttService } from "ngx-mqtt";
import { Store } from '@ngrx/store';
import { TurnosState } from 'src/app/turnos/reducer/turnos_reducer';
import { loadTurnos } from 'src/app/turnos/actions/turnos_actions';

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
    ) {

    
  }

  ngOnInit() {
    this.storeTurnos.dispatch(loadTurnos());
  }

  
}
