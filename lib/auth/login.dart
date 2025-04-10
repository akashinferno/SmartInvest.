import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_invest_1/auth/signup.dart';
import 'package:smart_invest_1/utils/theme.dart'; // Import your existing theme

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;
  bool isPasswordVisible = false;

  Future<void> signIn() async {
    // Validate inputs
    if (email.text.trim().isEmpty || password.text.isEmpty) {
      setState(() {
        errorMessage = 'Email and password cannot be empty';
      });
      return;
    }

    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );
      // Login successful - the Wrapper will handle navigation
    } catch (e) {
      // Handle different Firebase exceptions
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            setState(() {
              errorMessage = 'No user found with this email';
            });
            break;
          case 'wrong-password':
            setState(() {
              errorMessage = 'Incorrect password';
            });
            break;
          case 'invalid-email':
            setState(() {
              errorMessage = 'Email address is not valid';
            });
            break;
          case 'user-disabled':
            setState(() {
              errorMessage = 'This account has been disabled';
            });
            break;
          case 'too-many-requests':
            setState(() {
              errorMessage = 'Too many login attempts. Try again later';
            });
            break;
          default:
            setState(() {
              errorMessage = e.message ?? 'An error occurred during login';
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

  void navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the primary color from your theme
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        // Using your theme's primary color for AppBar
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

                // Email field
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

                // Password field
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
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => signIn(),
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

                // Login button using the primary color
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : signIn,
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
                      : const Text('Login', style: TextStyle(fontSize: 16)),
                ),

                // Sign up button for new users with primary color
                const SizedBox(height: 20),
                TextButton(
                  onPressed: navigateToSignUp,
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                  ),
                  child: const Text(
                    'New user? Sign up',
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
