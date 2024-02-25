import 'package:boy/Widgets/Colors.dart';
import 'package:boy/Widgets/search.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required int index});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:   CrossAxisAlignment.start,
          children: [
            
           Row(
             children: [
               Expanded(
                child: Text("ORDER DETAILS",style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800))),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:10 ),
             child: Container(
               decoration: BoxDecoration(
                 color: GlobalColors.childmainColor,
                 borderRadius: BorderRadius.circular(8),
               ),
               child: IconButton(      
                 onPressed: () {},
                 color: GlobalColors.childmainColor ,
                                   icon: Image.asset("images/phone.png", color: GlobalColors.mainColor)
               ),
             ),
           ),
           Container(
             decoration: BoxDecoration(
               color: GlobalColors.childmainColor,
               borderRadius: BorderRadius.circular(8),
             ),
             child: IconButton(
               onPressed: () {},
                                 icon: Image.asset("images/pin-icon.png",
)             ),

           ),

             ],
           ),
           

 ],
),
        

    
          
          
        ),
      );
  }
}