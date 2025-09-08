import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/providers/delivery_list_provider.dart';
import 'package:titan/amap/providers/delivery_order_list_provider.dart';
import 'package:titan/amap/providers/user_amount_provider.dart';
import 'package:titan/amap/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> amapProviders = {
  "cash": Tuple2(AmapRouter.root, [userAmountProvider]),
  "delivery": Tuple2(AmapRouter.root, [deliveryListProvider]),
  "orders": Tuple2(AmapRouter.root + AmapRouter.admin, [
    adminDeliveryOrderListProvider,
  ]),
};
