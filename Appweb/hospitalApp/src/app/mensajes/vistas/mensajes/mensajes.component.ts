import { Component, OnInit, Inject } from "@angular/core";
import { MensajesState } from "../../reducers/mensajes.reducer";
import { Store } from "@ngrx/store";
import { Observable } from "rxjs";
import {
  saveMensajes,
  deleteMensajes,
  deleteMensajesDb,
  loadedMensajes,
  loadMensajes,
} from "../../actions/mensajes_actions";
import { MensajesPersonalizados } from "../../models/mensajesp_models";
import { getMensajes } from "../../selectors/mensajes_selectors";
import { UpdatedialogComponent } from '../updatedialog/updatedialog.component';
import {
  MatDialog
} from "@angular/material/dialog";

@Component({
  selector: "app-mensajes",
  templateUrl: "./mensajes.component.html",
  styleUrls: ["./mensajes.component.css"],
})
export class MensajesComponent implements OnInit {
  mensajes$: Observable<MensajesPersonalizados[]> = this.store.select(
    getMensajes
  );
  loading$: Observable<boolean> = this.store.select(
    state=>state.mensajes.isloading
  );
  update: boolean;
  constructor(
    private store: Store<{ mensajes: MensajesState }>,
    public dialog: MatDialog
  ) {}

  ngOnInit() {
    this.store.dispatch(loadMensajes());
  }

  saveMensaje(mjs: string) {
    let mensaje = new MensajesPersonalizados(mjs);
    this.store.dispatch(saveMensajes({ mensaje }));
  }
  deleteMensaje(index: number, uuid: string) {
    let c = confirm("Desea eliminar el mensaje!");
    if (c) this.store.dispatch(deleteMensajesDb({ index, uuid }));
  }



  updateMensaje(id:string,mensaje:string,index:number) {
     this.dialog.open(UpdatedialogComponent, {
      width: '450px',
      data: {id,mensaje,index}
    });
  }

}

