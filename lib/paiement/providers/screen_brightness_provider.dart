import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen/flutter_screen.dart';

final screenBrightnessProvider =
    StateNotifierProvider<ScreenBrightnessProvider, double>((ref) {
  return ScreenBrightnessProvider();
});

class ScreenBrightnessProvider extends StateNotifier<double> {
  double screenBrightness = 0.0;
  ScreenBrightnessProvider() : super(0.0);

  void getScreenBrightness() async {
    state = screenBrightness = await FlutterScreen.brightness;
  }

  void setScreenBrightnessValue(double i) {
    state = i;
  }

  void resetScreenBrightness() {
    state = screenBrightness;
  }

  void setScreenBrightness() async {
    await FlutterScreen.setBrightness(state);
  }
}
