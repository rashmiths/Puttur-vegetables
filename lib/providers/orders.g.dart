// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderItemAdapter extends TypeAdapter<OrderItem> {
  @override
  OrderItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderItem(
      id: fields[0] as String,
      amount: fields[1] as num,
      products: (fields[2] as List)?.cast<CartItem>(),
      dateTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OrderItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.products)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get typeId => 0;
}
