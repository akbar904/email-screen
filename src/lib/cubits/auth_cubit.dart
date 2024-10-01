
import 'package:bloc/bloc.dart';
import 'package:your_package_name/cubits/auth_state.dart';
import 'package:your_package_name/models/user.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) {
		// For simplicity, we assume the login is always successful
		// In a real-world scenario, you would have authentication logic here
		final user = User(email: email);
		emit(Authenticated(user));
	}

	void logout() {
		emit(Unauthenticated());
	}
}
