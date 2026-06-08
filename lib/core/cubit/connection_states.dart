sealed class ConnectionStates{}

final class ConnectionStateInitial extends ConnectionStates{}
final class HaveConnectionWithNetwork extends ConnectionStates{}
final class HaveNotConnection extends ConnectionStates{}
final class HaveConnectionWithoutNetwork extends ConnectionStates{}

