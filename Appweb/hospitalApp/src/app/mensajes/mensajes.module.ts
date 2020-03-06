import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MensajesRoutingModule } from './mensajes-routing.module';
import { MensajesComponent } from './vistas/mensajes/mensajes.component';
import { HttpClientModule } from '@angular/common/http';


@NgModule({
  declarations: [MensajesComponent],
  imports: [
    CommonModule,
    MensajesRoutingModule,

  ]
})
export class MensajesModule { }
