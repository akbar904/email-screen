
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/widgets/login_form.dart';

// Mock dependencies
class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		testWidgets('renders email and password TextFields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
			expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
		});

		testWidgets('renders login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LoginForm(),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});
	});

	group('LoginForm Cubit Interaction Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('calls login on AuthCubit when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider.value(
					value: authCubit,
					child: MaterialApp(
						home: Scaffold(
							body: LoginForm(),
						),
					),
				),
			);

			final emailFinder = find.widgetWithText(TextField, 'Email');
			final passwordFinder = find.widgetWithText(TextField, 'Password');
			final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');

			await tester.enterText(emailFinder, 'test@example.com');
			await tester.enterText(passwordFinder, 'password');
			await tester.tap(loginButtonFinder);

			verify(() => authCubit.login('test@example.com', 'password')).called(1);
		});
	});
}
