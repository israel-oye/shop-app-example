import 'package:flutter/material.dart';
import 'package:shop_app/skeleton.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.8,
              child: Image.asset('assets/shop.png')
            ),
            SizedBox(height: 8),
            Text(
              'BuyMore', 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 28,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                ),
              ),
            SizedBox(height: 72,),
            ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (ctx) => Skeleton()),
                );
              },
              child: Icon(Icons.arrow_right_alt)
            )
          ],
        ),
      ),
    );
  }
}