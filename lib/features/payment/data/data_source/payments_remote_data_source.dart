import '../../../../core/network/app_api.dart';
import '../response/payments_response.dart';

abstract class RemotePaymentsDataSource {
  Future<PaymentsResponse> categories();
}

class RemotePaymentsDataSourceImplement implements RemotePaymentsDataSource {
  final AppApi _appApi;

  RemotePaymentsDataSourceImplement(this._appApi);

  @override
  Future<PaymentsResponse> categories() async {
    return await _appApi.paymentMethods();
  }
}
