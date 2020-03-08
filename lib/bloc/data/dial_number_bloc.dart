import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DialNumberEvent extends Equatable {
  const DialNumberEvent();
}

class DialNumberAdd extends DialNumberEvent {
  final String number;

  DialNumberAdd(this.number);

  @override
  List<Object> get props => [number];
}

class DialNumberDelete extends DialNumberEvent {
  @override
  List<Object> get props => [];
}

class DialNumberBloc extends Bloc<DialNumberEvent, String> {
  @override
  String get initialState => '';

  @override
  Stream<String> mapEventToState(
    DialNumberEvent event,
  ) async* {
    if (event is DialNumberAdd) {
      if (state.contains('.') && event.number.contains('.')) {
        yield state;
      } else {
        yield state + event.number;
      }
    } else {
      yield '';
    }
  }
}
