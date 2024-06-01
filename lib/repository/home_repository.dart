import 'package:provider_mvm/data/network/base_api_services.dart';
import 'package:provider_mvm/data/network/network_api_services.dart';
import 'package:provider_mvm/model/products_model.dart';
import 'package:provider_mvm/res/components/app_url.dart';

class HomeRepository {
  BaseApiServices apiServices = NetworkApiServices();
  Future<ProductsModel> fetchProductsList() async {
    try {
      dynamic response =
          await apiServices.getGetApiResponse(AppUrl.productsEndPoint);
      return response = ProductsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
