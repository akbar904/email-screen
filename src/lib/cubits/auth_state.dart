
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the different states for authentication
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}
