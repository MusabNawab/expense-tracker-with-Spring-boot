// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 1;

  @override
  Categories read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Categories.food;
      case 1:
        return Categories.travel;
      case 2:
        return Categories.entertainment;
      case 3:
        return Categories.health;
      case 4:
        return Categories.others;
      default:
        return Categories.food;
    }
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    switch (obj) {
      case Categories.food:
        writer.writeByte(0);
        break;
      case Categories.travel:
        writer.writeByte(1);
        break;
      case Categories.entertainment:
        writer.writeByte(2);
        break;
      case Categories.health:
        writer.writeByte(3);
        break;
      case Categories.others:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
