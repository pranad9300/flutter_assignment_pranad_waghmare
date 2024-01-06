part of 'transporters_bloc.dart';

// Events
abstract class TransportersEvent extends Equatable {
  const TransportersEvent();
}

class SearchTransporters extends TransportersEvent {
  final String query;

  const SearchTransporters(this.query);

  @override
  List<Object?> get props => [query];
}
