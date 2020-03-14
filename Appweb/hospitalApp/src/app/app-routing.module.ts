import { NgModule } from "@angular/core";
import { Routes, RouterModule } from "@angular/router";
import { AuthService } from "./login/services/auth.service";

const routes: Routes = [
  {
    path: "login",
    loadChildren: "./login/login.module#LoginModule"
  },
  {
    path: "Home",
    loadChildren: "./home/home.module#HomeModule",
    canActivate: [AuthService]
  },
  {
    path: "**",
    loadChildren: "./login/login.module#LoginModule"
    //loadChildren: "./home/home.module#HomeModule" ,
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule]
})
export class AppRoutingModule {}
