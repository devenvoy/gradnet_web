
class UserProfileResponse {
  final String id;
  final String name;
  final String email;
  final int? phoneNo;
  final int? verifyId;
  final String? profilePic;
  final String? backgroundPic;
  final bool verified;
  final bool plusMember;
  final String? aboutSelf;
  final String? collegeName;
  final String? course;
  final String? address;
  final String? dob;
  final String? gender;
  final List<String>? languages;
  final List<String>? skills;
  final String? industryType;
  final String? employee;
  final String? website;
  final String? department;
  final String? designation;
  final List<EducationDto> education;
  final List<ExperienceDto> experience;
  final List<URLDto> urls;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String accessToken;

  UserProfileResponse({
    required this.id,
    this.name = "",
    this.email = "",
    this.phoneNo,
    this.verifyId,
    this.profilePic = "",
    this.backgroundPic = "",
    this.verified = false,
    this.plusMember = false,
    this.aboutSelf = "",
    this.collegeName = "",
    this.course = "",
    this.address = "",
    this.dob = "",
    this.gender = "",
    this.languages = const [],
    this.skills = const [],
    this.industryType,
    this.employee,
    this.website,
    this.department,
    this.designation,
    this.education = const [],
    this.experience = const [],
    this.urls = const [],
    this.isActive = false,
    this.createdAt = "",
    this.updatedAt = "",
    this.accessToken = "",
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      id: json['id'],
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phoneNo: json['phone_no'],
      verifyId: json['verify_id'],
      profilePic: json['profile_pic'],
      backgroundPic: json['background_pic'],
      verified: json['verified'] ?? false,
      plusMember: json['plus_member'] ?? false,
      aboutSelf: json['about_self'],
      collegeName: json['college_name'],
      course: json['course'],
      address: json['address'],
      dob: json['dob'],
      gender: json['gender'],
      languages: List<String>.from(json['languages'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      industryType: json['industry_type'],
      employee: json['employee'],
      website: json['website'],
      department: json['department'],
      designation: json['designation'],
      education: (json['education'] as List<dynamic>?)?.map((e) => EducationDto.fromJson(e)).toList() ?? [],
      experience: (json['experience'] as List<dynamic>?)?.map((e) => ExperienceDto.fromJson(e)).toList() ?? [],
      urls: (json['urls'] as List<dynamic>?)?.map((e) => URLDto.fromJson(e)).toList() ?? [],
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      accessToken: json['access_token'] ?? "",
    );
  }
}

class EducationDto {
  final String schoolName;
  final String? degree;
  final String? fieldOfStudy;
  final String? location;
  final String? description;
  final String? startDate;
  final String? endDate;

  EducationDto({
    required this.schoolName,
    this.degree = "",
    this.fieldOfStudy = "",
    this.location = "",
    this.description = "",
    this.startDate,
    this.endDate,
  });

  factory EducationDto.fromJson(Map<String, dynamic> json) {
    return EducationDto(
      schoolName: json['institution'],
      degree: json['degree'],
      fieldOfStudy: json['field_of_study'],
      location: json['location'],
      description: json['description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class ExperienceDto {
  final int? id;
  final String jobTitle;
  final String? jobType;
  final String? companyName;
  final String? location;
  final String? jobDescription;
  final String? startDate;
  final String? endDate;

  ExperienceDto({
    this.id = 0,
    required this.jobTitle,
    this.jobType = "",
    this.companyName = "",
    this.location = "",
    this.jobDescription = "",
    this.startDate,
    this.endDate,
  });

  factory ExperienceDto.fromJson(Map<String, dynamic> json) {
    return ExperienceDto(
      id: json['id'],
      jobTitle: json['job_title'],
      jobType: json['job_type'],
      companyName: json['company_name'],
      location: json['location'],
      jobDescription: json['job_description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}

class URLDto {
  final String type;
  final String? url;

  URLDto({
    required this.type,
    this.url,
  });

  factory URLDto.fromJson(Map<String, dynamic> json) {
    return URLDto(
      type: json['url_type'],
      url: json['url'],
    );
  }
}
