import 'package:provider/provider.dart';
import '../../features/auth/login/viewModel/loginViewModel.dart';
import '../../features/auth/signup/viewmodel/signupViewModel.dart';
import '../../features/profile/viewModel/profileViewModel.dart';
import '../../features/parentScreen/viewModel/parentScreenProvider.dart';
import '../../features/library/viewModel/legal_dictionary_view_model.dart';
import '../../features/library/viewModel/flashcard_view_model.dart';
import '../../features/library/viewModel/bare_acts_view_model.dart';
import '../../features/AllPackages/viewModel/package_view_model.dart';

class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<ParentScreenProvider>(
        create: (context) => ParentScreenProvider(),
      ),
      ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider<SignupViewModel>(
        create: (context) => SignupViewModel(),
      ),
      ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => ProfileViewModel(),
      ),
      ChangeNotifierProvider<LegalDictionaryViewModel>(
        create: (context) => LegalDictionaryViewModel(),
      ),
      ChangeNotifierProvider<FlashcardViewModel>(
        create: (context) => FlashcardViewModel(),
      ),
      ChangeNotifierProvider<BareActsViewModel>(
        create: (context) => BareActsViewModel(),
      ),
      ChangeNotifierProvider<PackageViewModel>(
        create: (context) => PackageViewModel(),
      ),
    ];
  }
}
