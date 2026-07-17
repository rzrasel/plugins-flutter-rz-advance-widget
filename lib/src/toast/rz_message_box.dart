import 'package:flutter/material.dart';
import '/rz_advance_widget.dart';

class RzMessageBox extends StatelessWidget {
  final String message;
  final RzMessageBoxType type;
  final IconData? icon;
  final bool showIcon;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double borderRadius;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;

  const RzMessageBox({
    super.key,
    required this.message,
    this.type = RzMessageBoxType.info,
    this.icon,
    this.showIcon = true,
    this.showCloseButton = true,
    this.onClose,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.boxShadow,
  });

  static void show(
    BuildContext context, {
    required String message,
    RzMessageBoxType type = RzMessageBoxType.info,
    Duration duration = const Duration(seconds: 3),
    RzMessageBoxPosition position = RzMessageBoxPosition.top,
    double top = 16,
    double bottom = 16,
    double left = 16,
    double right = 16,
    IconData? icon,
    bool showIcon = true,
    bool showCloseButton = true,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    List<BoxShadow>? boxShadow,
  }) {
    RzOverlayManager.show(
      context,
      RzMessageBox(
        message: message,
        type: type,
        icon: icon,
        showIcon: showIcon,
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        textColor: textColor,
        iconColor: iconColor,
        boxShadow: boxShadow,
        onClose: () => RzOverlayManager.hide(),
      ),
      duration: duration,
      position: position,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor ?? config.bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? config.borderColor,
          width: borderWidth,
        ),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showIcon) ...[
            Icon(
              icon ?? config.icon,
              color: iconColor ?? config.iconColor,
              size: 22,
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? config.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
          if (showCloseButton) ...[
            const SizedBox(width: 12),
            InkWell(
              onTap: onClose ?? () => RzOverlayManager.hide(),
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                Icons.close,
                size: 18,
                color: iconColor ?? config.iconColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  _MessageConfig _getConfig() {
    switch (type) {
      case RzMessageBoxType.success:
        return _MessageConfig(
          icon: Icons.check_circle_rounded,
          bgColor: const Color(0xFFECFDF5),
          borderColor: const Color(0xFFA7F3D0),
          iconColor: const Color(0xFF059669),
          textColor: const Color(0xFF065F46),
        );
      case RzMessageBoxType.error:
        return _MessageConfig(
          icon: Icons.error_rounded,
          bgColor: const Color(0xFFFEF2F2),
          borderColor: const Color(0xFFFECACA),
          iconColor: const Color(0xFFDC2626),
          textColor: const Color(0xFF991B1B),
        );
      case RzMessageBoxType.warning:
        return _MessageConfig(
          icon: Icons.warning_rounded,
          bgColor: const Color(0xFFFFFBEB),
          borderColor: const Color(0xFFFDE68A),
          iconColor: const Color(0xFFD97706),
          textColor: const Color(0xFF92400E),
        );
      case RzMessageBoxType.info:
        return _MessageConfig(
          icon: Icons.info_rounded,
          bgColor: const Color(0xFFEFF6FF),
          borderColor: const Color(0xFFBFDBFE),
          iconColor: const Color(0xFF2563EB),
          textColor: const Color(0xFF1E40AF),
        );
      case RzMessageBoxType.custom:
        return _MessageConfig(
          icon: Icons.notifications_rounded,
          bgColor: Colors.white,
          borderColor: Colors.grey.shade200,
          iconColor: Colors.black87,
          textColor: Colors.black87,
        );
    }
  }
}

class RzOverlayManager {
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context,
    Widget child, {
    required Duration duration,
    required RzMessageBoxPosition position,
    required double top,
    required double bottom,
    required double left,
    required double right,
  }) {
    hide();
    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) {
        Alignment alignment;
        switch (position) {
          case RzMessageBoxPosition.top:
            alignment = Alignment.topCenter;
            break;
          case RzMessageBoxPosition.bottom:
            alignment = Alignment.bottomCenter;
            break;
          case RzMessageBoxPosition.topLeft:
            alignment = Alignment.topLeft;
            break;
          case RzMessageBoxPosition.topRight:
            alignment = Alignment.topRight;
            break;
          case RzMessageBoxPosition.bottomLeft:
            alignment = Alignment.bottomLeft;
            break;
          case RzMessageBoxPosition.bottomRight:
            alignment = Alignment.bottomRight;
            break;
          case RzMessageBoxPosition.center:
            alignment = Alignment.center;
            break;
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: alignment,
                child: Padding(
                  padding: EdgeInsets.only(
                    top:
                        position == RzMessageBoxPosition.bottom ||
                            position == RzMessageBoxPosition.bottomLeft ||
                            position == RzMessageBoxPosition.bottomRight ||
                            position == RzMessageBoxPosition.center
                        ? 0
                        : top + MediaQuery.of(context).padding.top,
                    bottom:
                        position == RzMessageBoxPosition.top ||
                            position == RzMessageBoxPosition.topLeft ||
                            position == RzMessageBoxPosition.topRight ||
                            position == RzMessageBoxPosition.center
                        ? 0
                        : bottom + MediaQuery.of(context).padding.bottom,
                    left: left,
                    right: right,
                  ),
                  // FIXED PART HERE
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    // FIXED: was easeOutBack
                    builder: (context, double val, child) {
                      return Opacity(
                        opacity: val.clamp(0.0, 1.0), // FIXED: clamp added
                        child: Transform.translate(
                          offset: Offset(0, (1 - val) * -20),
                          child: child,
                        ),
                      );
                    },
                    child: Material(color: Colors.transparent, child: child),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_currentEntry!);
    if (duration != Duration.zero) {
      Future.delayed(duration, () => hide());
    }
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _MessageConfig {
  final IconData icon;
  final Color bgColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  _MessageConfig({
    required this.icon,
    required this.bgColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });
}

/*
RzMessageBox.show(
context,
message: "Payment successful!",
type: RzMessageBoxType.success,
);

RzMessageBox.show(
context,
message: "Failed to connect. Try again.",
type: RzMessageBoxType.error,
position: RzMessageBoxPosition.top,
duration: Duration(seconds: 4),
);*/

/*RzMessageBox.show(
context,
message: "Custom message with your brand color",
type: RzMessageBoxType.custom,
backgroundColor: Colors.black,
textColor: Colors.white,
borderColor: Colors.black,
iconColor: Colors.white,
icon: Icons.rocket_launch_rounded,
showIcon: true, // set false to hide icon completely
position: RzMessageBoxPosition.bottom,
left: 20,
right: 20,
bottom: 30,
boxShadow: [
BoxShadow(color: Colors.black26, blurRadius: 20)
],
);*/

/*As inline widget in a form

RzMessageBox(
message: "Invalid email address",
type: RzMessageBoxType.error,
showCloseButton: false,
)*/
