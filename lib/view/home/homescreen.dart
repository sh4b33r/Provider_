
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/controller_main.dart';
import '../add/add_screen.dart';
import '../theme/themes.dart';
import 'widgets/custom_grid.dart';
import 'widgets/search.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    
 final valcntrl = context.read<MyScreenController>();
            
   

      return Scaffold(
        appBar: AppBar(

          backgroundColor: Clr.appbar,
          centerTitle: true,
          title: const Text("Students App",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
        ),

        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 47, 37, 1),
          child: Icon(Icons.add,color: Colors.white,),
            onPressed: () {
              // Get.to(() => AddScreen());

          
            valcntrl.clearimage();
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddScreen()));
            }),

            
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
          CustomSearchBar(valcontroller: valcntrl),
           Expanded(
             child: Column(
                 
                  children: [
                     Expanded(
                       child: 
                       
                     
                       CustomGridview()
                     )
                    
                    
                    
                    
                    ],
                
              ),
           ),
          ],
        ));
  }
}




   