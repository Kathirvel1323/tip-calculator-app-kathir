import 'package:flutter/material.dart';

void main() => runApp(const TipCalculatorApp());

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tip Calculator',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)), useMaterial3: true),
        home: const TipCalculatorScreen(),
      );
}

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final _billController = TextEditingController(text: '1000');
  double _tipPercent = 10;
  int _people = 4;

  void _reset() { setState(() { _billController.text = '0'; _tipPercent = 10; _people = 1; }); }

  double get _bill => double.tryParse(_billController.text.trim()) ?? 0;
  double get _tip => _bill * _tipPercent / 100;
  double get _total => _bill + _tip;
  double get _perPerson => _people < 1 ? 0 : _total / _people;
  String money(double value) => value.toStringAsFixed(2);

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF0FDFA),
        appBar: AppBar(title: const Text('Tip Calculator'), centerTitle: true, actions: [IconButton(tooltip: 'Reset calculator', onPressed: _reset, icon: const Icon(Icons.restart_alt))]),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    TextField(
                      controller: _billController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Bill amount', prefixText: '\$', border: OutlineInputBorder(), helperText: 'Enter a number; blank or invalid input is treated as 0.'),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 24),
                    Wrap(spacing: 8, children: [for (final percent in [10.0, 15.0, 18.0, 20.0]) ChoiceChip(label: Text('${percent.toInt()}%'), selected: _tipPercent == percent, onSelected: (_) => setState(() => _tipPercent = percent))]),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Tip percentage'), Text('${_tipPercent.round()}%')]),
                    Slider(value: _tipPercent, min: 0, max: 30, divisions: 30, label: '${_tipPercent.round()}%', onChanged: (value) => setState(() => _tipPercent = value)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text('Split between'),
                      Row(children: [
                        IconButton(onPressed: _people > 1 ? () => setState(() => _people--) : null, icon: const Icon(Icons.remove_circle_outline), tooltip: 'Fewer people'),
                        Text('$_people', style: Theme.of(context).textTheme.titleLarge),
                        IconButton(onPressed: () => setState(() => _people++), icon: const Icon(Icons.add_circle_outline), tooltip: 'More people'),
                      ]),
                    ]),
                    const Divider(height: 28),
                    _ResultRow(label: 'Tip', value: '\$${money(_tip)}'),
                    _ResultRow(label: 'Total', value: '\$${money(_total)}'),
                    _ResultRow(label: 'Each person pays', value: '\$${money(_perPerson)}', emphasized: true),
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.label, required this.value, this.emphasized = false});
  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(fontWeight: emphasized ? FontWeight.bold : FontWeight.normal)), Text(value, style: TextStyle(fontSize: emphasized ? 20 : 16, fontWeight: FontWeight.bold))]),
      );
}
