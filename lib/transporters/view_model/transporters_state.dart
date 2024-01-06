part of 'transporters_bloc.dart';

// States
abstract class TransportersState extends Equatable {
  const TransportersState();
}

class TransportersInitial extends TransportersState {
  @override
  List<Object?> get props => [];
}

class TransportersLoading extends TransportersState {
  @override
  List<Object?> get props => [];
}

class TransportersLoaded extends TransportersState {
  final List<Transporter> transporters;

  const TransportersLoaded(this.transporters);

  @override
  List<Object?> get props => [transporters];
}

class TransportersError extends TransportersState {
  final String message;

  const TransportersError(this.message);

  @override
  List<Object?> get props => [message];
}
