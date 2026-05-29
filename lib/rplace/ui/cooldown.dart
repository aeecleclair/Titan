import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CooldownWidget extends HookWidget {
  final dynamic userinfo;
  final Duration cooldown;

  const CooldownWidget({
    super.key,
    required this.userinfo,
    required this.cooldown,
  });

  @override
  Widget build(BuildContext context) {
    Duration computeRemaining() =>
        cooldown - DateTime.now().difference(userinfo.lastplaced);

    final remainingTime = useState<Duration>(computeRemaining());

    useEffect(() {
      final timer = Stream.periodic(const Duration(seconds: 1)).listen((_) {
        final remaining = computeRemaining();
        if (remaining <= Duration.zero) {
          remainingTime.value = Duration.zero;
          if (context.mounted) Navigator.of(context).pop();
        } else {
          remainingTime.value = remaining;
        }
      });

      return timer.cancel;
    }, [userinfo.lastplaced]);

    return SizedBox(
      height: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Prochain placement possible dans :",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              _formatCountdown(remainingTime.value),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.red,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCountdown(Duration duration) {
    if (duration.inSeconds <= 0) {
      return "00:00:00";
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else {
      return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
  }
}
