import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class MessageBubble extends StatelessWidget {
  final String role;
  final String content;

  const MessageBubble({super.key, required this.role, required this.content});

  @override
  Widget build(BuildContext context) {
    final isUser = role == 'user';
    final isSystem = role == 'system';

    // Colores del tema
    Color bgColor;
    IconData icon;

    if (isUser) {
      bgColor = AppColors.userMessageBg;
      icon = Icons.person;
    } else if (isSystem) {
      bgColor = AppColors.systemMessageBg;
      icon = Icons.info;
    } else {
      bgColor = AppColors.botMessageBg;
      icon = Icons.smart_toy;
    }

    final align = isUser ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: AppStyles.cardDecoration.copyWith(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppDimensions.largeRadius),
            topRight: const Radius.circular(AppDimensions.largeRadius),
            bottomLeft: isUser
                ? const Radius.circular(AppDimensions.largeRadius)
                : const Radius.circular(4),
            bottomRight: isUser
                ? const Radius.circular(4)
                : const Radius.circular(AppDimensions.largeRadius),
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
                color: bgColor.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.largeRadius),
                  topRight: Radius.circular(AppDimensions.largeRadius),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: AppColors.messageText.withOpacity(0.9),
                    size: AppDimensions.smallIcon,
                  ),
                  const SizedBox(width: AppDimensions.smallPadding),
                  Text(
                    isUser ? 'Tú' : (isSystem ? 'Sistema' : 'ChatBot'),
                    style: TextStyle(
                      color: AppColors.messageText.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Contenido del mensaje
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.defaultPadding,
                AppDimensions.smallPadding,
                AppDimensions.defaultPadding,
                AppDimensions.defaultPadding,
              ),
              child: Text(content, style: AppStyles.messageStyle),
            ),
          ],
        ),
      ),
    );
  }
}
