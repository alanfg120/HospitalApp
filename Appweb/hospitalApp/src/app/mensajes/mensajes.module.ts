import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MensajesRoutingModule } from './mensajes-routing.module';
import { MensajesComponent } from './vistas/mensajes/mensajes.component';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from 'src/material/material.module';
import { MatSnackBarModule } from '@angular/material';
import { UpdatedialogComponent } from './vistas/updatedialog/updatedialog.component';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [MensajesComponent, UpdatedialogComponent],
  entryComponents:[UpdatedialogComponent],
  imports: [
    CommonModule,
    MensajesRoutingModule,
    MaterialModule,
    FormsModule
  ]
})
export class MensajesModule { }
