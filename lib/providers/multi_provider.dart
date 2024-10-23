import 'package:norrenberger_app/providers/auth_provider.dart';
import 'package:norrenberger_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

final allProviders = [
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
  ),
  ChangeNotifierProvider<ProductsProvider>(
    create: (_) => ProductsProvider(),
  ),
];
