// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordAdapter extends TypeAdapter<Password> {
  @override
  final int typeId = 0;

  @override
  Password read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Password(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      hint: fields[3] == null ? false : fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Password obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.group)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.hint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
