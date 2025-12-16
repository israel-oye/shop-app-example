import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/data/avatars.dart';
import 'package:shop_app/models/product.dart';


class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  String enteredName = '';
  int enteredQty = 1;
  double enteredPrice = 0.0;
  AvatarChoice chosenAvatar = AvatarChoice.blue;
  bool isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  void _submitForm() async{
    if (!_formKey.currentState!.validate())return;

    setState(() {
      isSubmitting = true;
    });
    
    _formKey.currentState!.save();

    final random = math.Random();
    Product newProduct = Product(
      id: random.nextInt(20) + 1,
      name: enteredName,
      price: enteredPrice,
      avatar: chosenAvatar.color
    );
    await _saveToDB(newProduct);

    if(!mounted){
        return;      
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$enteredName saved successfully')),
    );
  _formKey.currentState!.reset();
    
    
    setState(() {
      isSubmitting = false;
    });
    
  }

  Future<void> _saveToDB(Product product) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://shop-app-demo-f7536-default-rtdb.firebaseio.com/',
        headers: {
          'Content-Type': 'application/json',
        }
      )
    );

    final response =  await dio.post('/products.json', data: product.toJson());
    final data = response.data;
    print(data);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 16, horizontal: 24),
      child: Form(
        key: _formKey,
        child: _buildForm()
      ),
    );
  }

  Column _buildForm() {
    return Column(
        children: [
          // Name TextInput
          TextFormField(
            decoration: InputDecoration(
              label: Text('Name'),
              hintText: "Name of Product"
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty || value.length < 3) {
                return 'Please enter a valid name between 5 and 50 characters';
              }
              return null;
            },
            onSaved: (value){
              enteredName = value!;
            },
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [

              // Quantity TextInput
              Flexible(
                child: TextFormField(
                  initialValue: '1',
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  decoration: InputDecoration(
                    label: const Text('Qty')
                  ),
                  validator: (value){
                    if (value == null ||
                      int.tryParse(value) == null ||
                      int.parse(value) < 1) {
                        return 'Invalid quantity';
                      }
                    return null;
                  },
                  onSaved: (value){
                    enteredQty = int.parse(value!);
                  },
                )
              ),
              
              // Price TextInput
              Flexible(
                flex: 2,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    label: const Text('Price'),
                    prefix: Text(
                      '₦ ', 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  validator: (value){
                    if (value == null ||
                      value.trim().isEmpty ||
                      double.parse(value) <= 0.0) {
                        return 'Invalid price';
                    }
                    return null;
                  },
                  onSaved: (val){
                    enteredPrice = double.parse(val!);
                  },
                )
              ),
            ],
          ),
          SizedBox(height: 12,),
          // Dropdown Button
          DropdownButtonFormField<AvatarChoice>(
            initialValue: AvatarChoice.blue,
            items: AvatarChoice.values.map(
              (avatar) => DropdownMenuItem(
                    value: avatar,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 16, 
                          width: 16, 
                          color: avatar.color
                        ),
                        SizedBox(width: 8,),
                        Text(avatar.name),
                      ]
                      ),
                  )
            ).toList(), 
            onChanged: (val){},
            onSaved: (value){
              chosenAvatar = value!;
            },
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                }, 
                child: Text('Reset')
              ),
              ElevatedButton(
                onPressed: isSubmitting ? null : _submitForm,
                child: 
                isSubmitting 
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Saving'), 
                      SizedBox(width: 6,),
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator()
                        )
                      ]
                    )
                  : Text('Save')
              ),
            ],
          )
        ],
      );
  }
}