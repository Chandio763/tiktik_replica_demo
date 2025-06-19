import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../views/login_view.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reactive variables for GetX:
  // Use .obs to make a variable observable (reactive).
  // _user will hold the authenticated Firebase User.
  final Rx<User?> _user = Rx<User?>(FirebaseAuth.instance.currentUser);
  // _isLoading will manage the loading state for UI.
  final RxBool _isLoading = RxBool(false);

  // Getters to easily access the reactive values
  User? get user => _user.value;
  bool get isLoading => _isLoading.value;

  // Called when the controller is first initialized (e.g., by Get.put)
  @override
  void onInit() {
    super.onInit();
    // Bind _user to FirebaseAuth's authStateChanges stream.
    // Whenever Firebase reports a change in auth state, _user.value will update,
    // and any Obx widgets listening to it will rebuild.
    _user.bindStream(_auth.authStateChanges());
    // Delay navigation until first frame is rendered
    ever(_user, (user) {
      if (user != null) {
        // Navigate to home and clear previous stack
        Get.offAll(() => HomeView());
      } else {
        Get.offAll(() => const LoginView());
      }
    });
  }

  Future<void> updateUserName(String name) async {
    if (user != null) {
      await user?.updateDisplayName(name);
      await user?.reload(); // Important: Reload user info after update
      print("Updated name: ${user?.displayName}");
    } else {
      print("No user is signed in.");
    }
  }

  // --- Helper for showing toast messages (can be replaced by Get.snackbar) ---
  void _showToast(String message, {bool isError = false}) {
    Get.snackbar('${isError ? "Failure" : "Success"}', message);
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 3,
    //   backgroundColor: isError ? Colors.redAccent : Colors.green,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );

    // Alternative using Get.snackbar (requires GetMaterialApp in main.dart)
    /*
    Get.snackbar(
      isError ? "Error" : "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
    );
    */
  }

  // --- Email/Password Sign Up ---
  Future<void> signUp(
    String email,
    String password, {
    required String name,
  }) async {
    _isLoading.value = true; // Update reactive loading state
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await updateUserName(name);
      _showToast('Registration successful! You are now logged in.');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else {
        errorMessage =
            e.message ?? 'An unknown error occurred during registration.';
      }
      _showToast(errorMessage, isError: true);
    } catch (e) {
      _showToast('An unexpected error occurred: $e', isError: true);
    } finally {
      _isLoading.value = false; // Reset loading state
    }
  }

  // --- Email/Password Login ---
  Future<void> login(String email, String password) async {
    _isLoading.value = true; // Update reactive loading state
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _showToast('Login successful!');
      // Get.offAll(() => HomeScreen()); // Optionally navigate immediately
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred during login.';
      }
      _showToast(errorMessage, isError: true);
    } catch (e) {
      _showToast('An unexpected error occurred: $e', isError: true);
    } finally {
      _isLoading.value = false; // Reset loading state
    }
  }

  // --- Sign Out ---
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // await _googleSignIn.signOut();
      // Get.delete<HomeController>();
      // Get.delete<CommunityController>();
      // Get.delete<MyQuestionsController>();
      _showToast('Logged out successfully.');
      // Get.offAll(() => LoginScreen()); // Navigate back to login
    } catch (e) {
      _showToast('Error signing out: $e', isError: true);
    }
  }
}
