abstract class NavigatorStatus {
  const NavigatorStatus();
}

class InitialNavigatorStatus extends NavigatorStatus {
  const InitialNavigatorStatus();
}

class Progress extends NavigatorStatus {}

class Success extends NavigatorStatus {}

class FailureAuth extends NavigatorStatus {
  final String error;

  FailureAuth({required this.error});
}

class FailurePhoto extends NavigatorStatus {}

class SuccessPhoto extends NavigatorStatus {}

class OnSignUp extends NavigatorStatus {}

class OnSignIn extends NavigatorStatus {}

class OnNotesList extends NavigatorStatus {}

class OnNoteDetailed extends NavigatorStatus {}

class OnNoteIsEmpty extends NavigatorStatus {}
