import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_avatar/view_model/avatar_viewmodel.dart';
import 'package:provider/provider.dart';


class AvatarView extends StatefulWidget {
  const AvatarView({super.key});

  @override
  _AvatarViewState createState() => _AvatarViewState();
}

class _AvatarViewState extends State<AvatarView> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final avatarVM = Provider.of<AvatarViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          // NUEVA BARRA SUPERIOR PERSONALIZADA
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF437A9D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 120,
                  left: 35,
                  child: Text(
                    'Avatar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    /**child: Image.asset(
                      'assets/rafiki.png', 
                      fit: BoxFit.contain,
                    ),**/
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),


          Container(
            
            width: 250,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),

            ),
            child: Stack(
              children: [
                Image.asset(avatarVM.selectedSkin.imagePath, width: 250, height: 300),
                Image.asset(avatarVM.selectedShirt.imagePath, width: 250, height: 300),
                Image.asset(avatarVM.selectedPants.imagePath, width: 250, height: 300),
                
                Image.asset(avatarVM.selectedFace.imagePath, width: 250, height: 300),
                Image.asset(avatarVM.selectedHair.imagePath, width: 250, height: 300),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCategoryButton(context, Icons.face_retouching_natural, avatarVM.hairs, "hair", Colors.blue),
              buildCategoryButton(context, Icons.checkroom, avatarVM.shirts, "shirt", Colors.green),
              buildCategoryButton(context, Icons.dry_cleaning, avatarVM.pants, "pants", Colors.orange),
              buildCategoryButton(context, Icons.color_lens, avatarVM.skins, "skin", Colors.red),
            ],
          ),

         Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
              child: _selectedCategory != null
                  ? buildCategoryGrid(context, _selectedCategory!, avatarVM)
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(BuildContext context, IconData icon, List<AvatarItem> items, String category, Color color) {
    return IconButton(
      icon: Icon(icon, size: 30, color: color),
      onPressed: () {
        setState(() {
          _selectedCategory = (_selectedCategory == category) ? null : category;
        });
      },
    );
  }

  Widget buildCategoryGrid(BuildContext context, String category, AvatarViewModel avatarVM) {
    final items = category == "hair" ? avatarVM.hairs
        : category == "pants" ? avatarVM.pants
        : category == "shirt" ? avatarVM.shirts
        : avatarVM.skins;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            Provider.of<AvatarViewModel>(context, listen: false).updateSelection(category, item);
          },
          child: Opacity(
            opacity: item.isLocked ? 0.5 : 1.0,
            child: Column(
              children: [
                Image.asset(item.imagePath, width: 60, height: 60),
                Text(item.imagePath.split('/').last, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
