class AuthState{}

class AuthInitialState extends AuthState{}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState{
  final String errorMessage;
  AuthFailureState({required this.errorMessage});
}

class AuthSuccessState extends AuthState{}