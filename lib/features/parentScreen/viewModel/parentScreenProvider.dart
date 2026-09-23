import 'package:flutter/material.dart';

class ParentScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _libraryTabIndex = 0;

  int get currentIndex => _currentIndex;
  int get libraryTabIndex => _libraryTabIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setLibraryTab(int index) {
    _libraryTabIndex = index;
    _currentIndex = 1; // 1 is the index for LibraryScreen in ParentScreen
    notifyListeners();
  }
}
