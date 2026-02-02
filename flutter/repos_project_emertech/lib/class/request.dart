class Request {
  int id;
  String fullname;
  String photo;
  int nrp;
  String program;

  Request(
    {
      required this.id,
      required this.fullname,
      required this.photo,
      required this.nrp,
      required this.program,
    }
  );

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],  
      fullname: json['fullname'], 
      photo: json['photo'], 
      nrp: json['nrp'], 
      program: json['program'], 
    );
  }
}