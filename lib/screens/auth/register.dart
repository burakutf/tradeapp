import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/screens/auth/verification_code.dart';
import 'package:tradeapp/services/api_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordRepeatController =
      TextEditingController();
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();

  void _register() async {
    final success = await ApiService().register(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      surname: surnameController.text,
    );
    if (success) {
      _navigateToVerifactionPage();
    } else {
      _showErrorMessage('Kayıt Olma başarısız. Bu mail zaten kullanılmakta.');
    }
  }

  void _navigateToVerifactionPage() {
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
                    const LoginPage(),
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
                      "Get started absolutely free",
                      style: textStyleMedium,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                      child: InkWell(
                          child: Row(
                        children: [
                          Text(
                            "Already have an account?",
                            style: textStyleSmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const LoginPage(),
                                transitionDuration: const Duration(seconds: 0),
                              ));
                            },
                            child: Text(
                              " Sign in.",
                              style: TextStyle(
                                  color: themeData.colorScheme.background),
                            ),
                          )
                        ],
                      )),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(

                        controller: nameController, // Ad için bir controller
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
                          labelText: "Ad",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ad boş bırakılamaz.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller:
                            surnameController, // Soyad için bir controller
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
                          labelText: "Soyad",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Soyad boş bırakılamaz';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
         
                const SizedBox(height: 20.0),
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
                      return 'Şifre boş bırakılamaz';
                    } else if (value.length < 8) {
                      return 'Şifre en az 8 karakter olmalıdır';
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
                    labelText: "Şifre Tekrar",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre tekrarını boş bırakamazsınız';
                    } else if (value != passwordController.text) {
                      return 'Şifreler uyuşmuyor';
                    }
                    return null;
                  },
                ),
          
                const SizedBox(height: 20.0),
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
                      _register();
                    }
                  },
                  child: const SizedBox(
                    width: 300,
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'By signing up, I agree to ',
                    style: const TextStyle(fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms of Service',
                        style: const TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/terms_of_service');
                          },
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/privacy_policy');
                          },
                      ),
                      const TextSpan(text: '.'),
                    ],
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
