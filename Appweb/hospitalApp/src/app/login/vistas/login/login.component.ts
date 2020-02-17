import { Component, OnInit } from "@angular/core";
import { Usuario } from "../../models/usuario_class";

@Component({
  selector: "app-login",
  templateUrl: "./login.component.html",
  styleUrls: ["./login.component.css"]
})
export class LoginComponent implements OnInit {
  usuario = new Usuario();
  constructor() {}
  ngOnInit() {}
  login(form) {}
}
