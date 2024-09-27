
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/lib/main.dart';
import 'package:com.example.flutter_cubit_app/lib/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('Main App Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('Displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MyApp(),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Displays Dog with person icon when clicked', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([
					Animal(name: 'Cat', icon: Icons.access_time),
					Animal(name: 'Dog', icon: Icons.person),
				]),
			);

			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MyApp(),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
