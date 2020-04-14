import { Component, OnInit, Inject } from "@angular/core";
import { MatDialogRef, MAT_DIALOG_DATA } from "@angular/material";
import { Store } from '@ngrx/store';
import { MensajesState } from '../../reducers/mensajes.reducer';
import { MensajesPersonalizados } from '../../models/mensajesp_models';
import { updateMensajesDb } from '../../actions/mensajes_actions';

@Component({
  selector: "app-updatedialog",
  templateUrl: "./updatedialog.component.html",
  styleUrls: ["./updatedialog.component.css"],
})
export class UpdatedialogComponent implements OnInit {
  constructor(
    public dialogRef: MatDialogRef<UpdatedialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data,
    private store: Store<{ mensajes: MensajesState }>
  ) {}

  ngOnInit() {}
  updateMensaje() {
    let mensaje=new MensajesPersonalizados(this.data.mensaje)
        mensaje.id = this.data.id 
    this.store.dispatch(updateMensajesDb({mensaje,index:this.data.index}))
    this.dialogRef.close();
  }
}
