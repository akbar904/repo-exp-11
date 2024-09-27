
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/animal_cubit.dart';
import 'package:com.example.flutter_cubit_app/models/animal_model.dart';

class AnimalWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, Animal>(
			builder: (context, animal) {
				return GestureDetector(
					onTap: () {
						context.read<AnimalCubit>().toggleAnimal();
					},
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(animal.name),
							Icon(animal.icon),
						],
					),
				);
			},
		);
	}
}
