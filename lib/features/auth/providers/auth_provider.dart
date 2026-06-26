import 'package:flutter/material.dart';
import 'package:agrimarket/features/auth/models/user_model.dart';
import 'package:agrimarket/features/auth/models/registration_params.dart';
import 'package:agrimarket/features/auth/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  String? _verificationId;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get verificationId => _verificationId;

  /// Sets user state globally for external single sign-on hooks (like Google Sign In)
  void setAuthenticatedUser(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }

  /// Sends dynamic verification code to user's mobile number
  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String formattedPhone = phoneNumber.startsWith('+') ? phoneNumber : '+91$phoneNumber';

      await _authRepository.sendOtpCode(
        phoneNumber: formattedPhone,
        onCodeSent: (id) {
          _verificationId = id;
          _isLoading = false;
          notifyListeners();
          onCodeSent(id);
        },
        onVerificationFailed: (err) {
          _isLoading = false;
          _errorMessage = err;
          notifyListeners();
          onVerificationFailed(err);
        },
      );
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      onVerificationFailed(_errorMessage!);
    }
  }

  /// Verifies OTP token and processes Firestore data generation
  Future<bool> registerWithOtp(RegistrationParams params, String smsCode) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_verificationId == null) {
      _errorMessage = "Verification session expired. Please try resending.";
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      _user = await _authRepository.registerUserWithPhoneVerification(
        params: params,
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      String rawError = e.toString();
      _errorMessage = rawError.contains(']') ? rawError.split(']').last.trim() : rawError;
      notifyListeners();
      return false;
    }
  }

  /// Signs in active users and returns parsed model parameters
  Future<UserModel?> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _authRepository.loginUser(email, password);
      _isLoading = false;
      notifyListeners();
      return _user;
    } catch (e) {
      _isLoading = false;
      String rawError = e.toString();
      _errorMessage = rawError.contains(']') ? rawError.split(']').last.trim() : rawError;
      notifyListeners();
      return null;
    }
  }
}