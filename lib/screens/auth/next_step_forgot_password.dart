import 'package:flutter/material.dart';
import 'dart:async'; // Timer kullanmak için eklenmesi gereken paket
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/screens/auth/register.dart';
import 'package:tradeapp/services/api_services.dart';

class ForgotPasswordNextStepPage extends StatefulWidget {
  final String email;
  const ForgotPasswordNextStepPage({Key? key, required this.email})
      : super(key: key);

  @override
  ForgotPasswordNextStepPageState createState() => ForgotPasswordNextStepPageState();
}

class ForgotPasswordNextStepPageState extends State<ForgotPasswordNextStepPage> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();
  String? _errorMessage;
  final bool _isCodeSent =
      false; // Kodun daha önce gönderilip gönderilmediğini kontrol etmek için kullanılır
  int _remainingSeconds = 180; // Geriye sayım süresi (3 dakika)

  late Timer _timer; // Geriye sayım için kullanılacak Timer

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    startCountdown(); // Sayacı başlat
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void forgotPasswordWithEmail(String? status) async {
    final response = await ApiService().forgotPasswordWithEmail(
      email: widget.email,
      password: passwordController.text,
      code: codeController.text,
    );

    if (response != null) {
      if (response.containsKey('message')) {
          _navigateToLogin();
      } else if (response.containsKey('error')) {
        // Başarısız durum, hata mesajını kullanıcıya gösterin
        _showErrorMessage(response['error']);
      } else {
        // Bilinmeyen hata durumu
        _showErrorMessage('An unknown error occurred.');
      }
    } else {
      // Hata durumu
      _showErrorMessage('Something went wrong.');
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => const LoginPage(),
      transitionDuration: const Duration(seconds: 0),
    ));
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Timer'ı iptal et
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.titleMedium!;
    TextStyle textStyleMedium = Theme.of(context).textTheme.displayLarge!;
    ThemeData themeData = Theme.of(context);
    TextStyle textStyleSmall = Theme.of(context).textTheme.displaySmall!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const RegisterPage(),
              transitionDuration: const Duration(seconds: 0),
            ));
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "One last step to register",
                    style: textStyleMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                    child: InkWell(
                      child: Text(
                        "Enter the code sent to ${widget.email} email",
                        style: textStyleSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  maxLength: 6,
                  controller: codeController,
                  style: textStyle,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: themeData.primaryColor),
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Verification Code",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                 
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Verification code cannot be left blank';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  style: textStyle,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: themeData.primaryColor), // Border rengi
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: _toggleObscureText,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be left blank';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordRepeatController,
                  obscureText: _obscureText,
                  style: textStyle,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: themeData.primaryColor), // Border rengi
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Password Again",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You cannot leave the password repeat blank';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
          
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (!_isCodeSent && _remainingSeconds == 0)
                  TextButton(
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Center(
                            child: Text(
                          'Code sent',
                          style: textStyle,
                        )),
                      );

                      // SnackBar'ı göstermek için ScaffoldMessenger kullanılır
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      forgotPasswordWithEmail('send');
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(color: themeData.primaryColor),
                    ),
                  ),
                if (_remainingSeconds > 0)
                  Text(
                    'Remaining time: $_remainingSeconds seconds',
                    style: TextStyle(
                      color: themeData.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return themeData.colorScheme.background;
                        }
                        return themeData.primaryColor;
                      },
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      forgotPasswordWithEmail('approve');
                    }
                  },
                  child: const SizedBox(
                    width: 300,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Text(
                            'Accept',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
