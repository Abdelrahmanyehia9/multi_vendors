import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class ReviewModel extends Equatable{
  final int itemId;
  final int? rate;
  final String? comment;
  final int productId;
  final DateTime? createdAt;

 const ReviewModel({
    required this.itemId,
     this.rate,
   this.comment,
   this.createdAt,
   required this.productId,
  });

  ReviewModel copyWith({
   int? itemId,
   int? rate,
   String? comment,
   int? productId
 }) =>ReviewModel(
   itemId: itemId ?? this.itemId,
   rate: rate ?? this.rate,
   comment: comment ?? this.comment,
   productId: productId ?? this.productId
 );

 Map<String, dynamic>toJson()=>{
   'order_item_id':itemId,
   'value':rate,
   'comment':comment,
   'product_id':productId
 } .withoutNulls;

 factory ReviewModel.fromJson(Map<String, dynamic>json)=>ReviewModel(
     itemId: json['order_item_id'],
     rate: json['value'],
     comment: json['comment'],
     productId: json['product_id'],
     createdAt: json['created_at']==null?null:DateTime.parse(json['created_at']),
 );

  factory ReviewModel.fake()=>ReviewModel(
    itemId: FakeData.fakeInt,
    rate: 4,
    comment: FakeData.fakeStringTitle,
    productId: FakeData.fakeInt,
    createdAt: FakeData.fakeDateTime,
  );

  @override
  List<Object?> get props => [itemId];

}
