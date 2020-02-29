// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turno_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TurnoAdapter extends TypeAdapter<Turno> {
  @override
  final typeId = 1;

  @override
  Turno read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Turno(
      nombre: fields[0] as String,
      email: fields[1] as String,
      cedula: fields[2] as String,
      numero: fields[3] as String,
      tipocita: fields[4] as String,
      observaciones: fields[5] as String,
      automatica: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Turno obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.cedula)
      ..writeByte(3)
      ..write(obj.numero)
      ..writeByte(4)
      ..write(obj.tipocita)
      ..writeByte(5)
      ..write(obj.observaciones)
      ..writeByte(6)
      ..write(obj.automatica);
  }
}
