import { Component, OnInit } from "@angular/core";
import { TurnosState } from "../../reducer/turnos_reducer";
import { Store } from "@ngrx/store";
import { Turno } from "../../models/turnos_model";
import { Observable } from "rxjs";
import { loadTurnos } from "../../actions/turnos_actions";

import { getTurnos } from "../../selectors/turnos_selector";

@Component({
  selector: "app-turnos",
  templateUrl: "./turnos.component.html",
  styleUrls: ["./turnos.component.css"]
})
export class TurnosComponent implements OnInit {
  turnos$: Observable<Turno[]> = this.storeTurnos.select(getTurnos);
  loading$: Observable<boolean> = this.storeTurnos.select(
    state => state.turnos.isloading
  );
  constructor(
    private storeTurnos: Store<{ turnos: TurnosState }>,

  ) {}
  ngOnInit() {}
  getturno(turno: Turno, index: number) {
    turno.numero = index.toString();
 
  }
}
