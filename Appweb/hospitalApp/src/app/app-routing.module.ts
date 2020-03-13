import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  {
    path: "login",
    loadChildren: "./login/login.module#LoginModule"
  },
  {
    path:"",
    loadChildren: "./home/home.module#HomeModule" ,
    //canActivate:[LoginService]
  },
  { 
     path: "**", 
     //loadChildren: "./login/login.module#LoginModule"
     loadChildren: "./home/home.module#HomeModule" , 
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes,{useHash:true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
