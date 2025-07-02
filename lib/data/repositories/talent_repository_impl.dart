import '../../domain/repository/talent_repository.dart';
import '../data_source/remote/talent_rds.dart';
import '../models/saved_talents/saved_talent_res.dart';
import '../models/saved_talents/toggle_talent_save_req.dart';
import '../models/saved_talents/toggle_talent_save_res.dart';

class TalentRepositoryImpl implements TalentRepository {

  final TalentRemoteDataSource remoteDataSource = TalentRemoteDataSource();


  @override
  Future<SavedTalentsResponse> getSavedTalents() async {
    try {
      return await remoteDataSource.fetchSavedTalents();
    } catch (e) {
      throw Exception('Failed to fetch saved talents: $e');
    }
  }

  @override
  Future<ToggleTalentSaveResponse> toggleSaveTalent(ToggleTalentSaveRequest request) async {
    try {
      return await remoteDataSource.toggleSaveTalent(request);
    } catch (e) {
      throw Exception('Failed to toggle saved talent: $e');
    }
  }
}
