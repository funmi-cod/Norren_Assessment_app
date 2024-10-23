import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/components/app_button.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/components/progress_hud.dart';
import 'package:norrenberger_app/common/constant/route_constant.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/common/verify/timer_count.dart';
import 'package:norrenberger_app/data/enums/view_state.dart';
import 'package:norrenberger_app/helpers/alert.dart';
import 'package:norrenberger_app/helpers/styles.dart';
import 'package:norrenberger_app/providers/auth_provider.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String? email;
  final String? name;
  const VerifyOtpScreen({super.key, this.email, this.name});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  late AlertToast toaster;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 30);

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 30));
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    countdownTimer!.cancel();
    //_otpInteractor.stopListenForCode();
  }

  final TextEditingController _pinPutController = TextEditingController();
  // late OTPTextEditController controller;
  // late OTPInteractor _otpInteractor;
  final FocusNode _pinPutFocusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColors.secondaryColor)),
    textStyle: const TextStyle(
      fontSize: 22,
      color: AppColors.black,
    ),
  );

  @override
  initState() {
    super.initState();
    toaster = AlertToast(context: context);
    startTimer();
  }

  _resendOtp() async {
    try {
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

      var response = await auth.userLogin(
          email: widget.email ?? '', firstName: widget.name ?? '');

      if (response["status"] == true) {
        resetTimer();
        startTimer();
        debugPrint(";;;;;;;;;;;");

        toaster.showSuccess(response["data"]["data"]);
      } else {
        toaster.showError(response["message"]);
      }
    } catch (e) {
      debugPrint("....$e");
    }
  }

  _handleSubmit(String pin) async {
    try {
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

      var response = await auth.confirmOtp(otp: pin, email: widget.email ?? '');
      debugPrint("ewewehbvbb$response");

      if (response["status"] == true) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteLiterals.productScreen, (Route<dynamic> route) => false);
      } else {
        toaster.showError(response["message"]);
      }
    } catch (e) {
      debugPrint("sdsihbbng,$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall:
          context.watch<AuthProvider>().verifyUserViewState == ViewState.busy,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 21.w, right: 21.w, top: 20.h),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalSpacing(50.h),
              Styles.bold(
                TextLiterals.enterOTP,
                fontSize: scaledFontSize(25.sp, context),
              ),
              VerticalSpacing(10.h),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: TextLiterals.otpSent,
                    style: TextStyle(
                        color: AppColors.transparentBlack,
                        height: 1.6.h,
                        fontSize: scaledFontSize(14.sp, context)),
                    children: [
                      TextSpan(
                          text: widget.email,
                          style: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700)),
                      const TextSpan(text: "\n"),
                      TextSpan(
                          text: TextLiterals.enterCode,
                          style: TextStyle(
                              color: AppColors.transparentBlack,
                              fontSize: scaledFontSize(15.sp, context))),
                    ]),
              ),
              SizedBox(height: 0.1.h * scaledHeight(context).h),
              Center(
                child: SizedBox(
                  height: 100.h,
                  width: scaledWidth(context).w,
                  child: Form(
                    key: _form,
                    //PinPut
                    child: Pinput(
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      onChanged: (val) async {
                        debugPrint(val);
                        AuthProvider auth =
                            Provider.of<AuthProvider>(context, listen: false);
                        val.length == 4
                            ? await auth.setVerifyUserViewState(ViewState.busy)
                            : await auth.setVerifyUserViewState(ViewState.idle);
                        // setState(() =>
                        //     _enabledState = val.length == 4 ? true : false);
                      },
                      //autovalidateMode: AutovalidateMode.always,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Feild must not be empty";
                        }
                        return null;
                      },

                      //onEditingComplete: () {},
                      //onSubmit
                      onCompleted: (String pin) {
                        debugPrint("completeewewe,$pin");
                        _handleSubmit(pin);
                      },
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,

                      focusedPinTheme: defaultPinTheme,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.04.h * scaledHeight(context).h),
              Center(
                  child: !countdownTimer!.isActive
                      ? AppButton(
                          text: TextLiterals.resendOtp,
                          onPressed: () {
                            _resendOtp();
                          },
                          width: 100.w,
                          backgroundColor: AppColors.primaryYellow,
                          borderRadius: BorderRadius.circular(7),
                          mainAxisAlignment: MainAxisAlignment.center,
                          height: 37.h,
                          isLoading: context
                                  .watch<AuthProvider>()
                                  .userLoginViewState ==
                              ViewState.busy,
                          enabled: context
                                  .watch<AuthProvider>()
                                  .userLoginViewState !=
                              ViewState.busy,
                          fontWeight: FWt.mediumBold,
                          fontSize: scaledFontSize(18.sp, context),
                          fontColor: AppColors.black,
                        )
                      : TimerCounter(count: seconds)),
              VerticalSpacing(50.h),
            ],
          )),
        ),
      ),
    );
  }
}
