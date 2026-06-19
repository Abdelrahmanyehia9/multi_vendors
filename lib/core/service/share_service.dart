import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  const ShareService._() ;
  static final ShareService instance = const ShareService._();
  Future<void> shareProduct({required ProductModel product}) async {
    final XFile? thumbnail =product.thumbnail ==null ? null :  await _downloadThumbnail(product.thumbnail!);
    final uri = Uri(
      scheme: 'myapp',
      host: 'avera',
      path: '/product',
      queryParameters: {'id': product.id.toString()},
    ).toString();
    final text = '''
*${product.name.localized}*

Check this product,  I found on ${AppConstants.appName.tr()}.

Open it here:
$uri
''';
    await SharePlus.instance.share(
      ShareParams(
        previewThumbnail: thumbnail,
        files: [
          ?thumbnail
        ],
        title: product.name.localized,
        text:text
      ),
    );
  }

  Future<XFile?> _downloadThumbnail(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) return null;
      return XFile.fromData(
        response.bodyBytes,
        name: imageUrl.split('/').last,
        mimeType: 'image/jpeg',
      );
    } catch (e) {
      return null;
    }
  }
}
