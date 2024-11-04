class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Future<void> _loginWithEmailAndPassword() async {
  if (_formKey.currentState?.validate() ?? false) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);
      if (mounted) {
        if (user != null) {
          logger.i('Login successful');
          Navigator.pushReplacementNamed(context, '/crops');
        } else {
          logger.w('Error during sign-in');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email or password')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        logger.e('Error during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during login: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
