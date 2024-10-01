
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/login_form.dart';
import '../cubits/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							LoginForm(),
							SizedBox(height: 20),
							ElevatedButton(
								onPressed: () {
									final authCubit = context.read<AuthCubit>();
									authCubit.login('email@example.com', 'password');
								},
								child: Text('Login'),
							),
						],
					),
				),
			),
		);
	}
}
