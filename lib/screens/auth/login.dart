import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>(); // Form anahtarını oluşturun
  void _login() async {
    final success = await ApiService().login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (success) {
      _navigateToHome();
    } else {
      _showErrorMessage('Giriş başarısız. Lütfen tekrar deneyin.');
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushNamed("/");
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.titleMedium!;

    return Scaffold(
      appBar: AppBar(title:  Text("Giriş Yap",style: Theme.of(context).textTheme.displayLarge,),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelStyle: textStyle, labelText: 'E-mail'),
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
                  obscureText: true,
                  decoration: InputDecoration(
                      labelStyle: textStyle, labelText: 'Şifre'),
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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                    
                  },
                  child: const Text('Giriş Yap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
