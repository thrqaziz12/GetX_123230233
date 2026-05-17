import 'package:get/get.dart';
import '../model/product.dart';

class CartController extends GetxController {
  // State: daftar produk di keranjang menggunakan RxList
  final RxList<Product> _cartItems = <Product>[].obs;

  // State: jumlah (quantity) masing-masing produk berdasarkan id
  final RxMap<int, int> _quantities = <int, int>{}.obs;

  // Getter
  List<Product> get cartItems => _cartItems;
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + getQuantity(item.id));

  // Getter quantity produk berdasarkan id
  int getQuantity(int productId) => _quantities[productId] ?? 1;

  // Hitung total harga semua produk di keranjang (harga x qty)
  double get totalPrice => _cartItems.fold(
        0,
        (sum, item) => sum + item.price * getQuantity(item.id),
      );

  // Method: tambah produk ke keranjang
  void addToCart(Product product) {
    if (!isInCart(product)) {
      _cartItems.add(product);
      _quantities[product.id] = 1;
    } else {
      _quantities[product.id] = getQuantity(product.id) + 1;
    }
    _quantities.refresh();
    Get.snackbar(
      'Keranjang',
      '${product.title} ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Method: hapus produk dari keranjang berdasarkan index
  void removeFromCart(int index) {
    final product = _cartItems[index];
    _quantities.remove(product.id);
    _cartItems.removeAt(index);
  }

  // Method: tambah quantity produk
  void increaseQuantity(int productId) {
    _quantities[productId] = getQuantity(productId) + 1;
    _quantities.refresh();
  }

  // Method: kurangi quantity produk (minimum 1)
  void decreaseQuantity(int productId) {
    final current = getQuantity(productId);
    if (current > 1) {
      _quantities[productId] = current - 1;
      _quantities.refresh();
    }
  }

  // Method: cek apakah produk sudah ada di keranjang
  bool isInCart(Product product) {
    return _cartItems.any((item) => item.id == product.id);
  }
}
