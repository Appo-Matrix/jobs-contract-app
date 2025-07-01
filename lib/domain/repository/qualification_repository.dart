

import '../../data/models/education/education_model.dart';
import '../../data/models/education/qualification_model.dart';
import '../../data/models/education/qualification_request.dart';
import '../../data/models/education/qualification_response.dart';
import '../../data/models/education/user_education_model.dart';

abstract class QualificationRepository {

  Future<QualificationResponse> addQualification(QualificationRequest request);

  Future<void> deleteQualification(String eduId);

  Future<EducationModel> getQualificationById(String eduId);

  Future<EducationModel> updateQualification(String eduId, EducationModel data);

  Future<List<QualificationModel>> getQualificationsByUserId(String userId);

  Future<List<UserEducationModel>> getMyQualifications();


}
