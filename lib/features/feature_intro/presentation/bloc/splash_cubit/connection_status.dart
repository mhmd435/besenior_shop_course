part of 'splash_cubit.dart';

@immutable
abstract class ConnectionStatus {}

class ConnectionInitial extends ConnectionStatus {}

class ConnectionOn extends ConnectionStatus {}

class ConnectionOff extends ConnectionStatus {}
