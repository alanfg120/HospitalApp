// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final typeId = 0;

  @override
  Usuario read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      nombre: fields[0] as String,
      email: fields[1] as String,
      cedula: fields[2] as String,
      password: fields[3] as String,
      token: fields[4] as String,
      idPush: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.cedula)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.idPush);
  }
}
