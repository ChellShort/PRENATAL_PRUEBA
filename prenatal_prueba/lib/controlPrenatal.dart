// lib/pregnancy_care_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ControlPrenatal extends StatefulWidget {
  @override
  _PregnancyCareWidgetState createState() => _PregnancyCareWidgetState();
}

class _PregnancyCareWidgetState extends State<ControlPrenatal> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  final Map<int, Map<String, String>> recommendations = {
    1: {
      'nutrition': 'Ingesta de ácido fólico y alimentos ricos en hierro.',
      'care': 'Primera visita prenatal y análisis iniciales.'
    },
    2: {
      'nutrition': 'Aumenta el consumo de proteínas y calcio.',
      'care': 'Ultrasonido para confirmar la viabilidad del embarazo.'
    },
    3: {
      'nutrition': 'Incluye alimentos ricos en vitaminas y minerales.',
      'care': 'Control del peso y seguimiento del crecimiento fetal.'
    },
    // Agrega más recomendaciones para cada mes según sea necesario
  };

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = _dateFormat.format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentMonth = 0;
    if (_selectedDate != null) {
      final now = DateTime.now();
      currentMonth = now.difference(_selectedDate!).inDays ~/ 30;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuidados y Alimentación Prenatal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha de Embarazo',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedDate != null && recommendations.containsKey(currentMonth))
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Recomendaciones para el mes $currentMonth',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Alimentación: ${recommendations[currentMonth]!['nutrition']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Cuidados: ${recommendations[currentMonth]!['care']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            if (_selectedDate == null || !recommendations.containsKey(currentMonth))
              const Text(
                'Por favor ingrese una fecha válida de embarazo para ver las recomendaciones.',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
