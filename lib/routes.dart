import 'package:star_home/main.dart';
import 'package:star_home/pages/about_page.dart';
import 'package:star_home/pages/home_page.dart';
import 'package:star_home/pages/loading.dart';
import 'package:star_home/pages/login.dart';
import 'package:star_home/pages/onboarding_page.dart';
import 'package:star_home/pages/AdditionalRegiterationPage.dart';
import 'package:star_home/pages/password_change_page.dart';
import 'package:star_home/pages/profile_edit_page.dart';
import 'package:star_home/pages/profile_page.dart';
import 'package:star_home/pages/register_page.dart';
import 'package:star_home/pages/roomAdd.dart';

getRoutes() {
  return {
    Navigation.route: (context) => const Navigation(),
    AboutPage.route: (context) => const AboutPage(),
    AdditionalRegister.route: (context) => const AdditionalRegister(),
    HomePage.route: (context) => const HomePage(),
    LoadingPage.route: (context) => const LoadingPage(),
    RoomAdd.route: (context) => const RoomAdd(),
    LoginPage.route: (context) => const LoginPage(),
    OnboardingPage.route: (context) => const OnboardingPage(),
    RegisterPage.route: (context) => const RegisterPage(),
    PasswordChangePage.route: (context) => const PasswordChangePage(),
    ProfileEdit.route: (context) => const ProfileEdit(),
    ProfilePage.route: (context) => const ProfilePage(),

  };
}
