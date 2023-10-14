import 'package:flutter/material.dart';
import 'package:tradeapp/models/profile.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/services/api_services.dart';
import 'package:tradeapp/services/auth_services.dart';
import 'package:tradeapp/widget/custom_bottom_app_bar.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  late Future<List<UserData>?>
      userDataFuture; // userDataFuture artık nullable değil

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  Color errorColor = Colors.redAccent;
  @override
  void initState() {
    super.initState();
    userDataFuture = ApiService().getUserProfile();
  }

  InputDecoration buildInputDecoration(
      String labelText, TextStyle textStyle, ThemeData themeData) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: textStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: themeData.secondaryHeaderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: themeData.primaryColor),
      ),
      filled: true,
      fillColor: themeData.scaffoldBackgroundColor,
    );
  }

  void updatePassword() async {
    final response = await ApiService().updatePassword(
        oldPassword: oldPasswordController.text,
        newPassword: passwordController.text);

    if (response != null) {
      if (response.containsKey('message')) {
        setState(() {
          _errorMessage = "Changed Password";
          errorColor=Colors.greenAccent;
          oldPasswordController.clear();
          passwordController.clear();
        });
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

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    TextStyle textStyle = Theme.of(context).textTheme.displayLarge!;
    ThemeData themeData = Theme.of(context);
    TextStyle textStyleLarge = Theme.of(context).textTheme.titleMedium!;
    TextStyle textStyleMedium = Theme.of(context).textTheme.displayLarge!;

    TextStyle textStyleSmall = Theme.of(context).textTheme.displaySmall!;
  
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: SafeArea(
        child: FutureBuilder<List<UserData>?>(
          future: userDataFuture,
          builder: (context, snapshot) {
      
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Veri yok", style: TextStyle(color: Colors.white)),
              );
            } else {
              final userData = snapshot.data![0];
         
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(
                        16.0), // İhtiyaca göre kenar boşluğunu ayarlayın
                    child: Stack(
                      alignment: Alignment
                          .center, // Stack içindeki elemanları merkeze hizala
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(16.0), // Resim için radius
                          child: const Image(
                            image:
                                AssetImage("assets/home/profilegradient.jpg"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Column içindeki elemanları ortala
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/home/userprofileicon.jpg'),
                            ),
                            ListTile(
                              title: Text(
                                userData.fullName,
                                style: textStyleLarge,
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                "Standart Üye",
                                style: textStyleSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Container(
                              color: themeData.secondaryHeaderColor,
                              height: 32.0, // Çıkıntının yüksekliğini ayarlayın
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: themeData.secondaryHeaderColor,
                      borderRadius:
                          BorderRadius.circular(20.0), // Radius eklemek için
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "What is Lorem Ipsum?",
                              style: textStyleMedium,
                            ),
                            subtitle: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                              style: textStyleSmall,
                            ),
                          ),
                          RowWithSpaceBetween(
                            icon: Icons.email,
                            text: userData.email,
                            textStyle: textStyle,
                          ),
                          RowWithSpaceBetween(
                            icon: Icons.phone,
                            text: userData.phone ?? "Phone",
                            textStyle: textStyle,
                          ),
                          RowWithSpaceBetween(
                            icon: Icons.person,
                            text: '${userData.dateJoined}'.substring(0,10),
                            textStyle: textStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: oldPasswordController,
                              obscureText: true,
                              style: textStyle,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: themeData
                                          .primaryColor), // Border rengi
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                labelText: "Old Password",
                                labelStyle: textStyleSmall,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              style: textStyle,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: themeData
                                          .primaryColor), // Border rengi
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                labelText: "New Password",
                                labelStyle: textStyleSmall,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style:  TextStyle(
                        color: errorColor,
                        fontSize: 16,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            updatePassword();
                          }
                        },
                        child: const SizedBox(
                            height: 30,
                            width: 130,
                            child: Center(
                                child: Text(
                              "Change Password",
                              style: TextStyle(color: Colors.greenAccent),
                            ))),
                      ),
                      InkWell(
                        onTap: () {
                          AuthService().deleteAuthToken();
                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const HomePage(),
                            transitionDuration: const Duration(seconds: 0),
                          ));
                        },
                        child: const SizedBox(
                            height: 30,
                            width: 100,
                            child: Center(
                                child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.redAccent),
                            ))),
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

class RowWithSpaceBetween extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle textStyle;

  const RowWithSpaceBetween({
    super.key,
    required this.icon,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 16.0),
              Text(text,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8.0), // Her Row arasına boşluk ekler
        ],
      ),
    );
  }
}
