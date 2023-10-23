import 'package:best_friend/bloc/home/bloc/home_bloc.dart';
import 'package:best_friend/core/theme_utils.dart';
import 'package:best_friend/data/models/breed_image.dart';
import 'package:best_friend/ui/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'widget/grid_element.dart';

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
            return Stack(
              children: [
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      // childAspectRatio: 3 / 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: listOfBreeds.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GridElement(
                        listOfBreeds: listOfBreeds, index: index);
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 98,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SvgPicture.asset(
                            'assets/svg/tab.svg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/svg/home.svg',
                                ),
                                onTap: () {
                                  context.go('/');
                                },
                              ),
                              Container(
                                width: 2,
                                height: 24,
                                color: ThemeUtils.veticalSeperator,
                              ),
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/svg/settings.svg',
                                ),
                                onTap: () {
                                  SystemChrome.setEnabledSystemUIMode(
                                      SystemUiMode.manual,
                                      overlays: [
                                        SystemUiOverlay.bottom
                                      ]); // to only hide the status bar
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SettingsScreen();
                                    },
                                  ).then((value){
                                     SystemChrome.setEnabledSystemUIMode(
                                      SystemUiMode.manual,
                                      overlays: [
                                        SystemUiOverlay.top,
                                        SystemUiOverlay.bottom
                                      ]);
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return Placeholder();
        },
      ),
    );
  }
}
