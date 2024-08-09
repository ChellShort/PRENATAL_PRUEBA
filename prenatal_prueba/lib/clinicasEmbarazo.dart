import 'package:flutter/material.dart';

class ClinicasEmbarazo extends StatelessWidget {
  final List<Map<String, String>> clinics = [
    {
      'name': 'Clínica Prenatal Vida',
      'address': 'Calle Falsa 123, Ciudad',
      'phone': '123-456-7890',
      'description': 'Especializada en cuidado prenatal y parto humanizado.'
    },
    {
      'name': 'Centro Maternal Salud',
      'address': 'Avenida Siempre Viva 742, Ciudad',
      'phone': '987-654-3210',
      'description': 'Ofrece servicios de ultrasonido y consultas ginecológicas.'
    },
    {
      'name': 'Maternidad Feliz',
      'address': 'Plaza Principal 456, Ciudad',
      'phone': '555-123-4567',
      'description': 'Clínica integral para el cuidado del embarazo.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clínicas Especializadas en Embarazo'),
      ),
      body: ListView.builder(
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(clinics[index]['name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dirección: ${clinics[index]['address']}'),
                        Text('Teléfono: ${clinics[index]['phone']}'),
                      ],
                    ),
                  ),
                  
                  
                  Text(clinics[index]['description']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}