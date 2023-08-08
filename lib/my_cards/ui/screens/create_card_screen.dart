import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Map<String, FocusNode> _fieldFocusNodes = {
    'name': FocusNode(),
    'title': FocusNode(),
    'company': FocusNode(),
    'phone': FocusNode(),
    'email': FocusNode(),
    'website': FocusNode(),
    'linkedin': FocusNode(),
    'facebook': FocusNode(),
    'twitter': FocusNode(),
  };
  late Color themePickerColor;
  @override
  void initState() {
    super.initState();
    themePickerColor = Colors.blue; // Material blue.
    // dialogPickerColor = Colors.red;   // Material red.
    // dialogSelectColor = const Color(0xFFA239CA); // A purple color.
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
                      key: _formKey,
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['name']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['name'],
                              decoration: loginInputDecoration),
                          const SizedBox(height: 20),
                          const Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                              name: 'title',
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['title']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['title'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['company']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['company'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['phone']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['phone'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['email']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['email'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['website']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['website'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['linkedin']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['linkedin'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['facebook']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['facebook'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['instagram']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['instagram'],
                              decoration: loginInputDecoration),
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
                              onChanged: (val) {},
                              onTap: () {
                                _fieldFocusNodes['twitter']!.requestFocus();
                              },
                              focusNode: _fieldFocusNodes['twitter'],
                              decoration: loginInputDecoration),
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
                              onColorChanged: (Color color) =>
                                  setState(() => themePickerColor = color),
                              width: 44,
                              height: 44,
                              borderRadius: 22,
                            ),
                          ),
                          CustomActionButton(
                            label: 'Create Card',
                            onPressed: () {
                              context.go("/home");
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
