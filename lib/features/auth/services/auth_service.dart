import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrimarket/features/auth/models/user_model.dart';
import 'package:agrimarket/features/auth/models/registration_params.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Triggers Firebase Phone Verification SMS
  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolves SMS on some Android devices if needed
      },
      verificationFailed: (FirebaseAuthException e) {
        onVerificationFailed(e.message ?? "Phone verification failed.");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// Verifies the OTP credential structure and creates the user account
  Future<UserModel> registerWithEmailAndPasswordAndPhone({
    required RegistrationParams params,
    required String verificationId,
    required String smsCode,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    String uid = userCredential.user!.uid;

    UserModel newUser = UserModel(
      uid: uid,
      name: params.name,
      email: params.email,
      mobile: params.mobile,
      role: params.role,
      createdAt: DateTime.now(),
      village: params.village,
      state: params.state,
      businessName: params.businessName,
      city: params.city,
      buyerType: params.buyerType,
    );

    await _firestore.collection('users').doc(uid).set(newUser.toMap());
    return newUser;
  }

  /// Live Dynamic Login Logic using Email and Password with structural Firestore role routing
  Future<UserModel> loginWithEmailAndPassword(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Pull document details matching the authenticated account ID
    DocumentSnapshot doc = await _firestore.collection('users').doc(credential.user!.uid).get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception("User profile details missing in database records.");
    }
  }
}