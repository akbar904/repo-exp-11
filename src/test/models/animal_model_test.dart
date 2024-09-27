
// test/models/animal_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_cubit_app/models/animal_model.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal Model should have correct initial values', () {
			const animal = Animal(name: 'Cat', icon: Icons.access_time);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.access_time);
		});

		test('Animal Model should be serializable to JSON', () {
			const animal = Animal(name: 'Dog', icon: Icons.person);

			final json = animal.toJson();
			expect(json, {
				'name': 'Dog',
				'icon': Icons.person.codePoint,
			});
		});

		test('Animal Model should be deserializable from JSON', () {
			final json = {
				'name': 'Dog',
				'icon': Icons.person.codePoint,
			};

			final animal = Animal.fromJson(json);

			expect(animal.name, 'Dog');
			expect(animal.icon, Icons.person);
		});
	});
}
