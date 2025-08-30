import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/appointment.dart';
import '../models/review.dart' as review_model;

class MockDatabaseService {
  // Mock physiotherapist users
  static final List<User> _mockPhysiotherapists = [
    User(
      id: '2',
      email: 'sarah.wilson@physio.com',
      name: 'Dr. Sarah Wilson',
      phone: '+1234567891',
      userType: UserType.physiotherapist,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      specialization: 'Sports Physiotherapy',
      experienceYears: 8,
      hourlyRate: 80.0,
      qualifications: 'DPT, Sports Medicine',
      licenseNumber: 'PT12345',
      isVerified: true,
      certificates: [
        'Certified Sports Physiotherapist',
        'Manual Therapy Specialist'
      ],
      bio:
          'Specialized in sports injuries and rehabilitation. Former team physiotherapist for professional athletes.',
      rating: 4.8,
      totalReviews: 125,
      availableDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      workingHours: '9:00 AM - 6:00 PM',
    ),
    User(
      id: '3',
      email: 'michael.johnson@physio.com',
      name: 'Dr. Michael Johnson',
      phone: '+1234567892',
      userType: UserType.physiotherapist,
      createdAt: DateTime.now().subtract(const Duration(days: 400)),
      specialization: 'Orthopedic Physiotherapy',
      experienceYears: 12,
      hourlyRate: 95.0,
      qualifications: 'DPT, Orthopedic Specialist',
      licenseNumber: 'PT67890',
      isVerified: true,
      certificates: ['Orthopedic Specialist', 'Pain Management Certified'],
      bio:
          'Expert in post-surgical rehabilitation and chronic pain management. 12+ years helping patients recover.',
      rating: 4.9,
      totalReviews: 87,
      availableDays: ['Monday', 'Wednesday', 'Friday', 'Saturday'],
      workingHours: '8:00 AM - 5:00 PM',
    ),
    User(
      id: '4',
      email: 'emma.davis@physio.com',
      name: 'Dr. Emma Davis',
      phone: '+1234567893',
      userType: UserType.physiotherapist,
      createdAt: DateTime.now().subtract(const Duration(days: 300)),
      specialization: 'Neurological Physiotherapy',
      experienceYears: 6,
      hourlyRate: 75.0,
      qualifications: 'DPT, Neurological Specialist',
      licenseNumber: 'PT11111',
      isVerified: true,
      certificates: [
        'Neuro Physiotherapy Specialist',
        'Stroke Recovery Certified'
      ],
      bio:
          'Specialized in stroke recovery and neurological conditions. Compassionate care for complex cases.',
      rating: 4.7,
      totalReviews: 64,
      availableDays: ['Tuesday', 'Thursday', 'Friday', 'Saturday'],
      workingHours: '10:00 AM - 7:00 PM',
    ),
    User(
      id: '5',
      email: 'james.brown@physio.com',
      name: 'Dr. James Brown',
      phone: '+1234567894',
      userType: UserType.physiotherapist,
      createdAt: DateTime.now().subtract(const Duration(days: 250)),
      specialization: 'Pediatric Physiotherapy',
      experienceYears: 5,
      hourlyRate: 70.0,
      qualifications: 'DPT, Pediatric Specialist',
      licenseNumber: 'PT22222',
      isVerified: true,
      certificates: ['Pediatric Physiotherapy Specialist'],
      bio:
          'Gentle and patient care for children with developmental delays and injuries.',
      rating: 4.6,
      totalReviews: 43,
      availableDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday'],
      workingHours: '9:00 AM - 4:00 PM',
    ),
  ];

  // Mock appointments
  static final List<Appointment> _mockAppointments = [
    Appointment(
      id: 'apt1',
      patientId: '1',
      physiotherapistId: '2',
      appointmentDate: DateTime.now().add(const Duration(days: 2)),
      appointmentTime: '10:00 AM',
      type: AppointmentType.homeVisit,
      status: AppointmentStatus.confirmed,
      amount: 80.0,
      notes: 'Knee pain after running',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isPaid: true,
      address: '123 Main St, City, State',
    ),
    Appointment(
      id: 'apt2',
      patientId: '1',
      physiotherapistId: '3',
      appointmentDate: DateTime.now().subtract(const Duration(days: 7)),
      appointmentTime: '2:00 PM',
      type: AppointmentType.virtualConsultation,
      status: AppointmentStatus.completed,
      amount: 95.0,
      notes: 'Follow-up for back pain',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      isPaid: true,
      meetingLink: 'https://meet.google.com/abc-defg-hij',
    ),
  ];

  // Mock reviews
  static final List<review_model.Review> _mockReviews = [
    review_model.Review(
      id: 'rev1',
      appointmentId: 'apt2',
      patientId: '1',
      physiotherapistId: '3',
      rating: 5.0,
      comment:
          'Excellent service! Dr. Johnson was very professional and helped me understand my condition better.',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      patientName: 'John Doe',
    ),
  ];

