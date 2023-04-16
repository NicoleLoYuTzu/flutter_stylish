import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product.dart';

class TextWithLineBloc extends Bloc<TextWithLineEvent, TextWithLineState> {
  late Future<List<ProductList>> _futureAllProductLists;

  TextWithLineBloc(this._futureAllProductLists) : super(TextWithLineState(0, 0));

  int _minQuantity = 0;
  int _maxQuantity = 0;

  String _selectedColor = '';
  String _selectedSize = '';
  String _selectedId = '';



  Stream<TextWithLineState> mapEventToState(TextWithLineEvent event) async* {
    if (event is ColorSelected) {
      _selectedColor = event.color;
      _selectedSize = event.size;
      _selectedId = event.id;
      _updateQuantity(_selectedColor, _selectedSize,_selectedId);
      yield TextWithLineState(_minQuantity, _maxQuantity);
    } else if (event is SizeSelected) {
      _selectedSize = event.size;
      _selectedId = event.id;
      _updateQuantity(_selectedColor, _selectedSize,_selectedId);
      yield TextWithLineState(_minQuantity, _maxQuantity);
    }
  }

  void _updateQuantity(String id, String color, String size) async {
    // Find the product that matches the given id
    final productList = (await _futureAllProductLists)
        .firstWhere((product) => product.id == int.parse(id));

    // Find the variant that matches the given color and size
    final variant = productList.variants.firstWhere(
            (variant) =>
        variant.colorCode == color && variant.size == size,
        orElse: () => Variant(colorCode: '', size: '', stock: 0));

    // Update the minimum and maximum quantity based on the variant's stock
    _minQuantity = 0;
    _maxQuantity = variant.stock;
    print("_maxQuantity => $_maxQuantity");
  }

  int getMaxQuantity() {
    return _maxQuantity;
  }

}

class TextWithLineState {
  final int minQuantity;
  final int maxQuantity;

  TextWithLineState(this.minQuantity, this.maxQuantity);
}

abstract class TextWithLineEvent {}

class ColorSelected extends TextWithLineEvent {
  final String id;
  final String color;
  final String size;

  ColorSelected(this.id, this.color, this.size);
}

class SizeSelected extends TextWithLineEvent {
  final String id;
  final String color;
  final String size;

  SizeSelected(this.color, this.size, this.id);
}
