import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/pages/product_details_page.dart';
import 'package:shoping_app/providers/products_provider.dart';
import 'package:shoping_app/widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late TextEditingController _searchController;
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _asyncMethod() {
    context.read<ProductProvider>().querryProductList();
  }

  selectFilters(String filter) {
    context.read<ProductProvider>().selectedFilter = filter;
  }

  searchProduct(String? q) {
    context.read<ProductProvider>().searchProduct(q!);
  }

  clearTextField() {
   _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    selectFilters(context.read<ProductProvider>().getSelectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = context.watch<ProductProvider>();
    var productsList = productProvider.getProductList;

    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(
            225,
            225,
            225,
            1,
          ),
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));

    return GestureDetector(
      onTap: () {
        clearTextField();
      
      },
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Shoes\nCollection",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      searchProduct(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Search",
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        selectFilters(filter);
                      },
                      child: Chip(
                        backgroundColor:
                            (productProvider.getSelectedFilter == filter)
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromRGBO(245, 247, 249, 1),
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        labelStyle: const TextStyle(fontSize: 16),
                        label: Text(
                          filter,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    itemCount: productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.75),
                    itemBuilder: (context, index) {
                      final product = productsList[index];
                      return ProductListItemWidget(
                        product: product,
                        index: index,
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: productsList.length,
                    itemBuilder: (context, index) {
                      final product = productsList[index];

                      return ProductListItemWidget(
                        product: product,
                        index: index,
                      );
                    },
                  );
                }

                // const Text("data");
              }),
            )
          ],
        ),
      ),
    );
  }
}

class ProductListItemWidget extends StatelessWidget {
  const ProductListItemWidget({super.key, required this.product, this.index});
  final Map<String, dynamic> product;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsPage(
                product: product,
              );
            },
          ),
        );
      },
      child: ProductCardWidget(
        productName: "${product["title"]}",
        price: "${product["price"]}",
        imageUrl: "${product["imageUrl"]}",
        backgroundColor: getProductCardBackGroundColor(index!),
      ),
    );
  }

  Color getProductCardBackGroundColor(int index) {
    if (index.isEven) {
      return const Color.fromRGBO(216, 240, 253, 1);
    } else {
      return const Color.fromRGBO(245, 247, 249, 1);
    }
  }
}
