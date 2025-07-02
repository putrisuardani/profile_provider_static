import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/profile.dart';
import '../providers/profile_provider.dart';
import 'edit_profile.dart';

class DetailProfile extends StatefulWidget {
  final Profile profile;
  const DetailProfile({super.key, required this.profile});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  final List<String> gallery = [
    "https://picsum.photos/200?1",
    "https://picsum.photos/200?2",
    "https://picsum.photos/200?3",
    "https://picsum.photos/200?4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Profil")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.profile.coverPhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        widget.profile.profilePhoto,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 225,
                  bottom: -80,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.camera_alt, size: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 96),
            Center(
              child: Text(
                widget.profile.name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.pink[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    final Uri telUri = Uri(
                      scheme: 'tel',
                      path: widget.profile.phone,
                    );
                    launchUrl(telUri);
                  },
                  icon: Icon(Icons.call, size: 24, color: Colors.pink[200]),
                ),
                const SizedBox(width: 8),
                Icon(Icons.email, size: 24, color: Colors.pink[200]),
                const SizedBox(width: 16),
                Icon(Icons.share, size: 24, color: Colors.pink[200]),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 265,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: gallery.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              gallery[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Kata-kata hari ini...",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.pink[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.profile.quote,
                              style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Kembali ke Daftar"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final updatedProfile = await Navigator.push<Profile>(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProfile(profile: widget.profile),
                    ),
                  );
                  if (updatedProfile != null) {
                    final provider = Provider.of<ProfileProvider>(
                      context,
                      listen: false,
                    );
                    final index = provider.profiles.indexOf(widget.profile);
                    if (index != -1) {
                      provider.updateProfile(index, updatedProfile);
                      Navigator.pop(context, true);
                    }
                  }
                },
                child: const Text("Edit Profil"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
