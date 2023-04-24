

import '../api_service.dart';
import '../data/ProductDetailData.dart';
import '../data/ProductsDatum.dart';
import 'base_data_source.dart';

class RemoteDataSource extends BaseDataSource {
  final ApiService _apiService = ApiService();

  @override
  Future<ProductsDatum> getWomenClothes() async {
    var response = await _apiService.getWomenClothes();
    return ProductsDatum.fromJson(response.data);
  }

  @override
  Future<ProductsDatum> getMenClothes() async {
    var response = await _apiService.getMenClothes();

    return ProductsDatum.fromJson(response.data);
  }

  @override
  Future<ProductsDatum> getAccessories() async {
    var response = await _apiService.getAccessories();

    return ProductsDatum.fromJson(response.data);
  }

  @override
  Future<ProductDetailData> getProductContent(int id) async {
    var response = await _apiService.getProductContent(id);

    return ProductDetailData.fromJson(response.data);
  }
}
