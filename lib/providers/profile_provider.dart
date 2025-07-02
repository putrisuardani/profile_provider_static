import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile _myProfile = Profile(
    name: 'Luh Gede Putri',
    phone: '+6281337136811',
    profilePhoto: 'https://i.pravatar.cc/150?img=25',
    coverPhoto: 'https://picsum.photos/600/200?xrandom=25',
    quote:
        '“Jangan jadi orang lucu karena ujung-ujungnya cuma enak dijadiin temen.”',
  );

  Profile get myProfile => _myProfile;

  final List<Profile> _profiles = [
    Profile(
      name: 'Putri Anjani',
      phone: '+6281234567890',
      profilePhoto: 'https://i.pravatar.cc/150?img=11',
      coverPhoto: 'https://picsum.photos/600/200?random=11',
      quote: '“Kalau kamu merasa hidup ini tidak adil, coba deh jadi tanaman.”',
    ),
    Profile(
      name: 'Dewi Saraswati',
      phone: '+6282234567891',
      profilePhoto: 'https://i.pravatar.cc/150?img=12',
      coverPhoto: 'https://picsum.photos/600/200?random=12',
      quote:
          '“Biarpun katanya nggak higienis, tapi makan di pinggir jalan masih jauh lebih sehat daripada makan di tengah jalan.”',
    ),
    Profile(
      name: 'Ayu Kartika',
      phone: '+6283234567892',
      profilePhoto: 'https://i.pravatar.cc/150?img=13',
      coverPhoto: 'https://picsum.photos/600/200?random=13',
      quote:
          '“Sebenarnya pelajaran matematika di Amerika lebih susah karena dicampur bahasa Inggris.”',
    ),
    Profile(
      name: 'Mega Wulandari',
      phone: '+6284234567893',
      profilePhoto: 'https://i.pravatar.cc/150?img=14',
      coverPhoto: 'https://picsum.photos/600/200?random=14',
      quote: '“Hidup itu harus seperti kopi, kuat, hangat, dan bikin melek.”',
    ),
    Profile(
      name: 'Sinta Rahayu',
      phone: '+6285234567894',
      profilePhoto: 'https://i.pravatar.cc/150?img=15',
      coverPhoto: 'https://picsum.photos/600/200?random=15',
      quote: '"Cintaku padamu seperti WiFi publik—lemah tapi nyambung."',
    ),
  ];

  List<Profile> get profiles => _profiles;

  void addProfile(Profile profile) {
    _profiles.add(profile);
    notifyListeners();
  }

  void updateProfile(int index, Profile profile) {
    _profiles[index] = profile;
    notifyListeners();
  }

  void deleteProfile(int index) {
    _profiles.removeAt(index);
    notifyListeners();
  }

  void updateMyProfile(Profile profile) {
    _myProfile = profile;
    notifyListeners();
  }
}
