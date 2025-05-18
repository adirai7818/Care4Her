class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String location;
  final String hospital;
  final String phone;
  final String email;
  final String imageUrl;
  final double rating;
  final String experience;
  final String description;
  final bool isAvailable;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.hospital,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.rating,
    required this.experience,
    required this.description,
    this.isAvailable = true,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      location: json['location'],
      hospital: json['hospital'],
      phone: json['phone'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      experience: json['experience'],
      description: json['description'],
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'location': location,
      'hospital': hospital,
      'phone': phone,
      'email': email,
      'imageUrl': imageUrl,
      'rating': rating,
      'experience': experience,
      'description': description,
      'isAvailable': isAvailable,
    };
  }
}
