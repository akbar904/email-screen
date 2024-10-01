
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_package_name/cubits/auth_cubit.dart';
import 'package:your_package_name/cubits/auth_state.dart';
import 'package:your_package_name/models/user.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'login emits [AuthInitial, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login("test@example.com", "password"),
			expect: () => [
				AuthInitial(),
				Authenticated(User(email: "test@example.com")),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'logout emits [Authenticated, Unauthenticated]',
			build: () => authCubit,
			seed: () => Authenticated(User(email: "test@example.com")),
			act: (cubit) => cubit.logout(),
			expect: () => [
				Unauthenticated(),
			],
		);
	});
}
