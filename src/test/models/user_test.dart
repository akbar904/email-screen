
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lib/models/user.dart';

void main() {
	group('User Model', () {
		test('User should be instantiated with correct email', () {
			final user = User(email: 'test@example.com');
			expect(user.email, 'test@example.com');
		});
		
		test('User should serialize to JSON correctly', () {
			final user = User(email: 'test@example.com');
			final json = user.toJson();
			expect(json, {'email': 'test@example.com'});
		});
		
		test('User should deserialize from JSON correctly', () {
			final json = {'email': 'test@example.com'};
			final user = User.fromJson(json);
			expect(user.email, 'test@example.com');
		});
	});
}
