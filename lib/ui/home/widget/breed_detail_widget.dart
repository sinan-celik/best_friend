
import 'dart:io';

import 'package:best_friend/api/api_client.dart';
import 'package:best_friend/core/theme_utils.dart';
import 'package:best_friend/data/models/breed_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'modal_seperator.dart';
import 'modal_title.dart';
import 'random_image_widget.dart';

class BreedDetailWidget extends StatelessWidget {
  const BreedDetailWidget({
    super.key,
    required this.listOfBreeds,
    required this.index,
    required this.breedListMap,
    required this.name,
  });

  final List<BreedImage> listOfBreeds;
  final int index;
  final List<String> breedListMap;
  final String name;

  @override
  Widget build(BuildContext context) {
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
                  // Button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ThemeData().primaryColor,
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          var resp =
                              await ApiClient().getUrlByBreed(name);

                          // ignore: use_build_context_synchronously
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return RandomImageWidget(resp: resp);
                            },
                          );
                        },
                        child: const Text(
                          'Generate',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
  }
}





