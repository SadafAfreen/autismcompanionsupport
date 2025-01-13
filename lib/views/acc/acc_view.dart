import 'package:autismcompanionsupport/services/acc/acc_service.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/views/acc/add_category_overlay_view.dart';
import 'package:autismcompanionsupport/widgets/acc/add_pack_button.dart';
import 'package:autismcompanionsupport/widgets/acc/category_tile.dart';
import 'package:flutter/material.dart';
import 'category.dart';

class AccView extends StatefulWidget {

  const AccView({super.key});

  @override
  State<AccView> createState() => _AccViewState();
}

class _AccViewState extends State<AccView> {
  
  final ACCService accService = ACCService();
  final String userId = AuthService.firebase().currentUser!.id;
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = accService.fetchCategories(userId: userId);
  }

  void _reloadCategories() {
    setState(() {
      _categoriesFuture = accService.fetchCategories(userId: userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    void showAddCategoryOverlay(BuildContext context) {
      showDialog(
        context: context,
        barrierColor: Colors.black54, 
        builder: (BuildContext context) {
          return AddCategoryOverlay(
            onAddCategory: (category) async {
              try {
                await accService.addCategory(userId: userId, category: category);
                _reloadCategories();
                if(context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Category added successfully!')),
                  );
                }
              } catch (e) {
                if(context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add category')),
                  );
                }
              } 
            },
          );
        },
      );
    }

    return Scaffold(
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final categories = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: categories.length + 1, 
            itemBuilder: (context, index) {
              if (index == categories.length) {
                return AddPackButton(onAdd: () => showAddCategoryOverlay(context));
              }

              final category = categories[index];
              return CategoryTile(category: category);
            },
          );
        },
      ),
    );
  }
}
