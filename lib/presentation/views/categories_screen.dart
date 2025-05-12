import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import 'products_by_category_screen.dart';
import '../../domain/models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ProductController controller = Get.find<ProductController>();
  String searchQuery = '';
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter categories based on search query
          final filteredCategories = controller.categories
              .where((category) =>
                  (category.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
                  (category.slug?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false))
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    // fontFamily: 'PlayfairDisplay',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(Icons.search, size: 28, color: Colors.black54),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Apple',
                            hintStyle: TextStyle(fontSize: 20, color: Colors.black54, fontFamily: 'Poppins'),
                          ),
                          style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '${filteredCategories.length} results found',
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    itemCount: filteredCategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return GestureDetector(
                        onTap: () async {
                          await controller.fetchProductsByCategory(category.url!);
                          Get.to(() => ProductsByCategoryScreen(category: category.name ?? 'UNCATEGORIZED'));
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage("https://cdn.shopify.com/s/files/1/0070/7032/articles/trending-products_adc026cf-c79e-46af-af6a-4370fbf9908a.png?v=1746629767"),

                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 16,
                              child: Text(
                                category.name ?? 'UNCATEGORIZED',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
