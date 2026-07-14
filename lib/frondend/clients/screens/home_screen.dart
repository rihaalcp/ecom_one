import 'package:flutter/material.dart';
import '../../admin/screen/login_content_screen.dart';
import '../../admin/screen/register_content_screen.dart';
import '../../theme/app_colors.dart';
import '../../category.dart';
import '../models/product.dart';
import '../services/auth_service.dart';
import '../widgets/product_card.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../../../backend/database/mongo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final _searchController = TextEditingController();

  ValueChanged<int>? get _onNavTap => null;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openGated(Widget destination) {
    if (AuthService.instance.isLoggedIn) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => destination));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  // void _onNavTap(int index) {
  //   // 0 Home, 1 Categories, 2 Wishlist, 3 Cart, 4 Profile
  //   if (index == 3) {
  //     _openGated(const CartScreen());
  //     return;
  //   }
  //   if (index == 4) {
  //     _openGated(const ProfileScreen());
  //     return;
  //   }
  //   setState(() => _navIndex = index);
  // }

  void _goToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  void _goToRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen()));
  }

  void _goToAdmin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Admin CMS"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Edit Login Page CMS"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginContentPage()),
                );
              },
            ),
            ListTile(
              title: const Text("Edit Register Page CMS"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterContentPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = AuthService.instance.isLoggedIn;
    final role = AuthService.instance.role;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Lumina'),
        actions: [
          if (isLoggedIn && role == "admin")
            TextButton(
              onPressed: _goToAdmin,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.onSurface,
              ),
              child: const Text(
                "Admin",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(width: 6),
          if (!isLoggedIn) ...[
            TextButton(
              onPressed: _goToLogin,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.onSurface,
              ),
              child: const Text('Login',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 4),
            OutlinedButton(
              onPressed: _goToRegister,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('Register',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 8),
          ],
          // IconButton(
          //   icon: const Icon(Icons.shopping_cart_outlined),
          //   onPressed: () => _openGated(const CartScreen()),
          // ),
          // IconButton(
          //   icon: const Icon(Icons.person_outline),
          //   onPressed: () => _openGated(const ProfileScreen()),
          // ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingAndSearch(),
              const SizedBox(height: 24),
              _buildHeroBanner(),
              const SizedBox(height: 28),
              _buildCategories(),
              const SizedBox(height: 28),
              _buildFlashSale(),
              const SizedBox(height: 28),
              _buildFeaturedProducts(),
              const SizedBox(height: 28),
              _buildPopularBrands(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildGreetingAndSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hello, User 👋',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('Find your style today.',
            style: TextStyle(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon:
                  const Icon(Icons.search, color: AppColors.outlineVariant),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: const Icon(Icons.tune, color: AppColors.onSurface),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text('SUMMER COLLECTION',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6)),
          ),
          const SizedBox(height: 12),
          const Text('Up to 50% OFF',
              style: TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('On selected luxury essentials.',
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              minimumSize: const Size(120, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Shop Now',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            TextButton(
              onPressed: () {},
              child: const Text('See All', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: CategoryCatalog.all.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final c = CategoryCatalog.all[index];
              return Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(c.icon, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(c.label, style: const TextStyle(fontSize: 12)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlashSale() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('Flash Sale',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          size: 12, color: AppColors.onErrorContainer),
                      SizedBox(width: 4),
                      Text('02:14:55',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onErrorContainer)),
                    ],
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ProductCatalog.flashSale.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) =>
                FlashSaleCard(product: ProductCatalog.flashSale[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Featured Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ProductCatalog.featured.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.57,
          ),
          itemBuilder: (context, index) =>
              ProductCard(product: ProductCatalog.featured[index]),
        ),
      ],
    );
  }

  Widget _buildPopularBrands() {
    const brands = ['NOIR', 'VELO', 'KASA', 'PURE', 'CORE'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Popular Brands',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 28),
            itemBuilder: (context, index) => Text(
              brands[index],
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.outlineVariant,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return NavigationBar(
      selectedIndex: _navIndex,
      onDestinationSelected: _onNavTap,
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryContainer.withOpacity(0.2),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.grid_view_outlined), label: 'Categories'),
        NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
        NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}