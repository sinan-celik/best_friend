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
    TextEditingController controller = TextEditingController();
    FocusNode node = FocusNode();
    return Scaffold(
      backgroundColor: ThemeUtils.white,
      resizeToAvoidBottomInset: false,
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

          List<BreedImage> listOfBreeds = [];
          if (state is DataLoadedState) {
            listOfBreeds = state.props[0] as List<BreedImage>;
            // List<BreedImage> listOfBreedsSearched = state.props[0] as List<BreedImage>;
          }

          if (state is DataFilteredState) {
            listOfBreeds = state.props[0] as List<BreedImage>;
      
          }
          return Stack(
            children: [
              listOfBreeds.isEmpty
                  ? const EmptyScreen()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 200),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
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
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: node.hasFocus
                    ? MediaQuery.of(context).viewInsets.bottom
                    : 114,
                child: Padding(
                  padding: node.hasFocus
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(left: 16, right: 16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width -
                        (node.hasFocus ? 0 : 32),
                    height: node.hasFocus ? 110 : 64,
                    child: TextField(
                      onChanged: (value) {
                        BlocProvider.of<HomeBloc>(context)
                            .add(DataFilteredEvent(value: value));
                      },
                      maxLines: null,
                      expands: true,
                      controller: controller,
                      focusNode: node,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: node.hasFocus
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))
                                : BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: ThemeUtils.borderGrey,
                              width: node.hasFocus ? 0 : 2,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: node.hasFocus
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))
                                : BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: ThemeUtils.borderGrey,
                              width: node.hasFocus ? 0 : 2,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: node.hasFocus
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))
                                : BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: ThemeUtils.borderGrey,
                              width: node.hasFocus ? 0 : 2,
                            )),
                        filled: true,
                        hintStyle: TextStyle(
                            color: ThemeUtils.borderGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        hintText: "Search",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
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
                                ).then((value) {
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
        },
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'No results found',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Try searching with another word',
          style: TextStyle(fontSize: 18, color: ThemeUtils.labelLight),
        )
      ],
    ));
  }
}
