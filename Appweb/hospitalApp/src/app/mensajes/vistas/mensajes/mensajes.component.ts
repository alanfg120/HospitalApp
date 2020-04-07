import { Component, OnInit } from "@angular/core";
import { MensajesState } from "../../reducers/mensajes.reducer";
import { Store } from "@ngrx/store";
import { Observable } from 'rxjs';
import { saveMensajes,deleteMensajes, deleteMensajesDb} from '../../actions/mensajes_actions';

@Component({
  selector: "app-mensajes",
  templateUrl: "./mensajes.component.html",
  styleUrls: ["./mensajes.component.css"]
})
export class MensajesComponent implements OnInit {
 
  mensajes$:Observable<string[]> = this.store.select(state=>state.mensajes.mensajes)

  constructor(private store: Store<{ mensajes: MensajesState }>) {}

  ngOnInit() {}

  saveMensaje(mensaje:string){
   this.store.dispatch(saveMensajes({mensaje}));
  }
  deleteMensaje(index:number){
    this.store.dispatch(deleteMensajesDb({index}))
  }
}
