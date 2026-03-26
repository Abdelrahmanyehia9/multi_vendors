import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/authentication/data/repository/auth_repository.dart';
import 'package:multi_vendor/features/main/layout.dart';
import '../../features/authentication/logic/login_cubit.dart';
import '../../features/authentication/logic/otp_confirm_cubit.dart';
import '../../features/authentication/logic/sign_up_cubit.dart';
import '../../features/authentication/view/login_screen.dart';
import '../../features/authentication/view/otp_confirm_screen.dart';
import '../../features/authentication/view/sign_up_screen.dart';
import '../../features/intro/view/on_boarding_screen.dart';
import '../../features/intro/view/splash_screen.dart';
import '../../features/main/favorite/view/favorite_screen.dart';
import '../../features/main/profile/data/repository/profile_repository.dart';
import '../../features/main/profile/logic/edit_password_cubit.dart';
import '../../features/main/profile/logic/edit_profile_cubit.dart';
import '../../features/main/profile/view/change_password_screen.dart';
import '../../features/main/profile/view/edit_profile_screen.dart';
import '../../features/news/view/all_news_screen.dart';
import '../../features/news/view/news_item_details.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/shop/cart/view/apply_promo_voucher.dart';
import '../../features/shop/cart/view/cart_screen.dart';
import '../../features/shop/checkout/view/checkout_screen.dart';
import '../../features/shop/checkout/view/order_success.dart';
import '../../features/shop/history/view/order_details_screen.dart';
import '../../features/shop/history/view/rate_order_screen.dart';
import '../../features/shop/history/view/rate_product_screen.dart';
import '../../features/shop/product/view/all_product_tags_screen.dart';
import '../../features/shop/product/view/all_products_screen.dart';
import '../../features/vendors/view/all_vendors_screen.dart';
import '../../features/shop/product/view/product_details_screen.dart';
import '../../features/vendors/view/vendor_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return _page(const SplashScreen(), name: Routes.splash);
       case Routes.onBoarding:
        return _page(const OnBoardingScreen(), name: Routes.onBoarding);
      case Routes.loginScreen:
        return _page(MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginCubit(getIt.get<AuthRepository>()),
              ),
            ],
            child: const LoginScreen()), name: Routes.loginScreen);
      case Routes.otp:
        return _page( BlocProvider(
          create: (context) => OtpConfirmCubit(getIt.get<AuthRepository>()),
          child: OtpConfirmScreen(
            phoneNumber: settings.arguments as String,
          ),
        ), name: Routes.otp);
      case Routes.signup:
        return _page(BlocProvider(
            create: (context) => SignupCubit(getIt.get<AuthRepository>()),
            child: const SignUpScreen()), name: Routes.signup);
      case Routes.mainLayout:
        final int? initialIndex = settings.arguments as int?;
        return  _page(MainLayout(initialIndex: initialIndex ?? 0), name: Routes.mainLayout);
      case Routes.products:
        return _page(const AllProductsScreen(), name: Routes.products);
      case Routes.product:
        return _page(const ProductDetailsScreen(), name: Routes.product);
      case Routes.productTags:
        return _page(const AllProductTagsScreen(), name: Routes.productTags);
      case Routes.news :
        return _page(const AllNewsScreen(), name: Routes.news);
      case Routes.newsDetails :
        return _page(const NewsItemDetails(), name: Routes.newsDetails);
      case Routes.vendors :
        return _page(const AllVendorsScreen(), name: Routes.vendors);
      case Routes.vendor :
        return _page(const VendorDetailsScreen(), name: Routes.vendor);
      case Routes.favorites:
        return _page(const FavoriteScreen(), name: Routes.favorites);
       case Routes.editProfile:
        return _page(BlocProvider(
            create: (context) => EditProfileCubit(getIt.get<ProfileRepository>()),
            child: const EditProfileScreen()), name: Routes.editProfile);
       case Routes.changePassword:
         return _page(BlocProvider(
             create: (context) => EditPasswordCubit(getIt.get<ProfileRepository>()),
             child: const ChangePasswordScreen()), name: Routes.changePassword);
       case Routes.settings:
         return _page(const SettingsScreen(), name: Routes.settings);
       case Routes.cart:
         return _page(const CartScreen(), name: Routes.cart);
       case Routes.promo:
         return _page(const ApplyPromoVoucher(), name: Routes.promo);
        case Routes.checkout:
          return _page(const CheckoutScreen(), name: Routes.checkout);
        case Routes.orderSuccess:
          return _page(const OrderSuccessScreen(), name: Routes.orderSuccess);
        case Routes.orderDetails:
          return _page(const OrderDetailsScreen(), name: Routes.orderDetails);
        case Routes.rateOrder:
          return _page(const RateOrderScreen(), name: Routes.rateOrder);
        case Routes.rateProduct:
          return _page(const RateProductScreen(), name: Routes.rateProduct);
      default:
        return null;
    }
  }

  MaterialPageRoute _page(Widget child, { String? name}) =>
      MaterialPageRoute(
        builder: (_) => child,
        settings: RouteSettings(name: name),
      );
}
