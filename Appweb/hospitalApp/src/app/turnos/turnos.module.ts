import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { TurnosRoutingModule } from './turnos-routing.module';
import { TurnosComponent } from './vistas/turnos/turnos.component';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from '../../material/material.module';
import { TurnoComponent } from './vistas/turno/turno.component';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [TurnosComponent, TurnoComponent],
  imports: [
    CommonModule,
    TurnosRoutingModule,
    MaterialModule,
    FormsModule
  ]
})
export class TurnosModule { }
