import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:norrenberger_app/common/constant/route_constant.dart';
import 'package:norrenberger_app/data/models/product_history.dart';
import 'package:norrenberger_app/presentation/screens/products/product_detail_screen.dart';
import 'package:norrenberger_app/presentation/screens/products/products_screen.dart';
import 'package:norrenberger_app/presentation/screens/onboarding/login_screen.dart';
import 'package:norrenberger_app/presentation/screens/products/sub_product_details_screen.dart';
import 'package:norrenberger_app/presentation/screens/verify/verify_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLiterals.verifyOtp:
        debugPrint("acdiysd${settings.arguments}");
        final data = settings.arguments as Map;
        return CupertinoPageRoute(
            builder: (_) => VerifyOtpScreen(
                  email: data["email"],
                  name: data["name"],
                ),
            settings: RouteSettings(name: settings.name));

      case RouteLiterals.userLogin:
        return CupertinoPageRoute(
            builder: (_) => const LoginScreen(),
            settings: RouteSettings(name: settings.name));

      case RouteLiterals.productScreen:
        return CupertinoPageRoute(
            builder: (_) => const ProductsScreen(),
            settings: RouteSettings(name: settings.name));

      case RouteLiterals.productDetails:
        final data = settings.arguments as Result;
        return CupertinoPageRoute(
            builder: (_) => ProductDetailScreen(
                  data: data,
                ),
            settings: RouteSettings(name: settings.name));

      case RouteLiterals.subProductDetails:
        final data = settings.arguments as SubProduct;
        return CupertinoPageRoute(
            builder: (_) => SubProductDetailsScreen(
                  data: data,
                ),
            settings: RouteSettings(name: settings.name));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route specified for ${settings.name}'),
                  ),
                ));
    }
  }
}