  Future<List<User>> getPhysiotherapists({
    String? specialization,
    String? location,
    double? minRating,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    var filtered = List<User>.from(_mockPhysiotherapists);

    if (specialization != null && specialization.isNotEmpty) {
      filtered = filtered
          .where((physio) =>
              physio.specialization
                  ?.toLowerCase()
                  .contains(specialization.toLowerCase()) ??
              false)
          .toList();
    }

    if (location != null && location.isNotEmpty) {
      // For now, we'll filter by working hours as a proxy for location
      // In a real app, you'd have a location field
      filtered = filtered
          .where((physio) =>
              physio.workingHours
                  ?.toLowerCase()
                  .contains(location.toLowerCase()) ??
              false)
          .toList();
    }

    if (minRating != null) {
      filtered = filtered
          .where((physio) => (physio.rating ?? 0) >= minRating)
          .toList();
    }

    // Sort by rating (highest first)
    filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));

    return filtered;
  }

  Future<User?> getPhysiotherapistProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      return _mockPhysiotherapists.firstWhere((physio) => physio.id == userId);
    } catch (e) {
      return null;
    }
  }

  Future<Appointment> bookAppointment({
    required String patientId,
    required String physiotherapistId,
    required DateTime appointmentDate,
    required String appointmentTime,
    required AppointmentType type,
    required double amount,
    String? notes,
    String? address,
    String? clinicName,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    final newAppointment = Appointment(
      id: 'apt_${DateTime.now().millisecondsSinceEpoch}',
      patientId: patientId,
      physiotherapistId: physiotherapistId,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      type: type,
      status: AppointmentStatus.pending,
      amount: amount,
      notes: notes,
      createdAt: DateTime.now(),
      isPaid: false,
      address: address,
      clinicName: clinicName,
    );

    _mockAppointments.add(newAppointment);
    return newAppointment;
  }

  Future<List<Appointment>> getUserAppointments(String userId,
      {UserType? userType}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (userType == UserType.patient) {
      return _mockAppointments.where((apt) => apt.patientId == userId).toList();
    } else if (userType == UserType.physiotherapist) {
      return _mockAppointments
          .where((apt) => apt.physiotherapistId == userId)
          .toList();
    }

    return [];
  }

  Future<Appointment> updateAppointmentStatus(
      String appointmentId, AppointmentStatus status) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index =
        _mockAppointments.indexWhere((apt) => apt.id == appointmentId);
    if (index == -1) {
      throw Exception('Appointment not found');
    }

    final updatedAppointment = _mockAppointments[index].copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );

    _mockAppointments[index] = updatedAppointment;
    return updatedAppointment;
  }

  Future<bool> processPayment(String appointmentId,
      {required double amount}) async {
    // Simulate payment processing
    await Future.delayed(const Duration(milliseconds: 2000));

    final index =
        _mockAppointments.indexWhere((apt) => apt.id == appointmentId);
    if (index == -1) {
      throw Exception('Appointment not found');
    }

    // Mock payment success (90% success rate)
    final success = DateTime.now().millisecond % 10 != 0;

    if (success) {
      final updatedAppointment = _mockAppointments[index].copyWith(
        status: AppointmentStatus.confirmed,
        isPaid: true,
        updatedAt: DateTime.now(),
      );

      _mockAppointments[index] = updatedAppointment;
      return true;
    }

    return false;
  }

  Future<review_model.Review> addReview({
    required String appointmentId,
    required String patientId,
    required String physiotherapistId,
    required double rating,
    required String comment,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final newReview = review_model.Review(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      appointmentId: appointmentId,
      patientId: patientId,
      physiotherapistId: physiotherapistId,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    _mockReviews.add(newReview);

    // Update physiotherapist rating
    _updatePhysiotherapistRating(physiotherapistId);

    return newReview;
  }

  Future<List<review_model.Review>> getPhysiotherapistReviews(
      String physiotherapistId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockReviews
        .where((review) => review.physiotherapistId == physiotherapistId)
        .toList();
  }

  void _updatePhysiotherapistRating(String physiotherapistId) {
    final reviews = _mockReviews
        .where((review) => review.physiotherapistId == physiotherapistId)
        .toList();

    if (reviews.isNotEmpty) {
      // Calculate average rating (would be used to update database in real app)
      final averageRating =
          reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

      final index = _mockPhysiotherapists
          .indexWhere((physio) => physio.id == physiotherapistId);
      if (index != -1) {
        // In a real app, this would update the database with the new average rating
        // For now, we just calculate it but don't persist it in this mock
        // Using debugPrint instead of print for production code
        debugPrint(
            'Updated rating for physiotherapist $physiotherapistId: $averageRating');
      }
    }
  }

  // Mock video call functionality
  Future<String> startVideoCall(String appointmentId) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // Return a mock video call URL or session ID
    return 'mock_video_session_${appointmentId}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> endVideoCall(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock ending video call
  }
}
