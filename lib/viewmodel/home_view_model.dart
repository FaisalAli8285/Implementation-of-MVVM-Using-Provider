import 'package:flutter/foundation.dart';
import 'package:provider_mvm/data/response/api_response.dart';
import 'package:provider_mvm/model/products_model.dart';
import 'package:provider_mvm/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();
  ApiResponse<ProductsModel> productList = ApiResponse.loading();
  setProductsList(ApiResponse<ProductsModel> response) {
    productList = response;
    notifyListeners();
  }

  Future<void> fetchProductsApiList() async {
    setProductsList(ApiResponse.loading());
    homeRepository.fetchProductsList().then((value) {
      setProductsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProductsList(ApiResponse.error(error.toString()));
    });
  }
}
