import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';

void main() {
  group('Testing AppException class', () {
    test('Should return an AppException', () {
      final AppException exception = AppException(
        ErrorType.tokenExpire,
        "Token Expired",
      );
      expect(exception, isA<AppException>());
      expect(exception.type, ErrorType.tokenExpire);
      expect(exception.message, "Token Expired");
    });

    test('Should return a string', () {
      final AppException exception = AppException(
        ErrorType.tokenExpire,
        "Token Expired",
      );
      expect(exception.toString(), "tokenExpire : Token Expired");
    });
    test('Should return an ErrorType', () {
      expect(ErrorType.tokenExpire, isA<ErrorType>());
      expect(ErrorType.notFound, isA<ErrorType>());
      expect(ErrorType.invalidData, isA<ErrorType>());
    });
  });

  group('Testing capitalize function', () {
    test('Should return a string', () {
      expect(capitalize("test"), isA<String>());
    });

    test('Should return a capitalized string', () {
      expect(capitalize("test"), "Test");
      expect(capitalize("TEST"), "Test");
    });

    test('Should return an empty string', () {
      expect(capitalize(""), "");
    });

    test('Should capitalize only the first word', () {
      expect(capitalize("test a"), "Test a");
    });
  });

  group('Testing capitaliseAll function', () {
    test('Should return a string', () {
      expect(capitaliseAll("test"), isA<String>());
    });

    test('Should return a capitalized string', () {
      expect(capitaliseAll("test"), "Test");
      expect(capitaliseAll("TEST"), "Test");
      expect(capitaliseAll("test a"), "Test A");
      expect(capitaliseAll("test-a"), "Test-A");
      expect(capitaliseAll("test_a"), "Test_A");
    });

    test('Should return an empty string', () {
      expect(capitaliseAll(""), "");
    });
  });

  group('Testing processDate function', () {
    test('Should return a string', () {
      final date = DateTime.parse("2021-01-01");
      expect(processDate(date), isA<String>());
      expect(processDate(date), "01/01/2021");
    });
  });

  group('Testing processDateWithHour function', () {
    test('Should return a string', () {
      final date = DateTime.parse("2021-01-01 12:00:00");
      expect(processDateWithHour(date), isA<String>());
      expect(processDateWithHour(date), "01/01/2021 12:00");
    });
  });

  group('Testing processDatePrint function', () {
    test('Should return a string', () {
      const date = "2021-1-1";
      expect(processDatePrint(""), "");
      expect(processDatePrint(date), isA<String>());
      expect(processDatePrint(date), "01/01/2021");
    });
  });

  group('Testing processDateBack function', () {
    test('Should return a string', () {
      const date = "01/01/2021";
      const dateWithHour = "01/01/2021 12:00";
      expect(processDateBack(""), "");
      expect(processDateBack(dateWithHour), isA<String>());
      expect(processDateBack(date), isA<String>());
      expect(processDateBack(dateWithHour), "2021-01-01 12:00");
      expect(processDateBack(date), "2021-01-01");
    });
  });

  group('Testing processDateBackWithHour function', () {
    test('Should return a string', () {
      const date = "01/01/2021";
      const dateWithHour = "01/01/2021 12:00";
      expect(processDateBackWithHour(""), "");
      expect(processDateBackWithHour(dateWithHour), isA<String>());
      expect(processDateBackWithHour(date), isA<String>());
      expect(processDateBackWithHour(dateWithHour), "2021-01-01 12:00");
      expect(processDateBackWithHour(date), "2021-01-01");
    });
  });

  test('Testing getDateInRecurrence', () {
    const recurrenceRule =
        "FREQ=WEEKLY;BYDAY=MO;WKST=MO;INTERVAL=1;UNTIL=20210115T235959Z";
    const recurrenceRule2 = "";
    final date = DateTime.parse("2021-01-01T00:00:00.000Z");
    expect(getDateInRecurrence(recurrenceRule, date), [
      DateTime.parse("2021-01-04T00:00:00.000"),
      DateTime.parse("2021-01-11T00:00:00.000"),
    ]);
    expect(getDateInRecurrence(recurrenceRule2, date), []);
  });

  test('Testing normalzedDate', () {
    final date = DateTime.parse("2021-01-01T00:00:00.000Z");
    final date2 = DateTime.parse("2021-01-01T01:00:00.000Z");
    expect(normalizedDate(date), DateTime.parse("2021-01-01T00:00:00.000"));
    expect(normalizedDate(date2), DateTime.parse("2021-01-01T00:00:00.000"));
  });

  group('Testing processDateToAPI', () {
    test('Should return a string', () {
      final date = DateTime.parse("2021-01-01");
      expect(processDateToAPI(date), isA<String>());
      expect(processDateToAPI(date), date.toUtc().toIso8601String());
    });
  });

  group('displayToast', () {
    testWidgets(
      'displays a toast message with the correct duration when the type is "msg"',
      (WidgetTester tester) async {
        // Arrange
        const type = TypeMsg.msg;
        const text = 'Success!';
        final scaffoldKey = GlobalKey<ScaffoldState>();

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              key: scaffoldKey,
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => displayToast(context, type, text),
                  child: const Text('Show Toast'),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(
          find.text(text),
          findsOneWidget,
        ); // Check that the toast message is still visible
        await tester.pump(const Duration(milliseconds: 2000));
        expect(
          find.text(text),
          findsNothing,
        ); // Check that the toast message has disappeared
      },
    );

    testWidgets(
      'displays a toast message with the correct duration when the type is "error"',
      (WidgetTester tester) async {
        // Arrange
        const type = TypeMsg.error;
        const text = 'Error!';
        final scaffoldKey = GlobalKey<ScaffoldState>();

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              key: scaffoldKey,
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => displayToast(context, type, text),
                  child: const Text('Show Toast'),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(
          find.text(text),
          findsOneWidget,
        ); // Check that the toast message is still visible
        await tester.pump(const Duration(milliseconds: 3000));
        expect(
          find.text(text),
          findsNothing,
        ); // Check that the toast message has disappeared
      },
    );

    // testWidgets(
    //     'displays a toast message with the correct background color when the type is "msg"',
    //     (WidgetTester tester) async {
    //   // Arrange
    //   const type = TypeMsg.msg;
    //   const text = 'Success!';
    //   final scaffoldKey = GlobalKey<ScaffoldState>();

    //   // Act
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       key: scaffoldKey,
    //       body: Builder(
    //         builder: (context) => ElevatedButton(
    //           onPressed: () => displayToast(context, type, text),
    //           child: const Text('Show Toast'),
    //         ),
    //       ),
    //     ),
    //   ));
    //   await tester.tap(find.byType(ElevatedButton));
    //   await tester.pump(const Duration(milliseconds: 500));

    //   // Assert
    //   final container =
    //       find.byType(Ink).evaluate().first.widget as Ink;
    //   final decoration = container.decoration as BoxDecoration;
    //   expect(
    //       decoration.gradient!.colors,
    //        [
    //     ColorConstants.gradient1,
    //     ColorConstants.gradient2
    //   ]); // Check that the toast message has the correct background color
    //   await tester.pump(const Duration(milliseconds: 3000));
    // });

    // testWidgets(
    //     'displays a toast message with the correct background color when the type is "error"',
    //     (WidgetTester tester) async {
    //   // Arrange
    //   const type = TypeMsg.error;
    //   const text = 'Error!';
    //   final scaffoldKey = GlobalKey<ScaffoldState>();

    //   // Act
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       key: scaffoldKey,
    //       body: Builder(
    //         builder: (context) => ElevatedButton(
    //           onPressed: () => displayToast(context, type, text),
    //           child: const Text('Show Toast'),
    //         ),
    //       ),
    //     ),
    //   ));
    //   await tester.tap(find.byType(ElevatedButton));
    //   await tester.pump(const Duration(milliseconds: 500));

    //   // Assert
    //   final container =
    //       find.byType(Ink).evaluate().first.widget as Ink;
    //   final decoration = container.decoration as BoxDecoration;
    //   expect(
    //       decoration.gradient!.colors,
    //       [
    //     ColorConstants.background2,
    //     Colors.black
    //   ]); // Check that the toast message has the correct background color
    //   await tester.pump(const Duration(milliseconds: 3000));
    // });

    // testWidgets('displays a toast message with the correct font size',
    //     (WidgetTester tester) async {
    //   // Arrange
    //   const type = TypeMsg.msg;
    //   const text = 'Success!';
    //   final scaffoldKey = GlobalKey<ScaffoldState>();

    //   // Act
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(
    //       key: scaffoldKey,
    //       body: Builder(
    //         builder: (context) => ElevatedButton(
    //           onPressed: () => displayToast(context, type, text),
    //           child: const Text('Show Toast'),
    //         ),
    //       ),
    //     ),
    //   ));
    //   await tester.tap(find.byType(ElevatedButton));
    //   await tester.pump(const Duration(milliseconds: 500));

    //   // Assert
    //   final textWidget = find.text(text).evaluate().first.widget as Text;
    //   expect(textWidget.style!.fontSize,
    //       20.0); // Check that the toast message has the correct font size
    //   await tester.pump(const Duration(milliseconds: 3000));
    // });
  });
}
