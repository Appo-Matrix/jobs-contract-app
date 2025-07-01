// certificate_repository_impl.dart

import '../../domain/repository/certificate_repository.dart';
import '../data_source/remote/certificate_rds.dart';
import '../models/certificate/add_certificate_req.dart';
import '../models/certificate/add_certificate_res.dart';
import '../models/certificate/delete_certificate_res.dart';
import '../models/certificate/get_user_certificates_res.dart';
import '../models/certificate/update_certificate_req.dart';
import '../models/certificate/update_certificate_res.dart';

class CertificateRepositoryImpl implements CertificateRepository {
  final CertificateRemoteDataSource remoteDataSource=CertificateRemoteDataSource();


  @override
  Future<AddCertificateResponse> addCertificate(AddCertificateRequest request) async {
    try {
      return await remoteDataSource.addCertificate(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Certificate>> getUserCertificates(String userId) async {
    try {
      return await remoteDataSource.getUserCertificates(userId);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<DeleteCertificateResponse> deleteCertificate(String certificateId) async {
    try {
      return await remoteDataSource.deleteCertificate(certificateId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdateCertificateResponse> updateCertificate(String id, UpdateCertificateRequest request) async {
    try {
      return await remoteDataSource.updateCertificate(id, request);
    } catch (e) {
      rethrow;
    }
  }
}
