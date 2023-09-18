import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

enum DeliveryStatus {
  creation,
  available,
  locked,
  delivered,
}

class Delivery {
  Delivery(
      {required this.deliveryDate,
      required this.products,
      required this.id,
      required this.status,
      this.expanded = false});
  late final bool expanded;
  late final DeliveryStatus status;
  late final DateTime deliveryDate;
  late final List<Product> products;
  late final String id;

  Delivery.fromJson(Map<String, dynamic> json) {
    deliveryDate = DateTime.parse(json['delivery_date']);
    products =
        List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    id = json['id'];
    status = stringToDeliveryStatus(json['status']);
    expanded = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['delivery_date'] = processDateToAPIWithoutHour(deliveryDate);
    data['products_ids'] = products.map((e) => e.id).toList();
    data['status'] = deliveryStatusToString(status);
    data['id'] = id;
    return data;
  }

  Delivery copyWith(
      {DateTime? deliveryDate,
      List<Product>? products,
      bool? expanded,
      String? id,
      DeliveryStatus? status}) {
    return Delivery(
        deliveryDate: deliveryDate ?? this.deliveryDate,
        products: products ?? this.products,
        expanded: expanded ?? this.expanded,
        status: status ?? this.status,
        id: id ?? this.id);
  }

  static Delivery empty() => Delivery(
      deliveryDate: DateTime.now(),
      products: [],
      expanded: false,
      status: DeliveryStatus.creation,
      id: '');
}
