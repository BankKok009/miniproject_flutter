// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SQLiteModel {
  final int? id;
  final String idSeller;
  final String idProduct;
  final String name;
  final String price;
  final String amount;
  final String sum;
  SQLiteModel({
    this.id,
    required this.idSeller,
    required this.idProduct,
    required this.name,
    required this.price,
    required this.amount,
    required this.sum,
  });

  SQLiteModel copyWith({
    int? id,
    String? idSeller,
    String? idProduct,
    String? name,
    String? price,
    String? amount,
    String? sum,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      idSeller: idSeller ?? this.idSeller,
      idProduct: idProduct ?? this.idProduct,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idSeller': idSeller,
      'idProduct': idProduct,
      'name': name,
      'price': price,
      'amount': amount,
      'sum': sum,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: map['id'] as int,
      idSeller: map['idSeller'] as String,
      idProduct: map['idProduct'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      amount: map['amount'] as String,
      sum: map['sum'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) =>
      SQLiteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SQLiteModel(id: $id, idSeller: $idSeller, idProduct: $idProduct, name: $name, price: $price, amount: $amount, sum: $sum)';
  }

  @override
  bool operator ==(covariant SQLiteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idSeller == idSeller &&
        other.idProduct == idProduct &&
        other.name == name &&
        other.price == price &&
        other.amount == amount &&
        other.sum == sum;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idSeller.hashCode ^
        idProduct.hashCode ^
        name.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        sum.hashCode;
  }
}
