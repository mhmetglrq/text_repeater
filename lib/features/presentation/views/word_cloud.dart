import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart'; // Paylaşma paketi eklendi
import 'package:path_provider/path_provider.dart'; // Dosya yolu için gerekli
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/utility/utils/utils.dart';
import 'package:text_repeater/config/widgets/bordered_button.dart';
import 'package:text_repeater/config/widgets/input_field.dart';
import 'package:toastification/toastification.dart';
import 'package:word_cloud/word_cloud_data.dart';
import 'package:word_cloud/word_cloud_view.dart';

import '../../../config/items/borders/container_borders.dart';
import '../../../config/items/colors/app_colors.dart';
import '../../../config/models/text_model.dart';
import '../../../config/utility/helpers/ad_helper.dart';
import '../../../config/widgets/custom_appbar.dart';
import '../bloc/text/local/local_text_bloc.dart';

class WordCloud extends StatefulWidget {
  const WordCloud({super.key, this.textModel});
  final TextModel? textModel;

  @override
  State<WordCloud> createState() => _WordCloudState();
}

class _WordCloudState extends State<WordCloud> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final wcdata = WordCloudData(data: []);
  Key wordCloudKey = UniqueKey();
  final GlobalKey _wordCloudKey = GlobalKey(); // RepaintBoundary için anahtar

  @override
  void initState() {
    super.initState();
    if (widget.textModel != null) {
      _textController.text = widget.textModel!.text ?? "";
      BlocProvider.of<LocalTextBloc>(context).add(
        WordCloudEvent(
          text: widget.textModel!.text ?? "",
          isRecent: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _shareWidgetAsImage() async {
    try {
      RenderRepaintBoundary boundary = _wordCloudKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image =
          await boundary.toImage(pixelRatio: 3.0); // Yüksek çözünürlük için
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        // Geçici dosya oluşturma
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/word_cloud.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(pngBytes);
        final xFile = XFile(imageFile.path);
        // Dosyayı paylaş
        await Share.shareXFiles([xFile], text: "${context.locale?.shareText}");
      }
    } catch (e) {
      Utils.showNotification(
        context,
        "${context.locale?.errorTitle}",
        "${context.locale?.shareImgErrorDesc}",
        type: ToastificationType.error,
      );
    }
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
                  BlocProvider.of<LocalTextBloc>(context).add(
                    WordCloudEvent(
                      text: _textController.text,
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
                        title: "${context.locale?.wordCloudMenuTitle}",
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
                                  maxLines: 2,
                                  labelText: "${context.locale?.text}",
                                  controller: _textController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "${context.locale?.textValid}";
                                    }
                                    //value tek bir kelime olmamalı
                                    else if (value.split(" ").length == 1) {
                                      return "${context.locale?.wordCloudValid}";
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: context.paddingTopDefault,
                                  child: BorderedButton(
                                    text: "${context.locale?.createWordCloud}",
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      } else {
                                        context
                                            .read<LocalTextBloc>()
                                            .add(const IncrementAdCountEvent());
                                        if (((state.adCount ?? 1) + 1) % 3 !=
                                            0) {
                                          BlocProvider.of<LocalTextBloc>(
                                                  context)
                                              .add(
                                            WordCloudEvent(
                                              text: _textController.text,
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
                            wcdata.data = [];
                            log(wcdata.data.toString());
                            for (var element in state.wordCloudList ?? []) {
                              wcdata.addData(
                                  element["word"],
                                  double.tryParse(
                                          element["value"].toString()) ??
                                      10);
                            }
                            log("second${wcdata.data}");

                            wordCloudKey = UniqueKey();

                            return Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: RepaintBoundary(
                                      key: _wordCloudKey,
                                      child: WordCloudView(
                                        mintextsize: 12,
                                        maxtextsize: 120,
                                        data: wcdata,
                                        key: wordCloudKey,
                                        mapwidth: context.dynamicWidth(0.9),
                                        mapheight: context.dynamicHeight(0.4),
                                        colorlist: const [
                                          Colors.red,
                                          Colors.pink,
                                          Colors.purple,
                                          Colors.deepPurple,
                                          Colors.indigo,
                                          Colors.blue,
                                          Colors.lightBlue,
                                          Colors.cyan,
                                          Colors.teal,
                                          Colors.green,
                                          Colors.black,
                                          Colors.lightGreen,
                                          Colors.lime,
                                          Colors.yellow,
                                          Colors.amber,
                                          Colors.orange,
                                          Colors.deepOrange,
                                          Colors.brown,
                                        ],
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
                                          text: "${context.locale?.share}",
                                          onPressed: () {
                                            // Resmi Paylaş
                                            _shareWidgetAsImage();
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
