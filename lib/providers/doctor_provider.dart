import 'package:flutter/foundation.dart';

import '../models/doctor_model.dart';
import '../services/mock_doctor_service.dart';

class MockDoctorProvider with ChangeNotifier {
  final MockDoctorService _doctorService = MockDoctorService();

  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Constructor to initialize with mock data
  MockDoctorProvider() {
    // Initialize with mock data immediately
    fetchDoctors();
  }

  List<Doctor> get doctors => _doctors;
  List<Doctor> get filteredDoctors => _filteredDoctors;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch all doctors from mock service
  Future<void> fetchDoctors() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Use mock data directly
      _doctors = await _doctorService.getDoctors();
      _filteredDoctors = List.from(_doctors);
    } catch (error) {
      _errorMessage = 'Failed to load doctors: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get doctor by ID from mock data
  Future<Doctor?> getDoctorById(String id) async {
    try {
      return await _doctorService.getDoctorById(id);
    } catch (error) {
      _errorMessage = 'Failed to load doctor: ${error.toString()}';
      notifyListeners();
      return null;
    }
  }

  // Get doctor image from mock data
  Future<Uint8List?> getDoctorImage(String imagePath) async {
    try {
      return await _doctorService.getDoctorImage(imagePath);
    } catch (error) {
      _errorMessage = 'Failed to load doctor image: ${error.toString()}';
      notifyListeners();
      return null;
    }
  }

  // Search doctors in mock data
  Future<void> searchDoctors(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (query.isEmpty) {
        _filteredDoctors = List.from(_doctors);
      } else {
        _filteredDoctors = await _doctorService.searchDoctors(query);
      }
    } catch (error) {
      _errorMessage = 'Search failed: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter by specialization in mock data
  Future<void> filterBySpecialization(String specialization) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (specialization.isEmpty) {
        _filteredDoctors = List.from(_doctors);
      } else {
        _filteredDoctors =
            await _doctorService.filterBySpecialization(specialization);
      }
    } catch (error) {
      _errorMessage = 'Filter failed: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter by location
  void filterByLocation(List<String> locations) {
    if (locations.isEmpty) {
      _filteredDoctors = List.from(_doctors);
    } else {
      _filteredDoctors = _doctors.where((doctor) {
        final doctorLocation = doctor.location.toLowerCase();
        return locations
            .any((location) => doctorLocation.contains(location.toLowerCase()));
      }).toList();
    }
    notifyListeners();
  }

  // Reset filters
  void resetFilters() {
    _filteredDoctors = List.from(_doctors);
    notifyListeners();
  }
}
