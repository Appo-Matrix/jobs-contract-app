import '../../data/models/saved_talents/saved_talent_res.dart';
import '../../data/models/saved_talents/toggle_talent_save_req.dart';
import '../../data/models/saved_talents/toggle_talent_save_res.dart';

abstract class TalentRepository {

  Future<SavedTalentsResponse> getSavedTalents();

  Future<ToggleTalentSaveResponse> toggleSaveTalent(ToggleTalentSaveRequest request);


}
