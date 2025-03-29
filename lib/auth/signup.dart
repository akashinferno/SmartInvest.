import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_invest_1/auth/login.dart';
import 'package:smart_invest_1/utils/theme.dart'; // Import your existing theme

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Future<void> signUp() async {
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    // Check if passwords match
    if (password.text != confirmPassword.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
        isLoading = false;
      });
      return;
    }

    // Validate inputs
    if (email.text.trim().isEmpty || password.text.isEmpty) {
      setState(() {
        errorMessage = 'Email and password cannot be empty';
        isLoading = false;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );
      // User creation successful
    } catch (e) {
      // Handle different Firebase exceptions
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            setState(() {
              errorMessage = 'This email is already registered';
            });
            break;
          case 'invalid-email':
            setState(() {
              errorMessage = 'Email address is not valid';
            });
            break;
          case 'weak-password':
            setState(() {
              errorMessage = 'Password is too weak';
            });
            break;
          case 'operation-not-allowed':
            setState(() {
              errorMessage = 'Email/password accounts are not enabled';
            });
            break;
          default:
            setState(() {
              errorMessage =
                  e.message ?? 'An error occurred during registration';
            });
        }
      } else {
        setState(() {
          errorMessage = 'An unexpected error occurred';
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the primary color from your theme
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App logo or icon with dynamic primary color
                Icon(
                  Icons.account_circle,
                  size: 80,
                  color: primaryColor,
                ),
                const SizedBox(height: 30),

                // Email input
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email, color: primaryColor),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    labelStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Password input
                TextField(
                  controller: password,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    labelStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Confirm password input
                TextField(
                  controller: confirmPassword,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    labelStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => signUp(),
                ),

                // Error message display
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Sign up button
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : signUp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: primaryColor.withOpacity(0.3),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Sign Up', style: TextStyle(fontSize: 16)),
                ),

                // Already have an account link
                const SizedBox(height: 20),
                TextButton(
                  onPressed: navigateToLogin,
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                  ),
                  child: const Text(
                    'Already registered? Log in',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
