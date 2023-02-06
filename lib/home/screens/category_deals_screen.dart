import 'package:flutter/material.dart';
import 'package:nodejs/common/widgets/loader.dart';
import 'package:nodejs/home/services/home_service.dart';

import '../../constants/global_variables.dart';
import '../../model/product.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category})',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList!.length,
                    padding: const EdgeInsets.only(left: 15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final product = productList![index];
                      return Column(children: [
                        SizedBox(
                          height: 130,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(product.images[0]),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 0,
                            top: 5,
                            right: 15,
                          ),
                          child: Text(product.name,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        )
                      ]);
                    },
                  ),
                )
              ],
            ),
    );
  }
}