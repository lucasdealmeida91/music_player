// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/core/app/music_app_text_style.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/circular_progress_indicator_widget.dart';
import 'package:music_app/shared/widgets/app_music_error_widget.dart';
import 'package:music_app/shared/widgets/text_widget.dart';

class ScreenWidget extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final String title;
  final Widget child;
  final VoidCallback? onTryAgain;
  const ScreenWidget({
    Key? key,
    required this.isLoading,
    this.error,
    required this.title,
    required this.child,
    this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.bold(title,textStyle: MusicAppTextStyle.getNormalBoldStyle,),
      ),
      body: ColoredBox(
        color: MusicAppColors.primaryColor,
        child: SizedBox.expand(
          child: isLoading || error != null
              ? Center(
                  child: isLoading
                      ? const CircularProgressIndicatorWidget()
                      : AppMusicErrorWidget(
                        error: error!,
                        onTryAgain: onTryAgain,
                      ),
                )
              : child,
        ),
      ),
    );
  }
}
