import 'package:flutter/material.dart';
import 'package:shop_app/data/avatars.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 16, horizontal: 24),
      child: Form(
        child: _buildForm()
      ),
    );
  }

  Column _buildForm() {
    return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              label: Text('Name'),
              hintText: "Name of Product"
            ),
            
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Flexible(
                child: TextFormField(
                  initialValue: '1',
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  decoration: InputDecoration(
                    label: const Text('Qty')
                  ),
                )
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    label: const Text('Price'),
                    prefix: Text(
                      '₦', 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                )
              ),
            ],
          ),
          SizedBox(height: 12,),
          DropdownButtonFormField<AvatarChoice>(
            initialValue: chosenAvatar,
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
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {}, 
                child: Text('Reset')
              ),
              ElevatedButton(
                onPressed: () {}, 
                child: Text('Save')
              ),
            ],
          )
        ],
      );
  }
}