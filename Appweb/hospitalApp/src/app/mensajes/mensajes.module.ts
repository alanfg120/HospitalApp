import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MensajesRoutingModule } from './mensajes-routing.module';
import { MensajesComponent } from './vistas/mensajes/mensajes.component';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from 'src/material/material.module';


@NgModule({
  declarations: [MensajesComponent],
  imports: [
    CommonModule,
    MensajesRoutingModule,
    MaterialModule
  ]
})
export class MensajesModule { }
