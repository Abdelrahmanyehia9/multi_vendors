
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class RatingModel{
  final num rating;
  final int count;
  final RatingDistribution? distribution;
  const  RatingModel({required this.rating, required this.count , this.distribution});

  factory RatingModel.fromJson(Map<String ,dynamic>json)=>RatingModel(
      rating: json['value'],
      count: json['count'],
      distribution:  json['distribution']==null?null:RatingDistribution.fromJson(json['distribution'])
  );

  factory RatingModel.fake()=>const RatingModel(
    rating: FakeData.fakeDouble,
    count: FakeData.fakeInt,
  );
  Map<String, dynamic> toJson() => {
    "value": rating,
    "count": count,};

}

class RatingDistribution{
  final int one;
  final int two;
  final int three;
  final int four;
  final int five;
 const RatingDistribution({required this.one, required this.two, required this.three, required this.four, required this.five});

  factory RatingDistribution.fromJson(Map<String, dynamic>json)=>RatingDistribution(
      one: json["1"],
      two: json["2"],
      three: json["3"],
      four: json["4"],
      five: json["5"]);


}