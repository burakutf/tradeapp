import 'package:flutter/material.dart';
import 'package:tradeapp/models/profile.dart';
import 'package:tradeapp/services/api_services.dart';
import 'package:tradeapp/widget/custom_app_bar.dart';

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

  @override
  void initState() {
    super.initState();
    userDataFuture = ApiService().getUserProfile();
  }

  // void _updateProfile() async {
  //   final updatedFields = <String, dynamic>{};
  //   if (firstNameController.text.isNotEmpty) {
  //     updatedFields['first_name'] = firstNameController.text;
  //   }
  //   if (lastNameController.text.isNotEmpty) {
  //     updatedFields['last_name'] = lastNameController.text;
  //   }
  //   if (phoneController.text.isNotEmpty) {
  //     updatedFields['phone'] = phoneController.text;
  //   }

  //   final updatedUserData = await ApiService().updateUserProfile(updatedFields);

  //   setState(() {
  //     firstNameController.text = updatedUserData.firstName;
  //     lastNameController.text = updatedUserData.lastName;
  //     phoneController.text = updatedUserData.phone ?? '';
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Profil güncellendi')),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleLarge!;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<List<UserData>?>(
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
            firstNameController.text = userData.firstName;
            lastNameController.text = userData.lastName;
            phoneController.text = userData.phone ?? '';

            return Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration:
                      InputDecoration(labelText: 'Ad', labelStyle: textStyle),
                  style: textStyle,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                      labelText: 'Soyad', labelStyle: textStyle),
                  style: textStyle,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: 'Telefon', labelStyle: textStyle),
                  style: textStyle,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Profil Güncelle"),
                ),
              ],
            );
          }
        },
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
