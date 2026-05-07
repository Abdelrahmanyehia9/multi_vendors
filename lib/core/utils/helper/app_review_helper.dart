import 'package:in_app_review/in_app_review.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';

class AppReviewHelper {
  const AppReviewHelper._();
static final InAppReview _appReview = InAppReview.instance ;
static AppReviewHelper instance = const AppReviewHelper._();

Future<void>openStoreListener()async{
 await _appReview.openStoreListing(
     appStoreId: AppConstants.appStoreId);
 return ;
}

Future<void>requestReview()async{
  final bool isAvailable =await _appReview.isAvailable() ;
  if(isAvailable){
    await _appReview.requestReview();
  }
  return ;
}

}