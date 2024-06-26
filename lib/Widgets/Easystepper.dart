
import 'package:boy/Widgets/Colors.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';


class easy_stepper extends StatefulWidget {
   final Function(status) onStatusChanged;

  const easy_stepper({super.key,required this.onStatusChanged});

  @override
  State<easy_stepper> createState() => _easy_stepperState();
}
 enum status {pending, Ontheway ,  Arrived, processing ,Confirm}
class _easy_stepperState extends State<easy_stepper> {
  
  var activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return  EasyStepper(
        activeStep: activeStep,
        lineStyle: LineStyle(
        lineLength: 60,
        lineSpace: 0,
        lineThickness: 4,
        lineType: LineType.normal,
        defaultLineColor: Colors.white, 
        
        ),
       
        activeStepTextColor: GlobalColors.stepper,
        finishedStepTextColor: Colors.black,
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 8,
        showStepBorder: false,
       
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
             
              child: CircleAvatar(
                
                backgroundColor:
                    activeStep >= 0 ? GlobalColors.stepper: Colors.white,
                    child: activeStep>= 0 ? Center(child: Icon(Icons.check, size: 10,color: Colors.white,))
                    :Text("1" , style: TextStyle(color: activeStep>=0 ? GlobalColors.number: Colors.amber, fontSize: 12 )
                    ),

              ),
            ),
            
            title: status.pending.toString().split('.').last,
            
          ),

          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
      
              child: CircleAvatar(
             
                backgroundColor:
                    activeStep >= 1 ?  GlobalColors.stepper : Colors.white   ,
                     child: activeStep>=1 ? Center(child: Icon(Icons.check, size: 10,color: Colors.white,))
                     : Text("2" , style: TextStyle(color: activeStep>=1 ? GlobalColors.number: Colors.amber,
                      fontSize: 12),
                     
                     
                     ),
              ),
            ),
            title: status.Ontheway.toString().split('.').last,
           
          ),
        
          EasyStep(
            customStep: CircleAvatar(
              
             
              child: CircleAvatar(
              
                backgroundColor:
                    activeStep >= 2 ?  GlobalColors.stepper : Colors.white,
                     child: activeStep >=2 ? Center(child: Icon(Icons.check, size: 10,color: Colors.white,))
                     : Text("3",style: TextStyle(color: activeStep >=2 ? GlobalColors.number : Colors.amber,
                     fontSize: 12,
            )),
              ),
            ),
            title: status.Arrived.toString().split('.').last ,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
             
              child: CircleAvatar(
                
                backgroundColor:
                    activeStep >= 3 ?  GlobalColors.stepper : Colors.white,
                     child: 
                          activeStep >= 3 ?
                           Center(child: Icon(Icons.check, size: 10,color: Colors.white,))
                          : Text("4",style: TextStyle(color: activeStep>=3 ? GlobalColors.number:Colors.amber,
                     fontSize: 12,
            )),
              ),
            ),
           title: status.processing.toString().split('.').last,
            
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              child: CircleAvatar(
                
                backgroundColor:
                    activeStep >= 4 ?  GlobalColors.stepper : Colors.white,

                     child: activeStep>=4 ? Center(child: Icon(Icons.check, size: 10,color: Colors.white,)): 
                     Text("5",style: TextStyle(color: activeStep>=4 ? GlobalColors.number:Colors.amber,
                     fontSize: 12,
            )),
              ),
            ),
            title: status.Confirm.toString().split('.').last,
          ),
        ],
       
            onStepReached: (index) {
        setState(() {
          activeStep = index;
        });

        widget.onStatusChanged(status.values[index]);
      },
    );
  }
}
