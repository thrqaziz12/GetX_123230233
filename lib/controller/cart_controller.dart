import 'package:get/get.dart';
import '../model/product.dart';

class CartController extends GetxController {
  // State: daftar produk di keranjang menggunakan RxList
  final RxList<Product> _cartItems = <Product>[].obs;

  // Getter
  List<Product> get cartItems => _cartItems;
  int get itemCount => _cartItems.length;

  // Hitung total harga semua produk di keranjang
  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);

  // Method: tambah produk ke keranjang
  void addToCart(Product product) {
    _cartItems.add(product);
    Get.snackbar(
      'Keranjang',
      '${product.title} ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Method: hapus produk dari keranjang berdasarkan index
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
  }

  // Method: cek apakah produk sudah ada di keranjang
  bool isInCart(Product product) {
    return _cartItems.any((item) => item.id == product.id);
  }
}
