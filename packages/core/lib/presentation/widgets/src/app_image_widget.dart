import 'package:flutter/material.dart';

import '../../../core.dart';

class AppImageWidget extends StatelessWidget {
  final String? imageUrl;
  final bool isProfile;
  final BoxFit? boxFit;

  const AppImageWidget(
      {super.key, this.imageUrl, required this.isProfile, this.boxFit});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return const Icon(
        Icons.person,
        color: AppColors.aquaBlue,
      );
    } else {
      // if (imageUrl!.startsWith(StringHelper.storagePath)) {
      //   return Image.network(
      //     APIUrl.apiUrl + imageUrl!,
      //     fit: BoxFit.cover,
      //     width: isProfile ? double.infinity : null,
      //     height: isProfile ? double.infinity : null,
      //   );
      // } else if (imageUrl!.startsWith(StringHelper.avatarPath)) {
      //   if (imageUrl!.endsWith('.svg')) {
      //     return SvgPicture.network(
      //       imageUrl!,
      //       fit: BoxFit.cover,
      //       width: isProfile ? double.infinity : null,
      //       height: isProfile ? double.infinity : null,
      //     );
      //   }
      //   return Image.network(
      //     imageUrl!,
      //     fit: BoxFit.cover,
      //     width: isProfile ? double.infinity : null,
      //     height: isProfile ? double.infinity : null,
      //   );
      // }
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: isProfile ? double.infinity : null,
        height: isProfile ? double.infinity : null,
      );
    }
  }
}

// String imageUrlChecker(String imageUrl) {
//   if (imageUrl.startsWith(StringHelper.storagePath)) {
//     return APIUrl.apiUrl + imageUrl;
//   } else if (imageUrl.startsWith(StringHelper.avatarPath)) {
//     if (imageUrl.endsWith('.svg')) {
//       return imageUrl;
//     }
//     return imageUrl;
//   }
//   return imageUrl;
// }
