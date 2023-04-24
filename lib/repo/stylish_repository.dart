

import '../data/ProductDetailData.dart';
import '../data/ProductsDatum.dart';
import '../dataSource/base_data_source.dart';
import '../dataSource/remote_data_source.dart';
import 'base_repository.dart';

class StylishRepository extends BaseRepository {
  final BaseDataSource _remoteDataSource = RemoteDataSource();

  @override
  Future<ProductsDatum> getAccessories() => _remoteDataSource.getAccessories();

  @override
  Future<ProductsDatum> getMenClothes() => _remoteDataSource.getMenClothes();

  @override
  Future<ProductsDatum> getWomenClothes() =>
      _remoteDataSource.getWomenClothes();

  @override
  Future<ProductDetailData> getProductContent(int id) =>
      _remoteDataSource.getProductContent(id);
}
