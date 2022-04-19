class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class MyUserData {
  final String uid;
  final String name;
  final String email;
  final String personaID;
  final String personaname;
  final String personaDescription;

  MyUserData(
      {required this.uid,
      required this.name,
      required this.email,
      required this.personaID,
      required this.personaname,
      required this.personaDescription});
}
