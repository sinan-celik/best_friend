import 'package:best_friend/api/breed_url_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RandomImageWidget extends StatelessWidget {
  const RandomImageWidget({
    super.key,
    required this.resp,
  });

  final BreedUrlResponse? resp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              resp!.message!,
              width: 256,
              height: 256,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              padding:
                  const EdgeInsets.all(8),
              width: 32,
              height: 32,
              color: Colors.white,
              child: SvgPicture.asset(
                  'assets/svg/X.svg'),
            ),
          )
        ],
      ),
    );
  }
}
