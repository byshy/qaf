import 'package:flutter/material.dart';
import 'package:qaf/features/Auth/widgets/stepper.dart';
import 'package:qaf/utils_and_services/decoration/images.dart';

class CompleteAccountScreen extends StatefulWidget {
  const CompleteAccountScreen({Key? key}) : super(key: key);

  @override
  _CompleteAccountScreenState createState() => _CompleteAccountScreenState();
}

class _CompleteAccountScreenState extends State<CompleteAccountScreen> {
  int currentStep = 0;

  int stepsCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(appBG),
            alignment: Alignment.bottomRight,
            colorFilter: ColorFilter.mode(
              Color(0xFFF1F1F1),
              BlendMode.srcIn,
            ),
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            children: [
              StepperWidget(
                stepsCount: stepsCount,
                currentStep: currentStep,
              ),
              InkWell(
                onTap: () {
                  if (currentStep < stepsCount - 1) {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                child: Text('plus'),
              ),
              InkWell(
                onTap: () {
                  if (currentStep > 0) {
                    setState(() {
                      currentStep -= 1;
                    });
                  }
                },
                child: Text('minus'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
