part of 'recent_bloc.dart';

abstract class RecentEvent extends Equatable {
  final Currency curr;

  const RecentEvent(this.curr);

  @override
  List<Object> get props => [curr];
}

class RecentAdd extends RecentEvent {
  const RecentAdd({Currency curr}) : super(curr);

  @override
  List<Object> get props => [curr];
}

class RecentRemove extends RecentEvent {
  const RecentRemove({Currency curr}) : super(curr);

  @override
  List<Object> get props => [curr];
}
