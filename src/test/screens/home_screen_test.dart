
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/screens/home_screen.dart';
import 'package:simple_app/cubits/auth_cubit.dart';
import 'package:simple_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});

		testWidgets('renders Logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('calls logout when Logout button is tapped', (WidgetTester tester) async {
			await tester.pumpWidget(
				BlocProvider<AuthCubit>.value(
					value: mockAuthCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Logout'));
			await tester.pump();

			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
