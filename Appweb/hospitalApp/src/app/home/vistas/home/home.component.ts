import { Component, OnInit, OnDestroy } from "@angular/core";
import { Subscription } from "rxjs";
import { IMqttMessage, MqttService } from "ngx-mqtt";

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.css"]
})
export class HomeComponent implements OnInit, OnDestroy {
  private subscription: Subscription;
  public message: any;
  constructor(private _mqttService: MqttService) {
    this.subscription = this._mqttService
      .observe("hospital")
      .subscribe((message: IMqttMessage) => {
        this.message = message.payload.toString();
        console.log(JSON.parse(this.message));
      });
  }

  ngOnInit() {}

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }
}
