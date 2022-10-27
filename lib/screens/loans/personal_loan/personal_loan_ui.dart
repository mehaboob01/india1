import 'package:flutter/material.dart';

class PersonalLoan extends StatefulWidget {
  const PersonalLoan({Key? key}) : super(key: key);

  @override
  State<PersonalLoan> createState() => _PersonalLoanState();
}

class _PersonalLoanState extends State<PersonalLoan> {

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

   body:   Stepper(
     elevation: 12,

        controlsBuilder: (context, details) {
          final isLastStep = _currentStep == 4;
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: continued,
                    child: (isLastStep)
                        ? const Text('Submit')
                        : const Text('Next'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_currentStep > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: cancel,
                      child: const Text('Back'),
                    ),
                  )
              ],
            ),
          );
        },
        type: stepperType,

        physics: ScrollPhysics(),
        currentStep: _currentStep,
        onStepTapped: (step) => tapped(step),
        onStepContinue: continued,
        onStepCancel: cancel,
        steps: <Step>[
          Step(
            title: new Text('Personal'),
            content: Column(
              children: <Widget>[

              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: new Text('Personal '),
            content: Column(
              children: <Widget>[

              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: new Text('Personal'),
            content: Column(
              children: <Widget>[

              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(

            title: new Text('Personal'),
            subtitle: new Text('Personal'),
            content: Column(
              children: <Widget>[

              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0
                ? StepState.complete
                : StepState.disabled,
          ),
    ])
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    if (_currentStep == 4) {
      // // _applyFormManager.callTransferApi();
      // _addImvKey.currentState!.save();
      // if (_addImvKey.currentState!.validate()) {
      //
      //
      //   _addImvFormDrivingManager.callImvApi(
      //       _addImvKey.currentState!.value, context);
      // } else {
      //   showSnackBar("Please check all the fields");
      //   print("validation failed");
      // }
    }
    _currentStep < 4 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
