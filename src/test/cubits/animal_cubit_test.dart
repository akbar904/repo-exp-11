
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_package_name/cubits/animal_cubit.dart';
import 'package:your_package_name/models/animal_model.dart';

// Define mock class if needed
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;
		final initialAnimal = Animal(name: 'Cat', icon: Icons.access_time);

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Cat with clock icon', () {
			expect(animalCubit.state.name, initialAnimal.name);
			expect(animalCubit.state.icon, initialAnimal.icon);
		});

		blocTest<AnimalCubit, Animal>(
			'emits Dog with person icon when toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: 'Dog', icon: Icons.person)],
		);

		blocTest<AnimalCubit, Animal>(
			'emits Cat with clock icon when toggleAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal();
				cubit.toggleAnimal();
			},
			expect: () => [
				Animal(name: 'Dog', icon: Icons.person),
				Animal(name: 'Cat', icon: Icons.access_time)
			],
		);
	});
}
