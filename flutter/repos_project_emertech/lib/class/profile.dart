class Profile {
  String email;
  String fullname;
  String photo;
  int? nrp;
  String? program;
  String? biografi;

  Profile(
    {
      required this.email,
      required this.fullname,
      required this.photo,
      this.nrp,
      this.program,
      this.biografi
    }
  );

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'] ?? '',  
      fullname: json['fullname'] ?? '', 
      photo: json['photo'] ?? '', 
      nrp: json['nrp'] ?? 0, 
      program: json['program'] ?? '', 
      biografi: json['biografi'] ?? '',
    );
  }
}