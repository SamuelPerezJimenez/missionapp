// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactTableAdapter extends TypeAdapter<ContactTable> {
  @override
  final int typeId = 2;

  @override
  ContactTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactTable(
      name: fields[0] as String,
      identification: fields[1] as int,
      userEmail: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.identification)
      ..writeByte(2)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
