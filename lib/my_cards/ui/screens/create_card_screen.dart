import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/create_card/create_card_bloc.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';
import 'package:flutter_easy_card/core/utils/form_validator.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final Map<String, FocusNode> _fieldFocusNodes = {
    'name': FocusNode(),
    'jobTitle': FocusNode(),
    'company': FocusNode(),
    'phone': FocusNode(),
    'email': FocusNode(),
    'website': FocusNode(),
    'linkedin': FocusNode(),
    'facebook': FocusNode(),
    'twitter': FocusNode(),
  };
  late Color themePickerColor;
  late String colorThemeValue;

  @override
  void initState() {
    super.initState();
    themePickerColor = Colors.deepPurple;
    colorThemeValue = '0xff673ab7';
  }

  @override
  void dispose() {
    for (var focusNode in _fieldFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: black,
                size: 32,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Create Card',
                style: appTitleStyle,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: sidePadding),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      alignment: const Alignment(1.2, 1.2),
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          width: 250,
                          child: InkWell(
                            onTap: () => {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: easyPurple),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormBuilder(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'name',
                            onTap: () {
                              _fieldFocusNodes['name']!.requestFocus();
                            },
                            focusNode: _fieldFocusNodes['name'],
                            decoration: loginInputDecoration,
                            validator: validateName,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'jobTitle',
                            onTap: () {
                              _fieldFocusNodes['jobTitle']!.requestFocus();
                            },
                            focusNode: _fieldFocusNodes['jobTitle'],
                            decoration: loginInputDecoration,
                            validator: validateName,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Company',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'company',
                            onTap: () {
                              _fieldFocusNodes['company']!.requestFocus();
                            },
                            focusNode: _fieldFocusNodes['company'],
                            decoration: loginInputDecoration,
                            validator: validateName,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'phone',
                            onTap: () {
                              _fieldFocusNodes['phone']!.requestFocus();
                            },
                            focusNode: _fieldFocusNodes['phone'],
                            decoration: loginInputDecoration,
                            validator: validatePhoneNumber,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'email',
                            onTap: () {
                              _fieldFocusNodes['email']!.requestFocus();
                            },
                            focusNode: _fieldFocusNodes['email'],
                            decoration: loginInputDecoration,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Website',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'website',
                            onTap: () {
                              _fieldFocusNodes['website']!.requestFocus();
                            },
                            focusNode: _fieldFocusNodes['website'],
                            decoration: loginInputDecoration,
                            validator: validateWebURL,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'LinkedIn',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                              name: 'linkedin',
                              onTap: () {
                                _fieldFocusNodes['linkedin']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['linkedin'],
                              decoration: loginInputDecoration,
                              validator: validateWebURL),
                          const SizedBox(height: 20),
                          const Text(
                            'Facebook',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                              name: 'facebook',

                              onTap: () {
                                _fieldFocusNodes['facebook']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['facebook'],
                              decoration: loginInputDecoration,
                              validator: validateWebURL),
                          const SizedBox(height: 20),
                          const Text(
                            'Instagram',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                              name: 'instagram',
                              onTap: () {
                                _fieldFocusNodes['instagram']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['instagram'],
                              decoration: loginInputDecoration,
                              validator: validateWebURL),
                          const SizedBox(height: 20),
                          const Text(
                            'Twitter',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                              name: 'twitter',
                              onTap: () {
                                _fieldFocusNodes['twitter']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['twitter'],
                              decoration: loginInputDecoration,
                              validator: validateWebURL),
                          const SizedBox(height: 20),
                          const Text(
                            'Color Theme',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ColorPicker(
                              color: themePickerColor,
                              spacing: 10,
                              runSpacing: 10,
                              pickersEnabled: const {
                                ColorPickerType.primary: false,
                                ColorPickerType.accent: false,
                                ColorPickerType.bw: false,
                                ColorPickerType.custom: false
                              },
                              enableShadesSelection: false,
                              onColorChanged: (Color color) {
                                colorThemeValue = '0x${color.value.toRadixString(16)}';
                                debugPrint(colorThemeValue);
                                setState(() {
                                  themePickerColor = color;
                                });
                              },
                              width: 44,
                              height: 44,
                              borderRadius: 22,
                            ),
                          ),
                          BlocConsumer<CreateCardBloc, CreateCardState>(
                            bloc: BlocProvider.of<CreateCardBloc>(context),
                            listener: (context, state) {
                              if (state is CreateCardPending) {
                                EasyLoading.show(status: 'Loading...');
                              }
                              if (state is CreateCardSuccess) {
                                EasyLoading.dismiss();
                                EasyLoading.showSuccess(
                                    duration: const Duration(seconds: 2),
                                    'Card Created!');
                                context.go("/home");
                              }
                              if (state is CreateCardFailure) {
                                EasyLoading.dismiss();
                                EasyLoading.showError(state.error,
                                    duration: const Duration(seconds: 2));
                              }
                            },
                            builder: (context, state) {
                              return CustomActionButton(
                                label: 'Create Card',
                                onPressed: () {
                                  debugPrint('Create Card');
                                  if (formKey.currentState!.saveAndValidate()) {
                                    final formData =
                                        formKey.currentState!.value;
                                    User? user =
                                        FirebaseAuth.instance.currentUser;
                                    BlocProvider.of<CreateCardBloc>(context)
                                        .add(CreateNewCard(
                                      cardData: CardModel(
                                        colorTheme: colorThemeValue,
                                        company: formData['company'],
                                        creator: user?.email ?? 'no_creator',
                                        email: formData['email'],
                                        facebook: formData['facebook'],
                                        imageUrl: '',
                                        isPrivate: false,
                                        jobTitle: formData['jobTitle'],
                                        linkedin: formData['linkedin'],
                                        name: formData['name'],
                                        phone: formData['phone'],
                                        twitter: formData['twitter'],
                                        website: formData['website'],
                                      ),
                                    ));
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void addDataToFirestore() async {
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection('cards');
  User? user = FirebaseAuth.instance.currentUser;

  CardModel card = CardModel(
    colorTheme: 'red',
    company: 'Stokes and Sons',
    creator: user?.email ?? 'no_creator',
    email: 'john_doe@gmail.com',
    facebook: '',
    imageUrl: '',
    isPrivate: false,
    jobTitle: '',
    linkedin: '',
    name: 'John Doe',
    phone: '',
    twitter: '',
    website: '',
  );
  try {
    await cardCollection.add(card.toMap());
    print('Document added successfully');
  } catch (e) {
    print('Error adding document: $e');
  }
}
