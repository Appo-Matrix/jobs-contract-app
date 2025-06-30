// certificate_repository.dart

import '../../data/models/certificate/add_certificate_req.dart';
import '../../data/models/certificate/add_certificate_res.dart';
import '../../data/models/certificate/delete_certificate_res.dart';
import '../../data/models/certificate/get_user_certificates_res.dart';
import '../../data/models/certificate/update_certificate_req.dart';
import '../../data/models/certificate/update_certificate_res.dart';

abstract class CertificateRepository {

  Future<AddCertificateResponse> addCertificate(AddCertificateRequest request);

  Future<List<Certificate>> getUserCertificates(String userId);

  Future<DeleteCertificateResponse> deleteCertificate(String certificateId);

  Future<UpdateCertificateResponse> updateCertificate(String id, UpdateCertificateRequest request);

}
