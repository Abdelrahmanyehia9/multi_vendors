class VendorModel{
  final int? id;
  final String name;
  final String image ;

  const VendorModel({required this.id, required this.name, required this.image});

  factory VendorModel.fromJson(Map<String ,dynamic>json)=>VendorModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
  );
}