enum TypeButton {
  filled("filled"),
  text("text"),
  border("border");
  

  final String type;

  const TypeButton(this.type);

  factory TypeButton.fromType(String type) {
    return values.firstWhere((element) => element.type == type);
  }
}