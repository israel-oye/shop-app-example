import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/new_item_screen.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  int _currentPageIndex = 0;
  String _currentPageTitle = '';
  List<Widget> pages = [
    const HomeScreen(),
    const NewItemScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

  if (_currentPageIndex == 0) {
      _currentPageTitle = 'Home';
    } else if (_currentPageIndex == 1) {
      _currentPageTitle = 'Add Item';
    } else if (_currentPageIndex == 2) {
      _currentPageTitle = 'Cart';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        title: Text(_currentPageTitle),
        actions: [
          if (_currentPageIndex == 2)
            ClearCartButton(),
          SizedBox(width: 8,)
        ],
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (idx){
          setState(() {
            _currentPageIndex = idx;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 1
                  ? Icons.add_box_rounded
                  : Icons.add_box_outlined,
            ), 
            label: 'Add'
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  _currentPageIndex == 2
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                ),
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    height: 18,
                    width: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(205, 211, 77, 68),
                      shape: BoxShape.circle
                    ),
                    child: Consumer<CartProvider>(
                      builder: (ctx, provider, child)=> Text(
                        "${provider.items.length}",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                )
                ]
              ),
            label: 'Cart',
          )
        ]
      ),
    );
  }
}

class ClearCartButton extends StatelessWidget {
  const ClearCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, provider, _) => IconButton(
        onPressed: provider.items.isEmpty
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Clear Cart'),
                    content: Text(
                      'Are you sure you want to clear the cart?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.read<CartProvider>().clearCart();
                          Navigator.pop(ctx);
                        },
                        child: Text('OK'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
      icon: Icon(Icons.remove_shopping_cart)),
    );
  }
}