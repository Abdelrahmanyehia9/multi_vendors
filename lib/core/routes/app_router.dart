import 'package:flutter/material.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/main/layout.dart';
import '../../features/authentication/view/login_screen.dart';
import '../../features/main/favorite/view/favorite_screen.dart';
import '../../features/news/view/all_news_screen.dart';
import '../../features/news/view/news_item_details.dart';
import '../../features/shop/product/view/all_product_tags_screen.dart';
import '../../features/shop/product/view/all_products_screen.dart';
import '../../features/vendors/view/all_vendors_screen.dart';
import '../../features/shop/product/view/product_details_screen.dart';
import '../../features/vendors/view/vendor_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return _page(const LoginScreen(), name: Routes.loginScreen);
      case Routes.mainLayout:
        final int? initial = settings.arguments as int?;
        return  _page(MainLayout(initially: initial ?? 0), name: Routes.mainLayout);
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
