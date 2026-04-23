import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/authentication/data/repository/auth_repository.dart';
import 'package:multi_vendor/features/authentication/data/repository/reset_password_repository.dart';
import 'package:multi_vendor/features/main/layout.dart';
import 'package:multi_vendor/features/shop/cart/data/repository/promo_code_repository.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';
import 'package:multi_vendor/features/shop/checkout/logic/checkout_cubit.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import '../../features/authentication/data/repository/otp_repository.dart';
import '../../features/authentication/logic/forget_password_change_password_cubit.dart';
import '../../features/authentication/logic/forget_password_send_email_cubit.dart';
import '../../features/authentication/logic/forget_password_stepper_cubit.dart';
import '../../features/authentication/logic/login_cubit.dart';
import '../../features/authentication/logic/otp_confirm_cubit.dart';
import '../../features/authentication/logic/sign_up_cubit.dart';
import '../../features/authentication/view/forget_password_screen.dart';
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
import '../../features/main/profile/view/edit_address_screen.dart';
import '../../features/main/profile/view/edit_profile_screen.dart';
import '../../features/news/data/repository/news_repository.dart';
import '../../features/news/logic/news_cubit.dart';
import '../../features/news/view/all_news_screen.dart';
import '../../features/news/view/news_item_details.dart';
import '../../features/payments/data/repository/payment_repository.dart';
import '../../features/payments/logic/payment_cubit.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/shop/cart/view/apply_promo_voucher.dart';
import '../../features/shop/cart/view/cart_screen.dart';
import '../../features/shop/checkout/data/repository/checkout_repository.dart';
import '../../features/shop/checkout/logic/checkout_summery_cubit.dart';
import '../../features/shop/checkout/view/checkout_screen.dart';
import '../../features/shop/checkout/view/order_success.dart';
import '../../features/shop/history/data/repository/order_history_repository.dart';
import '../../features/shop/history/logic/order_details_cubit.dart';
import '../../features/shop/history/view/order_details_screen.dart';
import '../../features/shop/history/view/order_tracking_screen.dart';
import '../../features/shop/history/view/rate_order_screen.dart';
import '../../features/shop/history/view/rate_product_screen.dart';
import '../../features/shop/product/data/repository/product_repository.dart';
import '../../features/shop/product/logic/product_all_tags_cubit.dart';
import '../../features/shop/product/logic/product_details_cubit.dart';
import '../../features/shop/product/logic/products_by_filters_cubit.dart';
import '../../features/shop/product/view/all_product_tags_screen.dart';
import '../../features/shop/product/view/all_products_screen.dart';
import '../../features/shop/shared/model/order_model.dart';
import '../../features/vendors/data/repository/vendor_repository.dart';
import '../../features/vendors/logic/vendor_details_cubit.dart';
import '../../features/vendors/view/all_vendors_screen.dart';
import '../../features/shop/product/view/product_details_screen.dart';
import '../../features/vendors/view/vendor_details_screen.dart';
import '../cubit/search_cubit.dart';
import '../models/news_model.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return _page(const SplashScreen(), name: Routes.splash);
      case Routes.onBoarding:
        return _page(const OnBoardingScreen(), name: Routes.onBoarding);
      case Routes.loginScreen:
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginCubit(
                  getIt.get<AuthRepository>(),
                  getIt.get<OtpRepository>(),
                ),
              ),
            ],
            child: const LoginScreen(),
          ),
          name: Routes.loginScreen,
        );
      case Routes.otp:
        return _page(
          BlocProvider(
            create: (context) => OtpConfirmCubit(getIt.get<OtpRepository>()),
            child: OtpConfirmScreen(phoneNumber: settings.arguments as String),
          ),
          name: Routes.otp,
        );

      case Routes.signup:
        return _page(
          BlocProvider(
            create: (context) => SignupCubit(getIt.get<AuthRepository>()),
            child: const SignUpScreen(),
          ),
          name: Routes.signup,
        );
      case Routes.forgetPassword:
        final ForgetPasswordArgs args =
            settings.arguments as ForgetPasswordArgs;
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ForgetPasswordSendEmailCubit(
                  getIt.get<ResetPasswordRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => ForgetPasswordChangePasswordCubit(
                  getIt.get<ResetPasswordRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    ForgetPasswordStepperCubit()
                      ..init(email: args.email, initialStep: args.initialStep),
              ),
            ],
            child: const ForgetPasswordScreen(),
          ),
          name: Routes.forgetPassword,
        );
      case Routes.mainLayout:
        final int? initialIndex = settings.arguments as int?;
        return _page(
          BlocProvider(
            create: (context) => SearchCubit(),
            child: MainLayout(initialIndex: initialIndex ?? 0),
          ),
          name: Routes.mainLayout,
        );
      case Routes.products:
        final args = settings.arguments as ProductsScreenArgs?;
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    ProductsByFiltersCubit(getIt.get<ProductRepository>())
                      ..getProductsInFilter(filters: args?.initialFilters),
              ),
              BlocProvider(
                create: (context) =>
                    ProductsAllFiltersCubit(getIt.get<ProductRepository>())
                      ..init(args?.initialFilters)
                      ..exclude(args?.exclude),
              ),
            ],
            child: const AllProductsScreen(),
          ),
          name: Routes.products,
        );
      case Routes.product:
        final int pId = settings.arguments as int;
        return _page(
          BlocProvider(
            create: (context) =>
                ProductDetailsCubit(getIt.get<ProductRepository>())
                  ..getProductDetails(pId: pId),
            child: const ProductDetailsScreen(),
          ),
          name: Routes.product,
        );
      case Routes.productTags:
        return _page(
          BlocProvider(
            create: (context) =>
                ProductAllTagsCubit(getIt.get<ProductRepository>())
                  ..getAllTags(),
            child: const AllProductTagsScreen(),
          ),
          name: Routes.productTags,
        );
      case Routes.news:
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    NewsCubit(getIt.get<NewsRepository>())..getAllNews(),
              ),
              BlocProvider(create: (context) => SearchCubit(autoFocus: false)),
            ],
            child: const AllNewsScreen(),
          ),
          name: Routes.news,
        );
      case Routes.newsDetails:
        final NewsModel news = settings.arguments as NewsModel;
        return _page(NewsItemDetails(news: news), name: Routes.newsDetails);
      case Routes.vendors:
        return _page(const AllVendorsScreen(), name: Routes.vendors);
      case Routes.vendor:
        final int vendorId = settings.arguments as int;
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    VendorDetailsCubit(getIt.get<VendorRepository>())
                      ..getVendorDetails(vendorId),
              ),
              BlocProvider(
                create: (context) =>
                    ProductsAllFiltersCubit(getIt.get<ProductRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    ProductsByFiltersCubit(getIt.get<ProductRepository>()),
              ),
            ],

            child: const VendorDetailsScreen(),
          ),
          name: Routes.vendor,
        );
      case Routes.favorites:
        return _page(const FavoriteScreen(), name: Routes.favorites);
      case Routes.editProfile:
        return _page(
          BlocProvider(
            create: (context) =>
                EditProfileCubit(getIt.get<ProfileRepository>()),
            child: const EditProfileScreen(),
          ),
          name: Routes.editProfile,
        );
      case Routes.address:
        final EditProfileCubit cubit = settings.arguments as EditProfileCubit;
        return _page(
          BlocProvider.value(value: cubit, child: const EditAddressScreen()),
          name: Routes.address,
        );
      case Routes.changePassword:
        return _page(
          BlocProvider(
            create: (context) =>
                EditPasswordCubit(getIt.get<ProfileRepository>()),
            child: const ChangePasswordScreen(),
          ),
          name: Routes.changePassword,
        );
      case Routes.settings:
        return _page(const SettingsScreen(), name: Routes.settings);
      case Routes.cart:
        return _page(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    ValidatePromoCubit(getIt.get<PromoCodeRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    CheckoutSummeryCubit(getIt.get<CheckoutRepository>()),
              ),
            ],
            child: const CartScreen(),
          ),
          name: Routes.cart,
        );
      case Routes.promo:
        final ValidatePromoCubit cubit =
            settings.arguments as ValidatePromoCubit;
        return _page(
          BlocProvider.value(value: cubit, child: const ApplyPromoVoucher()),
          name: Routes.promo,
        );
      case Routes.checkout:
        CheckoutScreenArgs args = settings.arguments as CheckoutScreenArgs;
        return _page(MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    PaymentCubit(getIt.get<PaymentRepository>()),
              ),
              BlocProvider(create: (context)=> CheckoutCubit(getIt.get<CheckoutRepository>()))
            ],
            child: CheckoutScreen(args: args)), name: Routes.checkout);
      case Routes.orderSuccess:
        final OrderModel order = settings.arguments as OrderModel;
        return _page( OrderSuccessScreen(
          order: order,
        ), name: Routes.orderSuccess);
      case Routes.orderDetails:
        final int orderId = settings.arguments as int;
        return _page(BlocProvider(
            create: (context)=> OrderDetailsCubit(getIt.get<OrderHistoryRepository>())..getXOrderDetails(orderId),
            child: const OrderDetailsScreen()), name: Routes.orderDetails);
        case Routes.orderTracking:
          return _page(const OrderTrackingScreen(), name: Routes.orderTracking);
      case Routes.rateOrder:
        return _page(const RateOrderScreen(), name: Routes.rateOrder);
      case Routes.rateProduct:
        return _page(const RateProductScreen(), name: Routes.rateProduct);
      default:
        return null;
    }
  }

  MaterialPageRoute _page(Widget child, {String? name}) => MaterialPageRoute(
    builder: (_) => child,
    settings: RouteSettings(name: name),
  );
}
