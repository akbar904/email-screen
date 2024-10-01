
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/screens/login_screen.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('displays login form', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginScreen(),
          ),
        ),
      );

      expect(find.byType(LoginForm), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('login button is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginScreen(),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });
  });

  group('LoginScreen Cubit Tests', () {
    late MockAuthCubit mockAuthCubit;

    setUp(() {
      mockAuthCubit = MockAuthCubit();
    });

    blocTest<MockAuthCubit, AuthState>(
      'emits Authenticated state when login is successful',
      build: () => mockAuthCubit,
      act: (cubit) => cubit.login('email@example.com', 'password'),
      expect: () => [Authenticated()],
    );

    blocTest<MockAuthCubit, AuthState>(
      'emits Unauthenticated state when login fails',
      build: () => mockAuthCubit,
      act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
      expect: () => [Unauthenticated()],
    );
  });
}
