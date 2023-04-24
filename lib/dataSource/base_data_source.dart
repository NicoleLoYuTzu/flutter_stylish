
import '../data/ProductDetailData.dart';
import '../data/ProductsDatum.dart';

abstract class BaseDataSource {
  Future<ProductsDatum> getWomenClothes();

  Future<ProductsDatum> getMenClothes();

  Future<ProductsDatum> getAccessories();

  Future<ProductDetailData> getProductContent(int id);
}
