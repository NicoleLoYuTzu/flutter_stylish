import 'package:flutter_bloc/flutter_bloc.dart';

class TextWithLineBloc extends Bloc<TextWithLineEvent, TextWithLineState> {
  TextWithLineBloc() : super(TextWithLineState(0, 0));

  int _minQuantity = 0;
  int _maxQuantity = 0;

  @override
  Stream<TextWithLineState> mapEventToState(TextWithLineEvent event) async* {
    if (event is ColorSelected) {
      _updateQuantity(event.color, event.size);
      yield TextWithLineState(_minQuantity, _maxQuantity);
    } else if (event is SizeSelected) {
      _updateQuantity(event.color, event.size);
      yield TextWithLineState(_minQuantity, _maxQuantity);
    }
  }

  void _updateQuantity(String color, String size) {
    // 根據選擇的顏色和尺寸更新最小和最大數量
    // 例如：_minQuantity = ...
    // 例如：_maxQuantity = ...
  }
}

class TextWithLineState {
  final int minQuantity;
  final int maxQuantity;

  TextWithLineState(this.minQuantity, this.maxQuantity);
}

abstract class TextWithLineEvent {}

class ColorSelected extends TextWithLineEvent {
  final String color;
  final String size;

  ColorSelected(this.color, this.size);
}

class SizeSelected extends TextWithLineEvent {
  final String color;
  final String size;

  SizeSelected(this.color, this.size);
}
