import 'dart:io';

import 'package:best_friend/bloc/home/bloc/home_bloc.dart';
import 'package:best_friend/core/theme_utils.dart';
import 'package:best_friend/data/models/breed_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        List<String> breedListMap;
        if (state is DataLoadedState) {
          breedListMap = state.allBreeds.message!.entries
              .where((element) => element.key == name)
              .first
              .value;

          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 91, 16, 91),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.file(
                                File(listOfBreeds[index].temporaryPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const ModalTitle(title: 'Breed'),
                            const ModalSepereator(),
                            Text(
                              listOfBreeds[index].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeUtils.modalLabelLight),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            const ModalTitle(title: 'Sub Breed'),
                            const ModalSepereator(),
                            ...breedListMap.map(
                              (e) => Wrap(
                                children: [
                                  Text(
                                    e,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeUtils.modalLabelLight,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: ThemeUtils.white,
                                    shape: BoxShape.circle),
                                child: Image.asset('assets/icon/X.png')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
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

class ModalSepereator extends StatelessWidget {
  const ModalSepereator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      child: Container(
        height: 2,
        width: double.maxFinite,
        color: ThemeUtils.modalSeperator,
      ),
    );
  }
}

class ModalTitle extends StatelessWidget {
  const ModalTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ThemeUtils.modalTitleColor),
    );
  }
}
