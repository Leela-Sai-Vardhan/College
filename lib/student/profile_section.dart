import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vrsec_admin/services/firestore_service.dart';

import '../models/user_model.dart';

class ProfileSection extends StatelessWidget {
  final FirestoreService firestoreService =
      FirestoreService(); // Firestore service instance

  ProfileSection({Key? key}) : super(key: key);

  // Method to upload profile picture
  Future<void> _updateProfilePicture(
      BuildContext context, String userId) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final file = File(pickedImage.path);

      // Display a loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // Upload image to Firebase Storage and get the download URL
        String imageUrl = await firestoreService.uploadProfilePicture(
          userId: userId,
          filePath: file.path,
        );

        // Update Firestore with the new profile picture URL
        await firestoreService.updateUserDetails(
          userId,
          {"profilePicture": imageUrl},
        );

        Navigator.pop(context); // Close the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile picture updated!")),
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  // Method to show input dialog and update Firestore
  Future<void> _showUpdateDialog(BuildContext context, String title,
      String fieldKey, String userId) async {
    final TextEditingController controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter your $title"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newValue = controller.text.trim();
                if (newValue.isNotEmpty) {
                  // Update Firestore
                  await firestoreService.updateUserDetails(
                    userId,
                    {fieldKey: newValue},
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$title updated successfully!")),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the UserModel using Provider
    final userModel = Provider.of<UserModel>(context);

    // Mock data for profile completion cards
    final List<ProfileCard> profileCompletionCards = [
      ProfileCard(
        icon: Icons.account_circle,
        title: 'Personal Info',
        buttonText: 'Complete',
        onPressed: () => _showUpdateDialog(
            context, 'Personal Info', 'personalInfo', userModel.userId),
      ),
      ProfileCard(
        icon: Icons.location_on,
        title: 'Address',
        buttonText: 'Update',
        onPressed: () =>
            _showUpdateDialog(context, 'Address', 'address', userModel.userId),
      ),
      ProfileCard(
        icon: Icons.phone,
        title: 'Phone',
        buttonText: 'Add',
        onPressed: () =>
            _showUpdateDialog(context, 'Phone', 'phone', userModel.userId),
      ),
    ];

    // Mock data for custom list tiles
    final List<CustomListTile> customListTiles = [
      CustomListTile(icon: Icons.notifications, title: 'Notifications'),
      CustomListTile(icon: Icons.language, title: 'Language Preferences'),
      CustomListTile(icon: Icons.lock, title: 'Security Settings'),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("PROFILE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Settings action
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => _updateProfilePicture(context, userModel.userId),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: userModel.profilePicture.isNotEmpty
                      ? NetworkImage(userModel.profilePicture)
                      : const AssetImage("assets/images/default_user_icon.png")
                          as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userModel.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(userModel.email),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Branch :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: userModel.branch.isEmpty
                    ? null
                    : userModel.branch, // Current branch
                items: [
                  'Computer Science',
                  'Mechanical Engineering',
                  'Civil Engineering',
                  'Electrical Engineering',
                  'Electronics and Communication',
                ].map((branch) {
                  return DropdownMenuItem(
                    value: branch,
                    child: Text(branch),
                  );
                }).toList(),
                onChanged: (value) async {
                  if (value != null) {
                    userModel.updateUser(
                      userId: userModel.userId,
                      username: userModel.username,
                      email: userModel.email,
                      branch: value,
                    );
                    await firestoreService.updateUserDetails(
                      userModel.userId,
                      {'branch': value}, // Update branch in Firestore
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Branch updated to $value")),
                    );
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "Complete your profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "(1/5)",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 7,
                  margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == 0 ? Colors.blue : Colors.black12,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 160,
                  child: Card(
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Icon(
                            card.icon,
                            size: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card.title,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: card.onPressed,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(card.buttonText),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length,
            ),
          ),
          const SizedBox(height: 35),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(tile.icon),
                    title: Text(tile.title),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Define classes for profile completion cards
class ProfileCard {
  final IconData icon;
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  ProfileCard({
    required this.icon,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });
}

class CustomListTile {
  final IconData icon;
  final String title;

  CustomListTile({
    required this.icon,
    required this.title,
  });
}
