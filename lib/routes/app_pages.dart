import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../view/pages/cart_page.dart';
import '../view/pages/product_detail_page.dart';
import '../view/pages/product_page.dart';
import 'app_routes.dart';

// Binding untuk ProductPage
class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    // CartController juga dipasang di sini agar tersedia di seluruh app
    Get.put<CartController>(CartController(), permanent: true);
  }
}

// Binding untuk CartPage
class CartBinding extends Bindings {
  @override
  void dependencies() {
    // CartController sudah dipasang permanent di ProductBinding,
    // Get.find() cukup untuk mengaksesnya kembali
    Get.find<CartController>();
  }
}

// Daftar semua halaman/route dalam aplikasi
class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.products,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
  ];
}
