import 'package:agrimarket/features/auth/models/user_model.dart';
import 'package:agrimarket/features/auth/models/registration_params.dart';
import 'package:agrimarket/features/auth/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<void> sendOtpCode({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
  }) {
    return _authService.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onVerificationFailed: onVerificationFailed,
    );
  }

  Future<UserModel> registerUserWithPhoneVerification({
    required RegistrationParams params,
    required String verificationId,
    required String smsCode,
  }) {
    return _authService.registerWithEmailAndPasswordAndPhone(
      params: params,
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future<UserModel> loginUser(String email, String password) {
    return _authService.loginWithEmailAndPassword(email, password);
  }
}