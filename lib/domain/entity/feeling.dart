class Feeling {
  String name;
  String imagePath;
  bool isSelected = false;
  List<String> subFeelings;

  Feeling(
      {required this.name, required this.imagePath, required this.subFeelings,});
}