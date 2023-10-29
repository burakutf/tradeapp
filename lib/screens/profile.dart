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
  int? userId;
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

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // Anahtar oluştur

  void updatePassword() async {
    final response = await ApiService().updatePassword(
        oldPassword: oldPasswordController.text,
        newPassword: passwordController.text);

    if (response != null) {
      if (response.containsKey('message')) {
        setState(() {
          _errorMessage = "Changed Password";
          errorColor = Colors.greenAccent;
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

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String title, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Kullanıcı ekranın dışına tıklayarak kapatamaz
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await ApiService().removeUserProfile(userId);
                AuthService().deleteAuthToken();
                _navigateToHome();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const HomePage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.displayLarge!;
    ThemeData themeData = Theme.of(context);
    TextStyle textStyleLarge = Theme.of(context).textTheme.titleMedium!;

    TextStyle textStyleSmall = Theme.of(context).textTheme.displaySmall!;

    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: const CustomBottomAppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:64.0),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    // Column kullanarak alt alta sıralama
                    children: [
                      TextFormField(
                        controller: oldPasswordController,
                        obscureText: true,
                        style: textStyle,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: themeData.primaryColor,
                            ), // Border rengi
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: textStyle,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: themeData.primaryColor,
                            ), // Border rengi
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
                      const SizedBox(
                        height: 10,
                      ),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: errorColor,
                            fontSize: 16,
                          ),
                        ),
                      ListTile(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            updatePassword();
                          }
                        },
                        leading: const Icon(
                          Icons.change_circle,
                          color: Colors.greenAccent,
                        ),
                        title: const SizedBox(
                          height: 30,
                          width: 130,
                          child: Center(
                            child: Text(
                              "Change Password",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
  
            Column(
              children: [
                ListTile(
                  onTap: () {
                    AuthService().deleteAuthToken();
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const HomePage(),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    );
                  },
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.redAccent,
                  ),
                  title: const SizedBox(
                    height: 30,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.redAccent,
                ),
                ListTile(
                  onTap: () {
                    _showDeleteConfirmationDialog(context, 'Delete Account',
                        'Are you sure you want to delete your account?');
                  },
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  title: const Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
                  AuthService().deleteAuthToken();
              return const Center(
                child: Text("Veri yok", style: TextStyle(color: Colors.white)),
              );
            } else {
              final userData = snapshot.data![0];
              userId = userData.id;
              return SingleChildScrollView(
                child: Column(
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
                            borderRadius: BorderRadius.circular(
                                16.0), // Resim için radius
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
                                backgroundImage: AssetImage(
                                    'assets/home/userprofileicon.jpg'),
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
                                height:
                                    32.0, // Çıkıntının yüksekliğini ayarlayın
                              ),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                  onPressed: () {
                                    scaffoldKey.currentState
                                        ?.openDrawer(); // Çekmeceyi açar
                                  },
                                  icon: const Icon(Icons.settings))),
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
                              text: '${userData.dateJoined}'.substring(0, 10),
                              textStyle: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
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
