import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/screens/upload_image_screen.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'package:provider/provider.dart';




class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool _passwordVisible = true;
    
    @override
    void initState() {
        super.initState();
        _passwordVisible;
    }

    @override
    void dispose() {
        emailController.dispose();
        passwordController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                    // App Logo
                          const SizedBox(height: 28),
                            const Text(
                                'Holbegram',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontFamily: 'Billabong',
                                ),
                            ),
                            Image.asset(
                                'assets/images/logo.webp',
                                height: 60,
                                width: 80,
                            ),
                    // Login Form
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                    children:[
                                        const SizedBox(height: 28),

                    // Email TextField
                                        TextFieldInput(
                                            controller: emailController,
                                            ispassword: false,
                                            hintText: 'Email',
                                            keyboardType: TextInputType.emailAddress,
                                        ),
                                        SizedBox(height: 24),    
                    // Password TextField
                                        TextFieldInput(
                                            controller: passwordController,
                                            ispassword: !_passwordVisible,
                                            hintText: 'Password',
                                            keyboardType: TextInputType.visiblePassword,
                                            suffixIcon: IconButton(
                                                alignment: Alignment.bottomLeft,
                                                icon: Icon(
                                                    _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                    setState(() {
                                                        _passwordVisible = !_passwordVisible;
                                                    });
                                                },
                                            ),
                                        ),
                                        SizedBox(height: 28),

                    // Login Button
                                        SizedBox(
                                            height: 48,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(218, 226, 37, 24),
                                                    ),
                                                ),
                                            onPressed: () async {
                                                String email = emailController.text;
                                                String password = passwordController.text;
                                                String result = await AuthMethode().login(email: email, password: password);
                                                if (result == 'Success') {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                            content: Text('Login Success'),
                                                        ),
                                                    );
                                                    Provider.of<UserProvider>(context, listen: false).refreshUser();
                                                    Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) => const Home(),
                                                        ),
                                                    );
                                                } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text(result),
                                                        ),
                                                    );
                                                }
                                            },
                                            child: Text(
                                                'Log In',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                ),
                                            ),
                                            ),
                                        ),
                                        SizedBox(height: 24),
                                        const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                                Text(
                                                    'Forgot your login details?'),
                                                    Text(
                                                        'Get help logging in.',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                        ),
                                            ],
                                        ),
                                        Flexible(
                                            flex: 0,
                                            child: Container(),
                                                    ),
                                        const SizedBox(height: 24),
                                        const Divider(
                                            thickness: 2,
                                                ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(vertical: 12),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                    Text(
                                                        'Don\'t have an account?'),
                                                        TextButton(
                                                        onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => SignUp(),
                                                                ),
                                                            );
                                                        },
                                                        child: Text(
                                                            'Sign up.',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                color: Color.fromARGB(218, 226, 37, 24)),
                                                            ),
                                                        ),
                                                ],
                                            ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                            children: [
                                                Flexible(
                                                    child: const Divider(
                                                        thickness: 2,
                                                    ),
                                                ),
                                                Text(
                                                    "OR",
                                                    style: TextStyle(
                                                        fontSize: 20),
                                                ),
                                                Flexible(
                                                    child: const Divider(
                                                        thickness: 2,
                                                    ),
                                                    ),
                                            ],
                                                ),
                                        const SizedBox(height: 10),
                                        Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                                Image.network(
                                                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                                                    width: 40,
                                                    height: 40,
                                                ),
                                                const Text("Sign in with Google"),
                                            ],
                                        )
                                    ],
                                ),
                            ),
                   ]),
            ),
        );
    }
}