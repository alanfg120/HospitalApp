import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { TurnosRoutingModule } from './turnos-routing.module';
import { TurnosComponent } from './vistas/turnos/turnos.component';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from '../../material/material.module';


@NgModule({
  declarations: [TurnosComponent],
  imports: [
    CommonModule,
    TurnosRoutingModule,
    MaterialModule
  ]
})
export class TurnosModule { }
