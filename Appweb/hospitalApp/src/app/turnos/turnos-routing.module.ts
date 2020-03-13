import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TurnosComponent } from './vistas/turnos/turnos.component';
import { TurnoComponent } from './vistas/turno/turno.component';


const routes: Routes = [
  {
    path:'turnos',
    component:TurnosComponent
  },
  {
    path:'turno/:turno',
    component:TurnoComponent

  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class TurnosRoutingModule { }
