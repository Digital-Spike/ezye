import 'package:flutter/material.dart';


class DummyPage extends StatefulWidget {
  const DummyPage({super.key});

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
 int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stepper(
      currentStep: _index,
      onStepCancel: () {
      },
      onStepContinue: () {
      },
      onStepTapped: (int index) {
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    )
    );
  }
}
