import 'dart:async';

import 'package:flutter/services.dart';

import '../models/doctor_model.dart';

class MockDoctorService {
  // Singleton pattern
  static final MockDoctorService _instance = MockDoctorService._internal();
  factory MockDoctorService() => _instance;
  MockDoctorService._internal();

  // Mock data for Indian doctors
  final List<Doctor> _doctors = [
    Doctor(
      id: "1",
      name: "Dr. Priya Sharma",
      specialization: "Oncologist",
      location: "Mumbai, Maharashtra",
      hospital: "Tata Memorial Hospital",
      phone: "+91-9876543210",
      email: "priya.sharma@example.com",
      imageUrl: "https://randomuser.me/api/portraits/women/45.jpg",
      rating: 4.9,
      experience: "15 years",
      description:
          "Dr. Priya Sharma is a renowned oncologist specializing in breast cancer treatment with over 15 years of experience.",
    ),
    Doctor(
      id: "2",
      name: "Dr. Rajesh Gupta",
      specialization: "Surgical Oncologist",
      location: "Delhi, NCR",
      hospital: "All India Institute of Medical Sciences",
      phone: "+91-9876543211",
      email: "rajesh.gupta@example.com",
      imageUrl: "https://randomuser.me/api/portraits/men/65.jpg",
      rating: 4.8,
      experience: "20 years",
      description:
          "Dr. Rajesh Gupta is a highly skilled surgical oncologist with expertise in minimally invasive breast cancer surgeries.",
    ),
    Doctor(
      id: "3",
      name: "Dr. Anjali Desai",
      specialization: "Radiation Oncologist",
      location: "Bangalore, Karnataka",
      hospital: "Manipal Hospital",
      phone: "+91-9876543212",
      email: "anjali.desai@example.com",
      imageUrl: "https://randomuser.me/api/portraits/women/32.jpg",
      rating: 4.7,
      experience: "12 years",
      description:
          "Dr. Anjali Desai specializes in radiation therapy for breast cancer with a focus on reducing side effects and improving outcomes.",
    ),
    Doctor(
      id: "4",
      name: "Dr. Vikram Mehta",
      specialization: "Medical Oncologist",
      location: "Chennai, Tamil Nadu",
      hospital: "Apollo Hospitals",
      phone: "+91-9876543213",
      email: "vikram.mehta@example.com",
      imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      rating: 4.6,
      experience: "18 years",
      description:
          "Dr. Vikram Mehta is experienced in developing personalized chemotherapy regimens for breast cancer patients.",
    ),
    Doctor(
      id: "5",
      name: "Dr. Sunita Reddy",
      specialization: "Gynecologist",
      location: "Hyderabad, Telangana",
      hospital: "KIMS Hospitals",
      phone: "+91-9876543214",
      email: "sunita.reddy@example.com",
      imageUrl: "https://randomuser.me/api/portraits/women/58.jpg",
      rating: 4.9,
      experience: "16 years",
      description:
          "Dr. Sunita Reddy is known for her holistic approach to women's health with a special focus on breast health and screening.",
    ),
    Doctor(
      id: "6",
      name: "Dr. Arjun Singh",
      specialization: "Radiologist",
      location: "Kolkata, West Bengal",
      hospital: "Fortis Hospital",
      phone: "+91-9876543215",
      email: "arjun.singh@example.com",
      imageUrl: "https://randomuser.me/api/portraits/men/42.jpg",
      rating: 4.7,
      experience: "14 years",
      description:
          "Dr. Arjun Singh is an expert in breast imaging and early detection of breast abnormalities using advanced radiological techniques.",
    ),
    Doctor(
      id: "7",
      name: "Dr. Meera Patel",
      specialization: "Oncology Surgeon",
      location: "Ahmedabad, Gujarat",
      hospital: "HCG Cancer Centre",
      phone: "+91-9876543216",
      email: "meera.patel@example.com",
      imageUrl: "https://randomuser.me/api/portraits/women/22.jpg",
      rating: 4.8,
      experience: "19 years",
      description:
          "Dr. Meera Patel specializes in breast-conserving surgeries and reconstructive procedures with excellent cosmetic outcomes.",
    ),
    Doctor(
      id: "8",
      name: "Dr. Karthik Rajan",
      specialization: "Oncologist",
      location: "Pune, Maharashtra",
      hospital: "Ruby Hall Clinic",
      phone: "+91-9876543217",
      email: "karthik.rajan@example.com",
      imageUrl: "https://randomuser.me/api/portraits/men/55.jpg",
      rating: 4.6,
      experience: "13 years",
      description:
          "Dr. Karthik Rajan focuses on comprehensive cancer care with emphasis on supportive therapies alongside conventional treatments.",
    ),
  ];

  // Get all doctors
  Future<List<Doctor>> getDoctors() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _doctors;
  }

  // Get doctor by ID
  Future<Doctor?> getDoctorById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    try {
      return _doctors.firstWhere((doctor) => doctor.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search doctors by name or specialization
  Future<List<Doctor>> searchDoctors(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (query.isEmpty) return _doctors;

    query = query.toLowerCase();
    return _doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query) ||
          doctor.specialization.toLowerCase().contains(query) ||
          doctor.location.toLowerCase().contains(query);
    }).toList();
  }

  // Filter doctors by specialization
  Future<List<Doctor>> filterBySpecialization(String specialization) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (specialization.isEmpty) return _doctors;

    return _doctors.where((doctor) {
      return doctor.specialization.toLowerCase() ==
          specialization.toLowerCase();
    }).toList();
  }

  // Get doctor image by path
  Future<Uint8List?> getDoctorImage(String imagePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    try {
      // For mock purposes, we'll use a placeholder image from assets or network
      // In a real app, you might use different approaches

      // Option 1: If imagePath is a URL, you could return a placeholder image
      if (imagePath.startsWith('http')) {
        // Return a placeholder image bytes
        return await _getPlaceholderImageBytes();
      }

      // Option 2: If imagePath is a local asset path
      return await rootBundle.load(imagePath).then((byteData) {
        return byteData.buffer.asUint8List();
      });
    } catch (e) {
      // Return a default placeholder on error
      return await _getPlaceholderImageBytes();
    }
  }

  // Helper method to get a placeholder image
  Future<Uint8List> _getPlaceholderImageBytes() async {
    try {
      // Try to load a default placeholder from assets
      return await rootBundle
          .load('assets/images/doctor_placeholder.png')
          .then((byteData) {
        return byteData.buffer.asUint8List();
      });
    } catch (e) {
      // If asset loading fails, create a simple colored bytes array
      // This is just a fallback and creates a small colored square
      final bytes = Uint8List(100 * 100 * 4);
      for (int i = 0; i < bytes.length; i += 4) {
        // RGBA: Medium blue color
        bytes[i] = 100; // R
        bytes[i + 1] = 149; // G
        bytes[i + 2] = 237; // B
        bytes[i + 3] = 255; // A
      }
      return bytes;
    }
  }
}
