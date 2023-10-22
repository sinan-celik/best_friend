
import 'package:best_friend/bloc/home/bloc/home_bloc.dart';
import 'package:best_friend/core/theme_utils.dart';
import 'package:best_friend/data/models/breed_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'grid_element.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.white,
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text('Best Friend'),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is FirstLoadState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DataLoadedState) {
            var listOfBreeds = state.props[0] as List<BreedImage>;
// Image.file(File(listOfBreeds.first.temporaryPath)),
            return GridView.builder(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    // childAspectRatio: 3 / 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemCount: listOfBreeds.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GridElement(listOfBreeds: listOfBreeds, index: index);
                });
          }
          return Placeholder();
        },
      ),
    );
  }
}
