import 'package:github_sign_in/github_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GithubService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GitHubSignIn _gitSignIn = GitHubSignIn();

  Future<String?> signInWithGitHub(context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: '77cc41d4dd2b16768634',
        clientSecret: '5c56b441176c36ea37e06b3ba20de4d1335be834',
        redirectUrl:
        'https://android-club-65a70.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);
    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token);
    // Once signed in, return the UserCredential

    final UserCredential authResult =
    await _auth.signInWithCredential(githubAuthCredential);

    final User user = authResult.user!;
    if (authResult.additionalUserInfo!.isNewUser) {
      if (user != null) {
        //You can her set data user in Fire store
        //Ex: Go to RegisterPage()
        return "New User";
      }
    }
    return "Old User";
  }

  Future<void> signOut() async {
    await _auth.signOut();
    //await _gitSignIn.signOut();

    print('User Signed Out!');
  }
}
