import '../../../../core/network/app_api.dart';
import '../response/profile_response.dart';

abstract class RemoteProfileDataSource{
  Future<ProfileResponse> profile();
}

class RemoteProfileDataSourceImplement implements RemoteProfileDataSource {
  final AppApi _appApi;

  RemoteProfileDataSourceImplement(this._appApi);

  @override
  Future<ProfileResponse> profile() async{
    return await _appApi.profile();
  }

}