import 'package:flutter/material.dart';
import 'package:profile_provider_static/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../screens/detail_profile.dart';
import '../models/profile.dart';

const List<String> quotes = [
  "Hidup adalah perjalanan, bukan tujuan.",
  "Jangan takut gagal, takutlah untuk tidak mencoba.",
  "Kamu lebih kuat dari yang kamu kira.",
  "Bahagia itu sederhana.",
  "Percaya proses.",
  "Jadilah versi terbaik dirimu.",
  "Senyum adalah kekuatanmu.",
  "Lakukan dengan hati.",
  "Setiap hari adalah awal yang baru.",
  "Bersyukurlah atas hal-hal kecil.",
];

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Profil"),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profiles = profileProvider.profiles;

          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(profile.profilePhoto),
                ),
                title: Text(profile.name),
                subtitle: Text(profile.phone),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailProfile(profile: profile),
                    ),
                  );

                  if (result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profil diperbarui")),
                    );
                  }
                },
                trailing: IconButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hapus Profil'),
                        content: const Text(
                          'Yakin ingin menghapus profil ini?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      context.read<ProfileProvider>().deleteProfile(index);
                    }
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final provider = context.read<ProfileProvider>();

          final int quoteIndex =
              DateTime.now().millisecondsSinceEpoch % quotes.length;
          int lastIndex = provider.profiles.length;
          int phoneSuffix = 1000 + lastIndex;

          final newProfile = Profile(
            name: 'Putri${lastIndex + 1}',
            quote: quotes[quoteIndex],
            phone: '+62812$phoneSuffix',
            profilePhoto: "https://i.pravatar.cc/150?img=${lastIndex + 1}",
            coverPhoto: 'https://picsum.photos/600/200?random=${lastIndex + 1}',
          );

          provider.addProfile(newProfile);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Friends"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Profile",
          ),
        ],
        onTap: (index) async {
          if (index == 0) {
            // tetap di halaman sekarang
            return;
          } else if (index == 1) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  final myProfile = context.read<ProfileProvider>().myProfile;
                  return DetailProfile(profile: myProfile);
                },
              ),
            );
            if (result != null && result is Profile) {
              context.read<ProfileProvider>().updateMyProfile(result);
            }
          }
        },
      ),
    );
  }
}
