import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. This is the Firebase command to CREATE a user
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. AuthWrapper will auto-navigate to HomeScreen.

    } on FirebaseAuthException catch (e) {
      // 3. Handle specific sign-up errors
      String message = 'An error occurred';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    // 1. A Scaffold provides the basic screen structure
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          onPressed: _signUp,

          // 2. Show a spinner OR text
          child: _isLoading
              ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : const Text('Sign Up'),
        ),

        const SizedBox(height: 10),
        TextButton(
        onPressed: () {
      // 8. Navigate to the Sign Up screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ),
      );
    },
    child: const Text("Already have an account? Login"),