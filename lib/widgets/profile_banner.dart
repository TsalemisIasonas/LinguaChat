import 'package:flutter/material.dart';

import 'package:lingua_chat/services/sound_service.dart';

class ProfileBanner extends StatefulWidget {
  final String username;
  final String? avatarPath;
  final String userLevel;
  final Function(String newName) onNameChanged;
  final Function(String newAvatar) onAvatarChanged;

  const ProfileBanner({
    super.key,
    required this.username,
    required this.avatarPath,
    required this.userLevel,
    required this.onNameChanged,
    required this.onAvatarChanged,
  });

  @override
  State<ProfileBanner> createState() => _ProfileBannerState();
}

class _ProfileBannerState extends State<ProfileBanner> {
  void avatarPicker() async {
    final List<String> avatarPaths = List.generate(
      9,
      (index) => 'assets/lingua_avatars/avatar${index + 1}.png',
    );

    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatarPaths.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (_, i) {
              final path = avatarPaths[i];

              return GestureDetector(
                onTap: () => Navigator.pop(context, path),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(path, fit: BoxFit.cover),
                ),
              );
            },
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        AppSound.click.play();
        widget.onAvatarChanged(picked);
      });
    }
  }

  Future<void> editName() async {
    AppSound.click.play();
    final controller = TextEditingController(text: widget.username);

    final newName = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change name"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      widget.onNameChanged(newName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE3DFFF)),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 4),
            color: Color.fromARGB(60, 0, 0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              AppSound.click.play();
              avatarPicker();
            },
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFFE3DFFF),
              backgroundImage: widget.avatarPath != null
                  ? AssetImage(widget.avatarPath!)
                  : null,
              child: widget.avatarPath == null
                  ? const Icon(Icons.person, color: Color(0xFF444078), size: 48)
                  : null,
            ),
          ),

          const SizedBox(height: 14),

          GestureDetector(
            onTap: () {
              AppSound.click.play();
              editName();
            },
            child: Text(
              widget.username,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF444078),
              ),
            ),
          ),

          const SizedBox(height: 4),
          Text(
            "${widget.userLevel[0].toUpperCase()}${widget.userLevel.substring(1).toLowerCase()} Learner",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Color(0xFF5C5891),
            ),
          ),
        ],
      ),
    );
  }
}
