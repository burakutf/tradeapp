import 'package:flutter/material.dart';
import 'package:tradeapp/screens/auth/forgot_password.dart';
import 'package:tradeapp/screens/auth/register.dart';
import 'package:tradeapp/screens/auth/verification_code.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/services/api_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  void _login() async {
    final result = await ApiService().login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == 'success') {
      // Başarılı giriş işlemi
      _navigateToHome();
    }
    if (result == 'Your account is not active!') {
      emailVerificationCode('send');
      _navigateToEmailVerification();
    } else {
      // Giriş başarısız veya hata oldu, result içeriği hata mesajını içerebilir.
      _showErrorMessage(result);
    }
  }

  void emailVerificationCode(String? status) async {
    await ApiService().emailVerificationCode(
      email: emailController.text,
      status: status,
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushNamed("/");
  }

  void _navigateToEmailVerification() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) =>
          EmailVerificationPage(email: emailController.text),
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
                    const HomePage(),
                transitionDuration: const Duration(seconds: 0),
              ));
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
            )),
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
                      "Sign in to TradingAnalyser",
                      style: textStyleMedium,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                      child: InkWell(
                          child: Row(
                        children: [
                          Text(
                            "New user?",
                            style: textStyleSmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const RegisterPage(),
                                transitionDuration: const Duration(seconds: 0),
                              ));
                            },
                            child: Text(
                              " create account.",
                              style: TextStyle(
                                  color: themeData.colorScheme.background),
                            ),
                          )
                        ],
                      )),
                    )),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
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
                    labelText: "E-mail",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-mail boş bırakılamaz';
                    } else if (!value.contains('@')) {
                      return 'Geçerli bir e-mail adresi girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
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
                    labelText: "Şifre",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: _toggleObscureText,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre boş bırakılamaz';
                    } else if (value.length < 8) {
                      return 'Şifre en az 8 karakter olmalıdır';
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
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 200,
                    child: GestureDetector(
                      onTap: (){
                           Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) =>
          const ForgotPasswordPage(),
      transitionDuration: const Duration(seconds: 0),
    ));
                      },
                      child: Center(
                        child: Text(
                          "Forgot You Password?",
                          style: textStyle.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Colors.white, // Alt çizginin rengini beyaz yapar
                          ),
                        ),
                      ),
                    ),
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

                        return themeData
                            .primaryColor; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: const SizedBox(
                      width: 300,
                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
