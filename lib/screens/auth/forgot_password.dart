import 'package:flutter/material.dart';
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/screens/auth/next_step_forgot_password.dart';
import 'package:tradeapp/services/api_services.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key})
      : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;



  void emailVerificationCode(String? status) async {
    final response = await ApiService().emailVerificationCode(
      email: emailController.text,
      status: status,
    );

    if (response != null) {
      if (response.containsKey('message')) {
        // Başarılı durum
        if (status == 'send') {
          _navigateToNextStep();
        }
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

  void _navigateToNextStep() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) =>  ForgotPasswordNextStepPage(email: emailController.text,),
      transitionDuration: const Duration(seconds: 0),
    ));
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
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
                    "Doğrulama kodu gönder",
                    style: textStyleMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                    child: InkWell(
                      child: Text(
                        "Şifrenizi değiştirmeye son bir adım.",
                        style: textStyleSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: emailController,
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
                      return 'Geçerli bir email giriniz';
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
                      emailVerificationCode('send');
                    }
                  },
                  
                  child: const SizedBox(
                    width: 300,
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Text(
                            'Gönder',
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
