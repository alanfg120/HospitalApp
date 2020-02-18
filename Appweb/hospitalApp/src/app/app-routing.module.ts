import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  {
    path: "",
    loadChildren: "./login/login.module#LoginModule"
  },
  {
    path:"Home",
    loadChildren: "./home/home.module#HomeModule" ,
    //canActivate:[LoginService]
  },
/*   { 
     path: "**", 
     //loadChildren: "./login/login.module#LoginModule"
     loadChildren: "./home/home.module#HomeModule" , 
  } */
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
