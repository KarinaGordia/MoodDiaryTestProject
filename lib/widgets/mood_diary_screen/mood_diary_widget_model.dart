import 'package:flutter/material.dart';
import 'package:mood_diary/app_lists/feelings.dart';
import 'package:mood_diary/entity/feeling.dart';

class MoodDiaryWidgetModel extends ChangeNotifier {
  MoodDiaryWidgetModel() {
    _feelings.addAll(AppLists.feelings);
  }

  final _feelings = <Feeling>[];

  List<Feeling> get feelings => _feelings.toList();

  final List<Feeling> _selectedFeelings = [];

  List<Feeling> get selectedFeelings => _selectedFeelings.toList();

  final List<String> _selectedSubFeelings = [];

  List<String> get selectedSubFeelings => _selectedSubFeelings.toList();

  final List<String> _displayedSubFeelings = [];

  List<String> get subFeelings => _displayedSubFeelings.toList();

  String _noteText = '';

  bool isDiaryFilled() {
    bool isFeelingSelected = _selectedFeelings.isNotEmpty;
    bool isSubFeelingSelected = _selectedSubFeelings.isNotEmpty;
    bool isNoteAdded = _noteText.trim().isNotEmpty;

    return isFeelingSelected && isSubFeelingSelected && isNoteAdded;
  }

  set noteText(String value) {
    final isTaskTextEmpty = _noteText.trim().isEmpty;
    _noteText = value;

    if(value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  }

  void selectFeeling(Feeling feeling) {
    feeling.isSelected = !feeling.isSelected;

    if (_selectedFeelings.contains(feeling)) {
      _selectedFeelings.remove(feeling);
    } else {
      _selectedFeelings.add(feeling);
    }

    notifyListeners();
  }

  void selectSubFeeling(String subFeeling, bool isSelected) {
    isSelected = !isSelected;
    if (_selectedSubFeelings.contains(subFeeling)) {
      _selectedSubFeelings.remove(subFeeling);
    } else {
      _selectedSubFeelings.add(subFeeling);
    }

    notifyListeners();
  }

  void getSubFeelingList() {
    _displayedSubFeelings.clear();
    for (var feeling in _selectedFeelings) {
      _displayedSubFeelings.addAll(feeling.subFeelings);
    }
  }
}

class MoodDiaryWidgetModelProvider extends InheritedNotifier {
  final MoodDiaryWidgetModel model;

  const MoodDiaryWidgetModelProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static MoodDiaryWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MoodDiaryWidgetModelProvider>();
  }

  static MoodDiaryWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<MoodDiaryWidgetModelProvider>()
        ?.widget;
    return widget is MoodDiaryWidgetModelProvider ? widget : null;
  }
}
