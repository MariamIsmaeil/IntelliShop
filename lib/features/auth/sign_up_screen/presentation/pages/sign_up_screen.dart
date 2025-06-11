import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/strings_manager.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/auth/sign_up_screen/presentation/manager/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/DI/DI.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes_manager/routes.dart';
import '../../../../../core/widget/custom_loading_dialog.dart';
import '../../../../../core/widget/main_text_field.dart';
import '../../../../../core/widget/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController confirmpasswordController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    confirmpasswordController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    confirmpasswordController.dispose();
    passwordController.dispose();
  }

  String? _validatePasswordMatch(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupLoadingState) {
            showDialog(
              context: context,
              builder: (context) => CustomLoadingDialog(),
            );
          }
          if (state is SignupErrorState) {
            Navigator.pop(context);
            AppConstants.showToast(state.error);
          }
          if (state is SignupSuccessState) {
            Navigator.pop(context);
            AppConstants.showToast("Account created Successfully");
            PrefsHandler.setToken(state.signUpEntity.token ?? "");
            PrefsHandler.setEmail(state.signUpEntity.user?.email ?? "");
            PrefsHandler.setName(state.signUpEntity.user?.name ?? "");
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainRoute, (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/svg_images/route.svg',
                                width: 140,
                              ),
                              Text(
                              StringsManager.loginWelcome,
                              style: getBoldStyle(color: ColorManager.white)
                                  .copyWith(fontSize: FontSize.s24.sp),
                            ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        BuildTextField(
                          backgroundColor: ColorManager.white,
                          hint: 'enter your full name',
                          label: 'Full Name',
                          textInputType: TextInputType.name,
                          controller: nameController,
                          validation: AppValidators.validateFullName,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          hint: 'enter your email address',
                          backgroundColor: ColorManager.white,
                          label: 'E-mail address',
                          controller: emailController,
                          validation: AppValidators.validateEmail,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          hint: 'enter your password',
                          backgroundColor: ColorManager.white,
                          controller: passwordController,
                          label: 'password',
                          validation: AppValidators.validatePassword,
                          isObscured: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: AppSize.s18.h,
                        ),
                        BuildTextField(
                          hint: 'confirm your password',
                          backgroundColor: ColorManager.white,
                          label: 'Confirm Password',
                          controller: confirmpasswordController,
                          validation: _validatePasswordMatch,
                          isObscured: true,
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: AppSize.s50.h,
                        ),
                        Center(
                          child: SizedBox(
                            height: AppSize.s60.h,
                            width: MediaQuery.of(context).size.width * .9,
                            child: CustomElevatedButton(
                              // borderRadius: AppSize.s8,
                              label: 'Sign Up',
                              backgroundColor: ColorManager.white,
                              textStyle: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: AppSize.s20),
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  SignupCubit.get(context).SignUp(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: "");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
