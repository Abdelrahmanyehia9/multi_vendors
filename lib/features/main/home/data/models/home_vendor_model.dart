
import 'package:multi_vendor/shared/data/models/vendor_model.dart';

class HomeVendorModel extends VendorModel{
 const  HomeVendorModel({super.id, required super.name, required super.image});

 factory HomeVendorModel.fromJson(Map<String, dynamic> json) => HomeVendorModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
  );


}