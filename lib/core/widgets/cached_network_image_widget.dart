import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Color? color ;
  final BlendMode? colorBlendMode ;
  const CachedNetworkImageWidget(this.imageUrl, {super.key , this.color ,this.colorBlendMode});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      color: color,
      colorBlendMode: colorBlendMode,
      memCacheWidth: 600
    );
      // placeholder: (context, url) => const Center(
      //       child: SpinKitCubeGrid(color: ColorHelper.whiteColor),
      //     ),
    //   errorWidget:
    //       (context, url, error) =>  SvgPicture.asset('assets/images/no_photo.svg', fit: BoxFit.cover,)  ,
    //   fit: BoxFit.cover,
    // );
  }
}
