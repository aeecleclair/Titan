import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/raffle/providers/user_tickets_provider.dart';
import 'package:titan/raffle/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> raffleProviders =
    {
      "raffles": Tuple2(RaffleRouter.root, [raffleListProvider]),
      "tickets": Tuple2(RaffleRouter.root, [userTicketListProvider]),
    };
