import { UUID } from 'angular2-uuid';

export class MensajesPersonalizados {
  public id: string;
  constructor(public mensaje: string) {
      this.id=UUID.UUID()
  }
}
