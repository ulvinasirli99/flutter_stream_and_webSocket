import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream/domain/di/dependency_inject.dart';
import 'package:flutter_stream/domain/product_cubit/product_cubit.dart';
import 'package:flutter_stream/model/product.dart';
import 'package:flutter_stream/ui/widget/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt<ProductCubit>().getProductRestult();
  }

  @override
  void dispose() {
    super.dispose();
    getIt<ProductCubit>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<Product>(
          stream: getIt<ProductCubit>().productSubject,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.products?.length,
              itemBuilder: (context, index) {
                var product = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    width: double.infinity,
                    height: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "ID : ${product?.products?[index].id}",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:
                                    "Title : ${product?.products?[index].title}",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:
                                    "Description : ${product?.products?[index].description}",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:
                                    "Price : ${product?.products?[index].price} \$",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:
                                    "Brand : ${product?.products?[index].brand}",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:
                                    "Category : ${product?.products?[index].category}",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 150,
                            height: 100,
                            child: CarouselSlider.builder(
                              itemCount:
                                  product!.products![index].images!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return Container(
                                  width: 150,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        product.products![index]
                                            .images![itemIndex],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                aspectRatio: 0.3,
                                height: 150,
                                viewportFraction: 0.8,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }

}
