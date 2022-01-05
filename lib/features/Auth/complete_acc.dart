import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qaf/features/Auth/widgets/registration_success.dart';
import 'package:qaf/features/Auth/widgets/stepper.dart';
import 'package:qaf/utils_and_services/app_translations/app_translations.dart';
import 'package:qaf/utils_and_services/decoration/colors.dart';
import 'package:qaf/utils_and_services/decoration/decorations.dart';
import 'package:qaf/utils_and_services/decoration/images.dart';
import 'package:qaf/utils_and_services/global_widgets/custom_raised_button.dart';

class CompleteAccountScreen extends StatefulWidget {
  const CompleteAccountScreen({Key? key}) : super(key: key);

  @override
  _CompleteAccountScreenState createState() => _CompleteAccountScreenState();
}

enum Gender { male, female }

enum CarLicenceType { private, public }

class _CompleteAccountScreenState extends State<CompleteAccountScreen> {
  int currentStep = 0;

  int stepsCount = 3;

  String? regionValue;
  String? cityValue;

  Gender? gender;
  CarLicenceType? carLicenceType;

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
              const SizedBox(height: 20),
              StepperWidget(
                stepsCount: stepsCount,
                currentStep: currentStep,
                onTap: (index) {
                  setState(() {
                    currentStep = index;
                  });
                },
              ),
              const SizedBox(height: 38),
              Text(
                AppTranslations.of(context: context)!.text('welcome'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: [
                  personalInfo(),
                  carInfo(),
                  attachedDocuments(),
                ][currentStep],
              ),
              const SizedBox(height: 15),
              SafeArea(
                minimum: const EdgeInsets.only(bottom: 10),
                child: CustomRaisedButton(
                  color: blue072B66,
                  radius: 5,
                  onTap: () {
                    if (currentStep < 2) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      displayRegistrationSuccessDialog();
                    }
                  },
                  child: Text(
                    currentStep == 2
                        ? AppTranslations.of(context: context)!.text('finish')
                        : AppTranslations.of(context: context)!.text('continue'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownContent({
    required IconData icon,
    required Widget title,
  }) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: Icon(
                icon,
                color: blue2BB4ED,
              ),
            ),
          ),
          title,
        ],
      ),
    );
  }

  Widget personalInfo() {
    return Column(
      children: [
        Text(
          AppTranslations.of(context: context)!.text('complete_registration'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: greyC8C8C8,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              TextFormField(
                decoration: inputDecoration.copyWith(
                  hintText: AppTranslations.of(context: context)!.text('full_name'),
                  prefixIcon: const Icon(
                    Icons.person_outlined,
                    color: blue2BB4ED,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: inputDecoration.copyWith(
                  hintText: AppTranslations.of(context: context)!.text('id_number'),
                  prefixIcon: const Icon(
                    Icons.picture_in_picture_alt,
                    color: blue2BB4ED,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: DropdownButton<String>(
                        value: regionValue,
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        isExpanded: true,
                        iconSize: 20,
                        onTap: () => FocusScope.of(context).unfocus(),
                        hint: dropDownContent(
                          icon: Icons.location_on_outlined,
                          title: Text(
                            AppTranslations.of(context: context)!.text('region'),
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            regionValue = newValue;
                          });
                        },
                        underline: const SizedBox(),
                        items: List.generate(4, (index) => 'Place $index').map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: dropDownContent(
                              icon: Icons.location_on_outlined,
                              title: Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: greyB5B5B5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Container(
                      child: DropdownButton<String>(
                        value: cityValue,
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        isExpanded: true,
                        iconSize: 20,
                        onTap: () => FocusScope.of(context).unfocus(),
                        hint: dropDownContent(
                          icon: Icons.location_on_outlined,
                          title: Text(
                            AppTranslations.of(context: context)!.text('city'),
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            cityValue = newValue;
                          });
                        },
                        underline: const SizedBox(),
                        items: List.generate(4, (index) => 'Place $index').map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: dropDownContent(
                              icon: Icons.location_on_outlined,
                              title: Text(
                                value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: greyB5B5B5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      title: Text(
                        AppTranslations.of(context: context)!.text('male'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: greyC8C8C8,
                        ),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.male,
                        groupValue: gender,
                        activeColor: blue2BB4ED,
                        onChanged: (Gender? value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      title: Text(
                        AppTranslations.of(context: context)!.text('female'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: greyC8C8C8,
                        ),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.female,
                        groupValue: gender,
                        activeColor: blue2BB4ED,
                        onChanged: (Gender? value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    // authInstance.selectDate();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppTranslations.of(context: context)!.text('dob'),
                        style: const TextStyle(
                          color: greyC8C8C8,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: greyB5B5B5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget carInfo() {
    return Column(
      children: [
        Text(
          AppTranslations.of(context: context)!.text('car_registration'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: greyC8C8C8,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: DropdownButton<String>(
                        value: regionValue,
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        isExpanded: true,
                        iconSize: 20,
                        onTap: () => FocusScope.of(context).unfocus(),
                        hint: Text(
                          AppTranslations.of(context: context)!.text('make'),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            regionValue = newValue;
                          });
                        },
                        underline: const SizedBox(),
                        items: List.generate(4, (index) => 'Place $index').map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: greyB5B5B5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: DropdownButton<String>(
                        value: cityValue,
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        isExpanded: true,
                        iconSize: 20,
                        onTap: () => FocusScope.of(context).unfocus(),
                        hint: Text(
                          AppTranslations.of(context: context)!.text('model'),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            cityValue = newValue;
                          });
                        },
                        underline: const SizedBox(),
                        items: List.generate(4, (index) => 'Place $index').map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: greyB5B5B5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: DropdownButton<String>(
                        value: regionValue,
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        isExpanded: true,
                        iconSize: 20,
                        onTap: () => FocusScope.of(context).unfocus(),
                        hint: Text(
                          AppTranslations.of(context: context)!.text('prod_year'),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            regionValue = newValue;
                          });
                        },
                        underline: const SizedBox(),
                        items: List.generate(4, (index) => 'Place $index').map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: greyB5B5B5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: DropdownButton<String>(
                        value: cityValue,
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        isExpanded: true,
                        iconSize: 20,
                        onTap: () => FocusScope.of(context).unfocus(),
                        hint: Text(
                          AppTranslations.of(context: context)!.text('color'),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            cityValue = newValue;
                          });
                        },
                        underline: const SizedBox(),
                        items: List.generate(4, (index) => 'Place $index').map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: greyB5B5B5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: AppTranslations.of(context: context)!.text('plate'),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: AppTranslations.of(context: context)!.text('plate_en'),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: inputDecoration.copyWith(
                  hintText: AppTranslations.of(context: context)!.text('serial_no'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      title: Text(
                        AppTranslations.of(context: context)!.text('public'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: greyC8C8C8,
                        ),
                      ),
                      leading: Radio<CarLicenceType>(
                        value: CarLicenceType.public,
                        groupValue: carLicenceType,
                        activeColor: blue2BB4ED,
                        onChanged: (CarLicenceType? value) {
                          setState(() {
                            carLicenceType = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      title: Text(
                        AppTranslations.of(context: context)!.text('private'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: greyC8C8C8,
                        ),
                      ),
                      leading: Radio<CarLicenceType>(
                        value: CarLicenceType.private,
                        groupValue: carLicenceType,
                        activeColor: blue2BB4ED,
                        onChanged: (CarLicenceType? value) {
                          setState(() {
                            carLicenceType = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget attachedDocuments() {
    return Column(
      children: [
        Text(
          AppTranslations.of(context: context)!.text('documents'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: greyC8C8C8,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              documentItem(
                title: AppTranslations.of(context: context)!.text('personal_image'),
                subTitle: AppTranslations.of(context: context)!.text('upload_personal_image'),
              ),
              const SizedBox(height: 20),
              documentItem(
                title: AppTranslations.of(context: context)!.text('personal_id_image'),
              ),
              const SizedBox(height: 20),
              documentItem(
                title: AppTranslations.of(context: context)!.text('car_image'),
                subTitle: AppTranslations.of(context: context)!.text('upload_car_image'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget documentItem({
    required String title,
    String? subTitle,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: greyC8C8C8,
                    ),
                  ),
                ),
            ],
          ),
        ),
        DottedBorder(
          dashPattern: const [5, 5],
          child: const SizedBox(
            width: 60,
            height: 60,
            child: Center(
              child: Icon(Icons.camera_alt),
            ),
          ),
        ),
      ],
    );
  }
}
