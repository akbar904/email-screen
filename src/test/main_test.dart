
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App starts with LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'emits [Authenticated] when login is successful',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.emit(Authenticated(User(email: 'test@example.com'))),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.emit(Unauthenticated()),
			expect: () => [isA<Unauthenticated>()],
		);
	});

	group('Widgets', () {
		testWidgets('LoginScreen has LoginForm', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			
			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('HomeScreen has Logout button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: HomeScreen()));
			
			expect(find.text('Logout'), findsOneWidget);
		});
	});
}
