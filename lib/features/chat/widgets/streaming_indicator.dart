import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class StreamingIndicator extends StatelessWidget {
  final String currentText;

  const StreamingIndicator({super.key, required this.currentText});

  @override
  Widget build(BuildContext context) {
    if (currentText.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding,
        vertical: 6,
      ),
      padding: const EdgeInsets.all(0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      decoration: AppStyles.cardDecoration.copyWith(
        color: AppColors.botMessageBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.largeRadius),
          topRight: Radius.circular(AppDimensions.largeRadius),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(AppDimensions.largeRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header con icono y rol
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding,
              vertical: AppDimensions.smallPadding,
            ),
            decoration: BoxDecoration(
              color: AppColors.botMessageBg.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.largeRadius),
                topRight: Radius.circular(AppDimensions.largeRadius),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.smart_toy,
                  color: AppColors.messageText.withOpacity(0.9),
                  size: AppDimensions.smallIcon,
                ),
                const SizedBox(width: AppDimensions.smallPadding),
                Text(
                  'ChatBot (escribiendo...)',
                  style: TextStyle(
                    color: AppColors.messageText.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: AppDimensions.smallPadding),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.messageText.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Contenido del mensaje en streaming
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.defaultPadding,
              AppDimensions.smallPadding,
              AppDimensions.defaultPadding,
              AppDimensions.defaultPadding,
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: currentText, style: AppStyles.messageStyle),
                  WidgetSpan(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: _BlinkingCursor(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(width: 2, height: 16, color: AppColors.messageText),
        );
      },
    );
  }
}
