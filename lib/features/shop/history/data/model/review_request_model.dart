import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';

class ReviewRequestModel extends Equatable{
  final int itemId;
  final double? rate;
  final String? comment;
  final int productId;

 const ReviewRequestModel({
    required this.itemId,
     this.rate,
   this.comment,
   required this.productId,
  });

  ReviewRequestModel copyWith({
   int? itemId,
   double? rate,
   String? comment,
   int? productId
 }) =>ReviewRequestModel(
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

  @override
  // TODO: implement props
  List<Object?> get props => [itemId];

}
