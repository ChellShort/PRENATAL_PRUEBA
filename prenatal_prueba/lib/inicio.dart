import 'package:flutter/material.dart';
import 'package:navbar/clinicasEmbarazo.dart';
import 'package:navbar/controlPrenatal.dart';
import 'package:navbar/primerosCuidados.dart';

class Inicio extends StatelessWidget {

  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xffe7e7e7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 8, 93),
        title: const Text('Inicio', style: TextStyle(color: Colors.white),),
      ),
      drawer: Drawer(
        
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            const DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 28, 8, 93),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pregnant_woman),
              title: const Text('Control Prenatal'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ControlPrenatal()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.emergency),
              title: const Text('Primeros Cuidados'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PrimerosCuidados()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Clinicas de Embarazo'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClinicasEmbarazo()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Inicio', style: TextStyle(fontSize: 30),),
        // child: CarouselSlider(
        //   options: CarouselOptions(height: 400.0, autoPlay: true, autoPlayInterval: Duration(seconds: 3), autoPlayAnimationDuration: Duration(milliseconds: 800), autoPlayCurve: Curves.fastOutSlowIn),
        //   items: itemsImg.map((item) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //           width: MediaQuery.of(context).size.width,
        //           margin: const EdgeInsets.symmetric(horizontal: 5.0),
        //           decoration: const BoxDecoration(color: Colors.green),
        //           child: Image.asset(item, fit: BoxFit.fill,),
        //         );
        //       },
        //     );
        //   }).toList(),
        // ),
      ),
    );
  }
}
