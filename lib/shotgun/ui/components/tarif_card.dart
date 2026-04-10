import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class TarifCard extends HookWidget {
  const TarifCard({super.key, required this.onChanged});

  final void Function(List<Category> categories) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entries = useState<List<Map<String, TextEditingController>>>([
      _newEntry(),
    ]);

    void notify() => onChanged(
      entries.value
          .map(
            (e) => Category(
              id: '',
              name: e['label']!.text,
              price: int.tryParse(e['value']!.text) ?? 0,
              quota: int.tryParse(e['quota']!.text),
              requiredMembership: null,
            ),
          )
          .toList(),
    );

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorConstants.secondary.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        // ← ajout
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.shotgunTariffs,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              entries.value.length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextEntry(
                        label: l10n.shotgunTariffLabel(i + 1),
                        controller: entries.value[i]['label']!,
                        onChanged: (_) => notify(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 100,
                      child: TextEntry(
                        label: l10n.shotgunPriceLabel,
                        controller: entries.value[i]['value']!,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        isDouble: true,
                        onChanged: (_) => notify(),
                        validator: (value) {
                          if (value.isEmpty) return null;
                          final price = double.tryParse(
                            value.replaceAll(',', '.'),
                          );
                          if (price == null || price < 1) {
                            return l10n.shotgunMinPriceError;
                          }
                          return null;
                        },
                      ),
                    ),
                    if (entries.value.length > 1)
                      IconButton(
                        icon: HeroIcon(
                          HeroIcons.minusCircle,
                          size: 22,
                          color: ColorConstants.error,
                        ),
                        onPressed: () {
                          entries.value = [...entries.value]..removeAt(i);
                          notify();
                        },
                      )
                    else
                      const SizedBox(width: 48), // ← garde l'alignement
                  ],
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                entries.value = [...entries.value, _newEntry()];
                notify();
              },
              icon: const HeroIcon(HeroIcons.plus, size: 18),
              label: Text(l10n.shotgunAddTariff),
              style: TextButton.styleFrom(foregroundColor: ColorConstants.main),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, TextEditingController> _newEntry() => {
    'label': TextEditingController(),
    'value': TextEditingController(),
    'quota': TextEditingController(),
    'requiredMembership': TextEditingController(),
  };
}
