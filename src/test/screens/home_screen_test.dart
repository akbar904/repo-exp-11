
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays initial animal state as Cat with clock icon', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => animalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon when state changes', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([Animal(name: 'Cat', icon: Icons.access_time), Animal(name: 'Dog', icon: Icons.person)]),
				initialState: Animal(name: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => animalCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles animal state when text is tapped', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));
			when(() => animalCubit.toggleAnimal()).thenAnswer((_) async {
				animalCubit.emit(Animal(name: 'Dog', icon: Icons.person));
			});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => animalCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			verify(() => animalCubit.toggleAnimal()).called(1);
		});
	});
}
