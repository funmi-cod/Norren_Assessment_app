import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/components/app_button.dart';
import 'package:norrenberger_app/common/components/app_widget.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/components/progress_hud.dart';
import 'package:norrenberger_app/common/constant/route_constant.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/data/enums/view_state.dart';
import 'package:norrenberger_app/helpers/alert.dart';
import 'package:norrenberger_app/helpers/styles.dart';
import 'package:norrenberger_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  _handleSubmit() async {
    AlertToast toasters = AlertToast(context: context);
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
        var response = await auth.userLogin(
          firstName: nameController.text.trim(),
          email: emailController.text.trim(),
        );

        if (response["status"] == true) {
          toasters.showSuccess(response["message"]);
          Navigator.pushNamed(context, RouteLiterals.verifyOtp, arguments: {
            "email": emailController.text.trim(),
            "name": nameController.text.trim()
          });
        } else {
          toasters.showError(response["message"]);
        }
      } catch (e) {
        toasters.showError(e.toString());
        debugPrint("$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall:
          context.watch<AuthProvider>().userLoginViewState == ViewState.busy,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(100.h),
            Styles.medium(
              TextLiterals.greetings,
              fontSize: scaledFontSize(22.sp, context),
            ),
            VerticalSpacing(5.h),
            Styles.regular(TextLiterals.quickInfo),
            VerticalSpacing(20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 250.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.greyD5.withOpacity(.15)),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 8.w,
                            right: 8.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpacing(10.h),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: TextLiterals.name,
                                    style: TextStyle(
                                        color: AppColors.transparentBlack,
                                        fontWeight: FWt.mediumBold,
                                        fontSize:
                                            scaledFontSize(15.sp, context)),
                                    children: [
                                      Styles.spanRegular('*',
                                          color: AppColors.primaryRed,
                                          fontSize: 15.sp),
                                    ]),
                              ),
                              VerticalSpacing(10),
                              AppWidget.buildUserInput(
                                  controller: nameController,
                                  hint: TextLiterals.enterName,
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return TextLiterals.enterName;
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {},
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z ]+|\s[ a-zA-Z]+')),
                                  ],
                                  borderRadius: BorderRadius.circular(10.r)),
                              VerticalSpacing(20.h),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: TextLiterals.email,
                                    style: TextStyle(
                                        color: AppColors.transparentBlack,
                                        fontWeight: FWt.mediumBold,
                                        fontSize:
                                            scaledFontSize(15.sp, context)),
                                    children: [
                                      Styles.spanRegular('*',
                                          color: AppColors.primaryRed,
                                          fontSize:
                                              scaledFontSize(15.sp, context)),
                                    ]),
                              ),
                              VerticalSpacing(15.h),
                              AppWidget.buildUserInput(
                                  controller: emailController,
                                  hint: TextLiterals.enterEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return TextLiterals.enterEmail;
                                    }
                                    if (!val.contains('@')) {
                                      return 'Invalid email format';
                                    }
                                  },
                                  onSaved: (val) {},
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9@.+-_]')),
                                  ],
                                  borderRadius: BorderRadius.circular(10.r)),
                              VerticalSpacing(5.h),
                            ],
                          ),
                        ),
                      ),
                      VerticalSpacing(50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: AppButton(
                          width: scaledWidth(context).w,
                          text: TextLiterals.textContinue,
                          enabled: true,
                          backgroundColor: AppColors.primaryYellow,
                          height: 58.h,
                          fontSize: scaledFontSize(16.sp, context),
                          onPressed: () {
                            _handleSubmit();
                          },
                        ),
                      ),
                      VerticalSpacing(30.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
