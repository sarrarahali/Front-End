import 'package:flutter/material.dart';

class _NavigationDestination extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final bool selected;

  _NavigationDestination({
    required this.icon,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
            icon,
            SizedBox(height: 5,),
            if (selected) 
              Container(
                width: 8, 
                height: 8, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple,
                ),
              ),
          ],
        ),
      ),
    );
  }
}