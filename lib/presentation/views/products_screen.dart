import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/product_controller.dart';
import '../controllers/navigation_controller.dart';
import 'product_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with AutomaticKeepAliveClientMixin {
  final ProductController controller = Get.find<ProductController>();
  final NavigationController navigationController = Get.find<NavigationController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listener for bottom navigation changes
    ever(navigationController.currentIndex, (int index) {
      if (index == 0) { // 0 is the index for Products tab
        controller.fetchProducts();
      }
    });
    searchController.addListener(() {
      controller.searchProducts(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 28),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                ),
                style: TextStyle(fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Obx(() => Text(
                '${controller.filteredProducts.length} results found',
                style: TextStyle(color: Colors.grey[500], fontSize: 18),
              )),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredProducts.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: product.thumbnail ?? '',
                                width: 140,
                                height: 120,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  width: 140,
                                  height: 120,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 140,
                                  height: 120,
                                  color: Colors.grey[200],
                                  child: Icon(Icons.error, size: 40),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? 'No Title',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Text(
                                          (product.rating?.toStringAsFixed(1) ?? '0.0'),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        const SizedBox(width: 4),
                                        ...List.generate(5, (star) {
                                          double rating = product.rating ?? 0;
                                          return Icon(
                                            star < rating.round()
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                            size: 18,
                                          );
                                        }),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'By ${product.brand ?? 'Unknown'}',
                                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'In ${product.category ?? 'category'}',
                                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '24${product.price?.toStringAsFixed(0) ?? '0'}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),

    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final ProductController controller;

  ProductSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchProducts(query);
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.searchProducts(query);
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredProducts.isEmpty) {
        return const Center(child: Text('No products found'));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return GestureDetector(
            onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title ?? 'No Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
} 