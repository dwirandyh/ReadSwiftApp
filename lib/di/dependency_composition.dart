import 'package:authentication/authentication.dart';
import 'package:user/user.dart';

class DependencyComposition {
  static void setup() {
    AuthenticationDI.setup();
    UserDI.setup();
  }
}
