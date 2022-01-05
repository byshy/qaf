import 'package:flutter/material.dart';
import 'package:qaf/utils_and_services/decoration/colors.dart';

class StepperWidget extends StatefulWidget {
  final int stepsCount;
  final int currentStep;
  final Function(int) onTap;

  const StepperWidget({
    Key? key,
    required this.stepsCount,
    required this.currentStep,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  late List<Widget> steps;

  @override
  void initState() {
    super.initState();
    generateStepper();
  }

  @override
  void didUpdateWidget(covariant StepperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    generateStepper();
  }

  void generateStepper() {
    steps = List.generate(
      widget.stepsCount,
      (index) => Step(
        currentStep: (index + 1),
        isSelected: widget.currentStep > index - 1,
        onTap: () => widget.onTap(index),
      ),
    );

    if (steps.length > 1) {
      for (int i = 0; i < steps.length - 1; i++) {
        if (i % 2 == 0) {
          steps.insert(
            i + 1,
            Container(),
          );
        }
      }

      for (int i = steps.length - 2; i > 0; i -= 2) {
        steps[i] = Expanded(
          child: Container(
            height: 2,
            color: (widget.currentStep * 2).ceil() >= i ? green00A170 : greyC8C8C8,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: steps,
    );
  }
}

class Step extends StatelessWidget {
  final int currentStep;
  final bool isSelected;
  final VoidCallback onTap;

  const Step({
    Key? key,
    required this.currentStep,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? onTap : null,
      child: Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        child: Text(
          currentStep.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : grey707070,
          ),
        ),
        decoration: BoxDecoration(
          color: isSelected ? green00A170 : greyC8C8C8,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
