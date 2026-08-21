import 'package:provider/provider.dart';

import '../../features/parentScreen/viewModel/parentScreenProvider.dart';


class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<ParentScreenProvider>(
        create: (context) => ParentScreenProvider(),
      ),

    ];
  }
}