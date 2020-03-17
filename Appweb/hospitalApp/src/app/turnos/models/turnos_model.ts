import { Moment } from 'moment';
import { Mensaje } from './mensaje_model';
import * as moment from 'moment';


export class Turno {   

public nombre:string;
public email:string;
public cedula:string;
public numero:string;
public tipocita:string;
public observaciones:string;
public automatica:boolean;
public fecha:Moment;
public mensajes:Mensaje[]=[];


}