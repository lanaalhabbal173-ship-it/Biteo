import 'package:dio/dio.dart';

class AuthService {
  static const String baseUrl =
      "http://10.33.220.76:8080/api";

  final Dio dio = Dio(
    BaseOptions(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },

      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  // =========================
  // LOGIN
  // =========================
  Future<Response> login(
    String email,
    String password,
  ) async {
    return await dio.post(
      "$baseUrl/login",
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  // =========================
  // REGISTER
  // =========================
  Future<Response> register(
    String name,
    String email,
    String phone,
    String password,
    String confirmPassword,
  ) async {
    return await dio.post(
      "$baseUrl/register",
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "confirm_password": confirmPassword,
      },
    );
  }

  // =========================
  // SEND OTP
  // =========================
  Future<Response> forgotPasswordOtp(
    String email,
  ) async {
    return await dio.post(
      "$baseUrl/forgot-password-otp",
      data: {
        "email": email,
      },
    );
  }

  // =========================
  // VERIFY OTP
  // =========================
  Future<Response> verifyOtp(
    String email,
    String otp,
  ) async {
    return await dio.post(
      "$baseUrl/verify-otp",
      data: {
        "email": email,
        "otp": otp,
      },
    );
  }

  // =========================
  // RESET PASSWORD
  // =========================
  Future<Response> resetPasswordOtp(
    String email,
    String verificationToken,
    String password,
    String confirmation,
  ) async {
    return await dio.post(
      "$baseUrl/reset-password-otp",
      data: {
        "email": email,
        "verification_token":
            verificationToken,
        "password": password,
        "password_confirmation":
            confirmation,
      },
    );
  }
}