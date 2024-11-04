import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart'; // Paylaşma paketi eklendi
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/utility/utils/utils.dart';
import 'package:text_repeater/config/widgets/bordered_button.dart';
import 'package:text_repeater/config/widgets/input_field.dart';
import 'package:toastification/toastification.dart';

import '../../../config/items/borders/container_borders.dart';
import '../../../config/items/colors/app_colors.dart';
import '../../../config/widgets/custom_appbar.dart';
import '../bloc/text/local/local_text_bloc.dart';

class TextSorting extends StatefulWidget {
  const TextSorting({super.key});

  @override
  State<TextSorting> createState() => _TextSortingState();
}

class _TextSortingState extends State<TextSorting> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _outputController =
      TextEditingController(); // Output için TextEditingController
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    _repeatController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _selectAllText() {
    _outputController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _outputController.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'Text Sorting',
                ),
                Padding(
                  padding: context.paddingTopDefault,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      border: ContainerBorders.containerMediumBorder,
                      borderRadius: ContainerBorders.borderRadius,
                    ),
                    child: Padding(
                      padding: context.paddingAllDefault,
                      child: Column(
                        children: [
                          InputField(
                            maxLines: 5,
                            labelText: "Text",
                            controller: _textController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a text";
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: context.paddingTopDefault,
                            child: BorderedButton(
                              text: "Sort Text",
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                } else {
                                  BlocProvider.of<LocalTextBloc>(context).add(
                                    SortTextEvent(
                                      text: _textController.text,
                                    ),
                                  );
                                }
                              },
                              color: AppColors.kPrimaryLight,
                              isBordered: false,
                              textStyle: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.kWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                BlocBuilder<LocalTextBloc, LocalTextState>(
                  builder: (context, state) {
                    if (state is LocalTextLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is LocalTextSuccessState) {
                      // Sonucu outputController'a atıyoruz
                      _outputController.text = state.text ?? "";

                      return Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.kWhite,
                                  border:
                                      ContainerBorders.containerMediumBorder,
                                  borderRadius: ContainerBorders.borderRadius,
                                ),
                                padding: context.paddingAllDefault,
                                child: GestureDetector(
                                  onTap:
                                      _selectAllText, // Dokunulduğunda tüm metni seç
                                  child: TextField(
                                    controller: _outputController,
                                    readOnly: true, // Metin düzenlenemez
                                    maxLines:
                                        null, // Metnin tamamını göstermek için
                                    style: context.textTheme.bodyMedium,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: BorderedButton(
                                    isBordered: false,
                                    color: AppColors.kPrimaryLight,
                                    textStyle: context.textTheme.bodyMedium
                                        ?.copyWith(color: AppColors.kWhite),
                                    text: "Copy",
                                    onPressed: () {
                                      // Metni panoya kopyala
                                      Clipboard.setData(ClipboardData(
                                          text: _outputController.text));
                                      Utils.showNotification(
                                        context,
                                        "Copied to clipboard",
                                        "The text has been copied to the clipboard.",
                                        type: ToastificationType.success,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: context.dynamicWidth(0.02)),
                                Expanded(
                                  child: BorderedButton(
                                    isBordered: false,
                                    color: AppColors.kPrimaryLight,
                                    textStyle: context.textTheme.bodyMedium
                                        ?.copyWith(color: AppColors.kWhite),
                                    text: "Share",
                                    onPressed: () {
                                      // Metni paylaş
                                      Share.share(_outputController.text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else if (state is LocalTextErrorState) {
                      return Padding(
                        padding: context.paddingTopDefault,
                        child: Text(state.message ?? ""),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
