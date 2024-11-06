import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/utility/utils/utils.dart';
import 'package:text_repeater/config/widgets/bordered_button.dart';
import 'package:text_repeater/config/widgets/input_field.dart';
import 'package:toastification/toastification.dart';

import '../../../config/items/borders/container_borders.dart';
import '../../../config/items/colors/app_colors.dart';
import '../../../config/models/text_model.dart';
import '../../../config/utility/helpers/ad_helper.dart';
import '../../../config/widgets/custom_appbar.dart';
import '../bloc/text/local/local_text_bloc.dart';

class TextRepeater extends StatefulWidget {
  const TextRepeater({super.key, this.textModel});
  final TextModel? textModel;
  @override
  State<TextRepeater> createState() => _TextRepeaterState();
}

class _TextRepeaterState extends State<TextRepeater> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _outputController =
      TextEditingController(); // Output için TextEditingController
  bool _isNewLine = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.textModel != null) {
      _textController.text = widget.textModel!.text ?? "";
      _repeatController.text = widget.textModel!.repeatCount.toString();
      _isNewLine = widget.textModel!.isNewLine ?? false;
      context.read<LocalTextBloc>().add(
            RepeatTextEvent(
              text: _textController.text,
              newLine: _isNewLine,
              times: widget.textModel?.repeatCount ?? 0,
              isRecent: true,
            ),
          );
    }
  }

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
      body: Directionality(
        textDirection: context.locale?.localeName == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: BlocConsumer<LocalTextBloc, LocalTextState>(
          listener: (context, state) {
            if (state is LocalTextSuccessState) {
              if ((state.adCount ?? 1) % 3 == 0) {
                AdMobHelper().showRewardedInterstitialAd(onRewarded: () {
                  context.read<LocalTextBloc>().add(
                        RepeatTextEvent(
                          text: _textController.text,
                          newLine: _isNewLine,
                          times: int.tryParse(_repeatController.text) ?? 0,
                        ),
                      );
                }, onDismissed: () {
                  context
                      .read<LocalTextBloc>()
                      .add(const IncrementAdCountEvent(adCount: 3));
                });
              }
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: context.paddingAllDefault,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomAppBar(
                        title: "${context.locale?.repeatTextMenuTitle}",
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
                                  labelText: "${context.locale?.text}",
                                  controller: _textController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "${context.locale?.textValid}";
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: context.paddingVerticalLow,
                                  child: InputField(
                                    labelText: "${context.locale?.repeatCount}",
                                    controller: _repeatController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "${context.locale?.countValid}";
                                      } else if (value == "0") {
                                        return "${context.locale?.greatThanZero}";
                                      } else if (int.tryParse(value) == null) {
                                        return "${context.locale?.validNumber}";
                                      } else if (value.length > 4) {
                                        return "${context.locale?.lessThanTenThousand}";
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: context.paddingVerticalLow,
                                  child: CheckboxListTile.adaptive(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        "${context.locale?.newLine}",
                                        style: context.textTheme.labelMedium,
                                      ),
                                      activeColor: AppColors.kPrimaryLight,
                                      checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                          color: AppColors.kPrimaryLight,
                                        ),
                                      ),
                                      checkColor: AppColors.kWhite,
                                      value: _isNewLine,
                                      side: const BorderSide(
                                        color: AppColors.kPrimaryLight,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _isNewLine = value ?? false;
                                        });
                                      }),
                                ),
                                BorderedButton(
                                  text: "${context.locale?.repeat}",
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    } else {
                                      context
                                          .read<LocalTextBloc>()
                                          .add(const IncrementAdCountEvent());
                                      if (((state.adCount ?? 1) + 1) % 3 != 0) {
                                        BlocProvider.of<LocalTextBloc>(context)
                                            .add(
                                          RepeatTextEvent(
                                            text: _textController.text,
                                            newLine: _isNewLine,
                                            times: int.tryParse(
                                                    _repeatController.text) ??
                                                0,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  color: AppColors.kPrimaryLight,
                                  isBordered: false,
                                  textStyle:
                                      context.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.kWhite,
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
                                        border: ContainerBorders
                                            .containerMediumBorder,
                                        borderRadius:
                                            ContainerBorders.borderRadius,
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
                                          textStyle: context
                                              .textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.kWhite),
                                          text: "${context.locale?.copy}",
                                          onPressed: () {
                                            // Metni panoya kopyala
                                            Clipboard.setData(ClipboardData(
                                                text: _outputController.text));
                                            Utils.showNotification(
                                              context,
                                              "${context.locale?.copiedTitle}",
                                              "${context.locale?.copiedMsg}",
                                              type: ToastificationType.success,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                          width: context.dynamicWidth(0.02)),
                                      Expanded(
                                        child: BorderedButton(
                                          isBordered: false,
                                          color: AppColors.kPrimaryLight,
                                          textStyle: context
                                              .textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.kWhite),
                                          text: "${context.locale?.share}",
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
            );
          },
        ),
      ),
    );
  }
}
