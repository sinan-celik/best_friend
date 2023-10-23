import 'dart:io';

import 'package:best_friend/bloc/home/bloc/home_bloc.dart';

import 'package:best_friend/data/models/breed_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'breed_detail_widget.dart';

class GridElement extends StatelessWidget {
  const GridElement({
    super.key,
    required this.listOfBreeds,
    required this.index,
  });

  final List<BreedImage> listOfBreeds;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var name = listOfBreeds[index].name;
        final state = BlocProvider.of<HomeBloc>(context).state;
        List<String> breedListMap = [];
        if (state is DataLoadedState) {
          breedListMap = state.allBreeds.message!.entries
              .where((element) => element.key == name)
              .first
              .value;
        }
        if (state is DataFilteredState) {
          breedListMap = state.allBreeds.message!.entries
              .where((element) => element.key == name)
              .first
              .value;
        }

        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return BreedDetailWidget(
                listOfBreeds: listOfBreeds,
                index: index,
                breedListMap: breedListMap,
                name: name);
          },
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: File(listOfBreeds[index].temporaryPath).existsSync()
              ? DecorationImage(
                  image:
                      Image.file(File(listOfBreeds[index].temporaryPath)).image,
                  fit: BoxFit.cover)
              : null,
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(children: [
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              listOfBreeds[index].name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ]),
      ),
    );
  }
}
