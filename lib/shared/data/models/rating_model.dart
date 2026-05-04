
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class RatingModel{
  final num rating;
  final int? count;
  final RatingDistribution? distribution;
  const  RatingModel({required this.rating,  this.count , this.distribution});

  factory RatingModel.fromJson(Map<String ,dynamic>json)=>RatingModel(
      rating: json['value'],
      count: json['count'],
      distribution: json['distribution']==null?null :  RatingDistribution.fromJson(json['distribution'])
  );

  factory RatingModel.fake()=> RatingModel(
    rating: FakeData.fakeDouble,
    count: FakeData.fakeInt,
    distribution: RatingDistribution.fake()
  );
  Map<String, dynamic> toJson() => {
    "value": rating,
    "count": count,};

  List<int> get distributionList => [distribution?.one ?? 0, distribution?.two ?? 0, distribution?.three ?? 0, distribution?.four ?? 0, distribution?.five ?? 0];

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
  factory RatingDistribution.fake()=>const RatingDistribution(
      one:   FakeData.fakeInt,
      two:   FakeData.fakeInt,
      three: FakeData.fakeInt,
      four:  FakeData.fakeInt,
      five:  FakeData.fakeInt,
  );


}