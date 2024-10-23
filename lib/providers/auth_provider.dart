import 'package:flutter/material.dart';
import 'package:norrenberger_app/data/enums/view_state.dart';
import 'package:norrenberger_app/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final String _errorMessage = "";

  String get errorMessage => _errorMessage;

  ViewState _productListViewState = ViewState.idle;
  ViewState get productListViewState => _productListViewState;
  setProductListViewState(ViewState viewState) {
    _productListViewState = viewState;
    notifyListeners();
  }

  ViewState _userLoginViewState = ViewState.idle;
  ViewState get userLoginViewState => _userLoginViewState;
  setUserLoginViewState(ViewState viewState) {
    _userLoginViewState = viewState;
    notifyListeners();
  }

  ViewState _verifyUserViewState = ViewState.idle;
  ViewState get verifyUserViewState => _verifyUserViewState;
  setVerifyUserViewState(ViewState viewState) {
    _verifyUserViewState = viewState;
    notifyListeners();
  }

  dynamic userLogin({required String firstName, required String email}) async {
    setUserLoginViewState(ViewState.busy);
    debugPrint("herrrr[pp]=====");
    try {
      var response =
          await _authService.postLoginData(firstName: firstName, email: email);
      debugPrint("Login====complete=");
      setUserLoginViewState(ViewState.completed);
      return response;
    } catch (e) {
      setUserLoginViewState(ViewState.error);
      debugPrint('Error: login==  $e');
    }
  }

  dynamic confirmOtp({required String otp, required String email}) async {
    setVerifyUserViewState(ViewState.busy);
    debugPrint("[[]]]=====");
    try {
      var response = await _authService.confirmOtp(otp: otp, email: email);
      debugPrint("verifying====complete=");
      setVerifyUserViewState(ViewState.completed);
      return response;
    } catch (e) {
      setVerifyUserViewState(ViewState.error);
      debugPrint('Error: verifying==  $e');
    }
  }
}
