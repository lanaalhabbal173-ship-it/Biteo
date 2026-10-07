import 'package:biteoapp/bindings/forgot_password_bindings.dart';
import 'package:biteoapp/bindings/home_binding.dart';
import 'package:biteoapp/bindings/login_bindings.dart';
import 'package:biteoapp/bindings/otp_binding.dart';
import 'package:biteoapp/bindings/product_details_binding.dart';
import 'package:biteoapp/bindings/register_bindings.dart';
import 'package:biteoapp/bindings/reset_password_binding.dart';
import 'package:biteoapp/bindings/splash_bindings.dart';

import 'package:biteoapp/views/cart_view.dart';
import 'package:biteoapp/views/forgot_password_view.dart';
import 'package:biteoapp/views/main_navigation_view.dart';
import 'package:biteoapp/views/otp_view.dart';
import 'package:biteoapp/views/product_details_view.dart';
import 'package:biteoapp/views/register_view.dart';
import 'package:biteoapp/views/reset_password_view.dart';
import 'package:biteoapp/views/search_view.dart';

import 'package:get/get.dart';

import '../views/splash_view.dart';
import '../views/login_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const SplashView(),
      binding: SplashBindings(),
    ),

    GetPage(
      name: '/login',
      page: () => const LoginView(),
      binding: LoginBindings(),
    ),

    GetPage(
      name: '/register',
      page: () => const RegisterView(),
      binding: RegisterBindings(),
    ),

    GetPage(
      name: '/forgot-password',
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBindings(),
    ),

    GetPage(
      name: '/reset-password',
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),

    GetPage(
      name: '/home',
      page: () => const MainNavigationView(),
      binding: HomeBinding(),
    ),

    GetPage(name: '/search', page: () => SearchView()),

    GetPage(
      name: '/product-details',
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),

    GetPage(name: '/cart', page: () => CartView()),
    GetPage(name: '/otp', page: () => const OtpView(), binding: OtpBinding()),
  ];
}
