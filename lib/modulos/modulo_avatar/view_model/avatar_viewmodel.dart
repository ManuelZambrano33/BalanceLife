import 'package:flutter/material.dart';

class AvatarItem {
  final String imagePath;
  bool isLocked;

  AvatarItem({required this.imagePath, this.isLocked = false});
}

class AvatarViewModel extends ChangeNotifier {
  List<AvatarItem> skins = [
    AvatarItem(imagePath: 'assets/skin1.png', isLocked: false),
    AvatarItem(imagePath: 'assets/skin2.png', isLocked: true),
    AvatarItem(imagePath: 'assets/skin3.png', isLocked: false),
  ];

  List<AvatarItem> hairs = [
    AvatarItem(imagePath: 'assets/hair1.png'),
    AvatarItem(imagePath: 'assets/hair2.png', isLocked: true),
    AvatarItem(imagePath: 'assets/hair3.png', isLocked: true),
    AvatarItem(imagePath: 'assets/hair4.png', isLocked: false),
    AvatarItem(imagePath: 'assets/hair5.png', isLocked: false),
  ];

  List<AvatarItem> shirts = [
    AvatarItem(imagePath: 'assets/shirt1.png'),
    AvatarItem(imagePath: 'assets/shirt2.png', isLocked: true),
    AvatarItem(imagePath: 'assets/shirt3.png', isLocked: false),
    AvatarItem(imagePath: 'assets/shirt4.png', isLocked: true),
    AvatarItem(imagePath: 'assets/shirt5.png', isLocked: false),
    AvatarItem(imagePath: 'assets/shirt6.png', isLocked: true),
  ];

  List<AvatarItem> pants = [
    AvatarItem(imagePath: 'assets/pants1.png'),
    AvatarItem(imagePath: 'assets/pants2.png'),
    AvatarItem(imagePath: 'assets/pants3.png', isLocked: true),
    AvatarItem(imagePath: 'assets/pants4.png', isLocked: true),
    AvatarItem(imagePath: 'assets/pants6.png', isLocked: true),
  ];

  List<AvatarItem> faces = [
    AvatarItem(imagePath: 'assets/face1.png'),
  ];

  AvatarItem selectedSkin;
  AvatarItem selectedHair;
  AvatarItem selectedShirt;
  AvatarItem selectedPants;
  AvatarItem selectedFace;

  AvatarViewModel()
      : selectedSkin = AvatarItem(imagePath: 'assets/skin1.png'),
        selectedHair = AvatarItem(imagePath: 'assets/hair1.png'),
        selectedShirt = AvatarItem(imagePath: 'assets/shirt1.png'),
        selectedPants = AvatarItem(imagePath: 'assets/pants1.png'),
        selectedFace = AvatarItem(imagePath: 'assets/face1.png');

  void updateSelection(String category, AvatarItem item) {
    if (!item.isLocked) {
      switch (category) {
        case 'skin':
          selectedSkin = item;
          break;
        case 'hair':
          selectedHair = item;
          break;
        case 'shirt':
          selectedShirt = item;
          break;
        case 'pants':
          selectedPants = item;
          break;
        case 'face':
          selectedFace = item;
          break;
      }
      notifyListeners();
    }
  }
}
