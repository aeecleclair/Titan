import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TransferStructureNotifier extends SingleNotifierAPI {
  Openapi get structuresRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue build() {
    return const AsyncValue.loading();
  }

  Future<bool> initTransfer(Structure structure, String newUserId) async {
    return (await structuresRepository
            .mypaymentStructuresStructureIdInitManagerTransferPost(
              structureId: structure.id,
              body: StructureTranfert(newManagerUserId: newUserId),
            ))
        .isSuccessful;
  }
}

final transferStructureProvider =
    NotifierProvider<TransferStructureNotifier, AsyncValue>(
      TransferStructureNotifier.new,
    );
