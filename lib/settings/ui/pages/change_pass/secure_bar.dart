import 'package:flutter/material.dart';
import 'package:zxcvbn/zxcvbn.dart';

// Source :  https://github.com/JinHoSo/flutter-password-strength/blob/master/lib/flutter_password_strength.dart

class FlutterPasswordStrength extends StatefulWidget {
  final String? password;

  //Strength bar width
  final double? width;

  //Strength bar height
  final double height;

  //Strength bar colors are changed depending on strength
  final Animatable<Color?> strengthColors;

  //Strength bar background color
  final Color backgroundColor;

  //Strength bar radius
  final double radius;

  //Strength bar animation duration
  final Duration? duration;

  //Strength callback
  final void Function(double strength)? strengthCallback;

  const FlutterPasswordStrength({
    super.key,
    required this.password,
    this.width,
    this.height = 5,
    required this.strengthColors,
    this.backgroundColor = Colors.grey,
    this.radius = 0,
    this.duration,
    this.strengthCallback,
  });

  /*
    default strength bar colors
    This is approximate values
    0.0 ~ 0.25 : red
    0.26 ~ 0.5 : yellow
    0.51 ~ 0.75 : blue
    0.76 ~ 1 : green
  */
  Animatable<Color?> get _strengthColors => strengthColors;

  //default duration is 300 milliseconds
  Duration? get _duration => duration ?? const Duration(milliseconds: 300);

  @override
  FlutterPasswordStrengthState createState() => FlutterPasswordStrengthState();
}

class FlutterPasswordStrengthState extends State<FlutterPasswordStrength>
    with SingleTickerProviderStateMixin {
  //Animation controller for strength bar
  late AnimationController _animationController;

  //Animation for strength bar sharp
  late Animation<double> _strengthBarAnimation;

  //Strength bar colors
  late Animatable<Color?> _strengthBarColors;

  //Strength bar color from the list of strength bar colors
  late Color _strengthBarColor;

  //Strength bar color
  late Color _backgroundColor;

  //Strength bar width
  double? _width;

  //Strength bar height
  late double _height;

  //Strength bar radius, default is 0
  double _radius = 0;

  //Strength callback
  void Function(double strength)? _strengthCallback;

  //_begin is used in _strengthBarAnimation
  double _begin = 0;

  //_end is used in _strengthBarAnimation
  double _end = 0;

  //calculated strength from password
  double _passwordStrength = 0;

  // zxcvbn password strength estimator
  Zxcvbn zxcvbn = Zxcvbn();

  @override
  void initState() {
    super.initState();

    //initialize
    _animationController = AnimationController(
      duration: widget._duration,
      vsync: this,
    );
    _strengthBarAnimation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(_animationController);
    _strengthBarColors = widget._strengthColors;
    _strengthBarColor =
        _strengthBarColors.evaluate(
          AlwaysStoppedAnimation(_passwordStrength),
        ) ??
        Colors.transparent;

    _backgroundColor = widget.backgroundColor;

    _width = widget.width;
    _height = widget.height;
    _radius = widget.radius;
    _strengthCallback = widget.strengthCallback;

    //start animation
    _animationController.forward();
  }

  void animate() {
    //calculate strength
    if (widget.password == null || widget.password!.isEmpty) {
      _passwordStrength = 0;
    } else {
      _passwordStrength =
          (zxcvbn.evaluate(widget.password ?? "").score ?? 0) / 4;
    }

    _begin = _end;
    _end = _passwordStrength * 100;

    _strengthBarAnimation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(_animationController);
    _strengthBarColor =
        _strengthBarColors.evaluate(
          AlwaysStoppedAnimation(_passwordStrength),
        ) ??
        Colors.transparent;

    _animationController.forward(from: 0.0);

    if (_strengthCallback != null) {
      _strengthCallback!(_passwordStrength);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(FlutterPasswordStrength oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.password != widget.password) {
      animate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StrengthBarContainer(
      barColor: _strengthBarColor,
      backgroundColor: _backgroundColor,
      width: _width,
      height: _height,
      radius: _radius,
      animation: _strengthBarAnimation,
    );
  }
}

class StrengthBarContainer extends AnimatedWidget {
  final Color barColor;
  final Color backgroundColor;
  final double? width;
  final double height;
  final double radius;

  const StrengthBarContainer({
    super.key,
    required this.barColor,
    required this.backgroundColor,
    this.width,
    required this.height,
    required this.radius,
    required Animation animation,
  }) : super(listenable: animation);

  Animation<double> get _percent {
    return listenable as Animation<double>;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return CustomPaint(
          size: Size(width ?? constraints.maxWidth, height),
          painter: StrengthBarBackground(
            backgroundColor: backgroundColor,
            backgroundRadius: radius,
          ),
          foregroundPainter: StrengthBar(
            barColor: barColor,
            barRadius: radius,
            percent: _percent.value,
          ),
        );
      },
    );
  }
}

class StrengthBar extends CustomPainter {
  Color barColor;
  double barRadius;
  double percent;

  StrengthBar({
    required this.barColor,
    required this.barRadius,
    required this.percent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    drawBar(canvas, size);
  }

  void drawBar(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    double left = 0;
    double top = 0;
    double right = size.width / 100 * percent;
    double bottom = size.height;

    //the bar width needs to be bigger than radius width
    if (barRadius != 0 && right > 0 && barRadius * 2 > right) {
      right = barRadius * 2;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left, top, right, bottom),
        Radius.circular(barRadius),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(StrengthBar oldDelegate) {
    return oldDelegate.percent != percent;
  }
}

class StrengthBarBackground extends CustomPainter {
  Color backgroundColor;
  double? backgroundRadius;

  StrengthBarBackground({required this.backgroundColor, this.backgroundRadius});

  @override
  void paint(Canvas canvas, Size size) {
    drawBarBackground(canvas, size);
  }

  void drawBarBackground(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    double left = 0;
    double top = 0;
    double right = size.width;
    double bottom = size.height;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left, top, right, bottom),
        Radius.circular(backgroundRadius ?? 0),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(StrengthBarBackground oldDelegate) {
    return true;
  }
}
