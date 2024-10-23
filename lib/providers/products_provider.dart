import 'package:flutter/material.dart';
import 'package:norrenberger_app/data/enums/view_state.dart';
import 'package:norrenberger_app/data/models/product_history.dart';
import 'package:norrenberger_app/service/products_service.dart';

class ProductsProvider with ChangeNotifier {
  final ProductsService _productsService = ProductsService();
  final String _errorMessage = "";

  String get errorMessage => _errorMessage;

  ProductHistory? _productHistory;
  ProductHistory? get productHistory => _productHistory;

  ViewState _productListViewState = ViewState.idle;
  ViewState get productListViewState => _productListViewState;
  setProductHistoryViewState(ViewState viewState) {
    _productListViewState = viewState;
    notifyListeners();
  }

  Future<Null> fetchProductHistory() async {
    setProductHistoryViewState(ViewState.busy);
    debugPrint("products list busy=====");
    try {
      _productHistory = await _productsService.fetchProductHistory();
      debugPrint("products list completedImmmmmm");
      setProductHistoryViewState(ViewState.completed);
    } catch (e) {
      setProductHistoryViewState(ViewState.error);
      debugPrint('Error: provider products $e');
    }
  }
}
