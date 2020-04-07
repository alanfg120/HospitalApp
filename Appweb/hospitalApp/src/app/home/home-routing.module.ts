import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './vistas/home/home.component';


const routes: Routes = [
  {
    path:'',
    component:HomeComponent,
    children:[
      {
        path:'turnos',
        loadChildren:"./../turnos/turnos.module#TurnosModule"
      },
      {
        path:'mensajes',
        loadChildren:"./../mensajes/mensajes.module#MensajesModule"
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
