import 'package:flutter/material.dart';

enum RzPaginationBasicAlign { left, center, right }

class RzPaginationBasic extends StatefulWidget {
  final int totalPage;
  final int currentPage;
  final Future<void> Function(int page)? onPageChanged;

  final bool showFirst;
  final bool showLast;
  final bool showPrevious;
  final bool showNext;
  final bool showNumbers;
  final bool showMidButton;
  final bool showLastButton;

  final int maxVisibleStartingNumbers;
  final int maxVisibleMidNumbers;
  final int maxVisibleLastNumbers;
  final int midThreshold;

  final dynamic firstButton;
  final dynamic previousButton;
  final dynamic nextButton;
  final dynamic lastButton;

  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color activeTextColor;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color selectedBackgroundColor;
  final Color borderColor;
  final Color activeBorderColor;
  final Color selectedBorderColor;
  final double borderWidth;
  final double activeBorderWidth;
  final double selectedBorderWidth;
  final double borderRadius;
  final double buttonPaddingH;
  final double buttonPaddingV;
  final double gap;
  final RzPaginationBasicAlign align;

  final String dotsText;
  final IconData dotsIcon;

  final Color firstSelectedColor;
  final Color firstSelectedTextColor;
  final Color lastSelectedColor;
  final Color lastSelectedTextColor;

  final Color midBackgroundColor;
  final Color midTextColor;
  final Color midActiveBackgroundColor;
  final Color midActiveTextColor;
  final Color midBorderColor;
  final Color midActiveBorderColor;

  final Color lastNumbersBackgroundColor;
  final Color lastNumbersTextColor;
  final Color lastNumbersActiveBackgroundColor;
  final Color lastNumbersActiveTextColor;
  final Color lastNumbersBorderColor;
  final Color lastNumbersActiveBorderColor;

  final Color dotsBackgroundColor;
  final Color dotsBorderColor;
  final Color dotsIconColor;

  const RzPaginationBasic({
    super.key,
    required this.totalPage,
    required this.currentPage,
    required this.onPageChanged,
    this.showFirst = true,
    this.showLast = true,
    this.showPrevious = true,
    this.showNext = true,
    this.showNumbers = true,
    this.showMidButton = false,
    this.showLastButton = false,
    this.maxVisibleStartingNumbers = 3,
    this.maxVisibleMidNumbers = 3,
    this.maxVisibleLastNumbers = 3,
    this.midThreshold = 20,
    this.firstButton = 'First',
    this.previousButton = 'Previous',
    this.nextButton = 'Next',
    this.lastButton = 'Last',
    this.fontSize = 13,
    this.fontWeight = FontWeight.w500,
    this.textColor = Colors.black87,
    this.activeTextColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.activeBackgroundColor = const Color(0xFF1976D2),
    this.selectedBackgroundColor = const Color(0xFF1976D2),
    this.borderColor = const Color(0xFFE0E0E0),
    this.activeBorderColor = const Color(0xFF1976D2),
    this.selectedBorderColor = const Color(0xFF1976D2),
    this.borderWidth = 1,
    this.activeBorderWidth = 1,
    this.selectedBorderWidth = 1,
    this.borderRadius = 6,
    this.buttonPaddingH = 12,
    this.buttonPaddingV = 7,
    this.gap = 6,
    this.align = RzPaginationBasicAlign.right,
    this.dotsText = '...',
    this.dotsIcon = Icons.more_horiz,
    this.firstSelectedColor = const Color(0xFF1976D2),
    this.firstSelectedTextColor = Colors.white,
    this.lastSelectedColor = const Color(0xFF1976D2),
    this.lastSelectedTextColor = Colors.white,
    this.midBackgroundColor = Colors.white,
    this.midTextColor = Colors.black87,
    this.midActiveBackgroundColor = const Color(0xFF1976D2),
    this.midActiveTextColor = Colors.white,
    this.midBorderColor = const Color(0xFFE0E0E0),
    this.midActiveBorderColor = const Color(0xFF1976D2),
    this.lastNumbersBackgroundColor = Colors.white,
    this.lastNumbersTextColor = Colors.black87,
    this.lastNumbersActiveBackgroundColor = const Color(0xFF1976D2),
    this.lastNumbersActiveTextColor = Colors.white,
    this.lastNumbersBorderColor = const Color(0xFFE0E0E0),
    this.lastNumbersActiveBorderColor = const Color(0xFF1976D2),
    this.dotsBackgroundColor = Colors.white,
    this.dotsBorderColor = const Color(0xFFE0E0E0),
    this.dotsIconColor = Colors.black54,
  });

  @override
  State<RzPaginationBasic> createState() => _RzPaginationBasicState();
}

class _RzPaginationBasicState extends State<RzPaginationBasic> {
  late int windowStart;
  late int midWindowStart;
  late int lastWindowStart;
  late int internalCurrentPage;

  // FLOOR METHOD
  int get midLeft {
    int value = (widget.totalPage / 2).floor();
    return value + 1;
  }

  int get midRight {
    int left = midLeft;
    return (widget.totalPage - left) + 1;
  }

  int get centerIndex {
    return midLeft;
  }

  int get effectiveMaxVisibleStarting {
    if (widget.maxVisibleStartingNumbers <= 0) {
      return 1;
    }
    if (widget.totalPage < widget.maxVisibleStartingNumbers) {
      return widget.totalPage;
    }
    return widget.maxVisibleStartingNumbers;
  }

  int get effectiveMaxVisibleMid {
    if (widget.maxVisibleMidNumbers <= 0) {
      return 1;
    }
    if (widget.totalPage < widget.maxVisibleMidNumbers) {
      return widget.totalPage;
    }
    return widget.maxVisibleMidNumbers;
  }

  int get effectiveMaxVisibleLast {
    if (widget.maxVisibleLastNumbers <= 0) {
      return 1;
    }
    if (widget.totalPage < widget.maxVisibleLastNumbers) {
      return widget.totalPage;
    }
    return widget.maxVisibleLastNumbers;
  }

  bool get hasMid {
    if (widget.showMidButton == false) {
      return false;
    }
    if (widget.totalPage <= widget.midThreshold) {
      return false;
    }
    return true;
  }

  bool get hasLastNumbers {
    if (widget.showLastButton == false) {
      return false;
    }
    if (widget.totalPage <= widget.midThreshold) {
      return false;
    }
    return true;
  }

  List<int> get startPages {
    List<int> pages = [];
    int end = windowStart + effectiveMaxVisibleStarting;
    for (int i = windowStart; i < end; i++) {
      if (i >= 0) {
        if (i < widget.totalPage) {
          pages.add(i);
        }
      }
    }
    return pages;
  }

  List<int> get midPages {
    if (hasMid == false) {
      return [];
    }
    List<int> pages = [];
    int end = midWindowStart + effectiveMaxVisibleMid;
    for (int i = midWindowStart; i < end; i++) {
      if (i >= 0) {
        if (i < widget.totalPage) {
          pages.add(i);
        }
      }
    }
    return pages;
  }

  List<int> get lastPages {
    if (hasLastNumbers == false) {
      return [];
    }
    List<int> pages = [];
    int end = lastWindowStart + effectiveMaxVisibleLast;
    for (int i = lastWindowStart; i < end; i++) {
      if (i >= 0) {
        if (i < widget.totalPage) {
          pages.add(i);
        }
      }
    }
    return pages;
  }

  int get maxWindowStart {
    int max = 0;
    if (hasMid == true || hasLastNumbers == true) {
      int leftHalf = midLeft;
      max = leftHalf - effectiveMaxVisibleStarting;
      if (max < 0) {
        max = 0;
      }
    } else {
      max = widget.totalPage - effectiveMaxVisibleStarting;
      if (max < 0) {
        max = 0;
      }
    }
    if (max > widget.totalPage) {
      max = widget.totalPage;
    }
    return max;
  }

  int get minMidStart {
    int min = effectiveMaxVisibleStarting + 1;
    if (min < 0) {
      min = 0;
    }
    return min;
  }

  int get maxMidStart {
    int max = 0;
    if (hasLastNumbers == true) {
      max =
          widget.totalPage -
              effectiveMaxVisibleMid -
              effectiveMaxVisibleLast -
              1;
    } else {
      max = widget.totalPage - effectiveMaxVisibleMid;
    }
    if (max < minMidStart) {
      max = minMidStart;
    }
    if (max < 0) {
      max = 0;
    }
    if (max > widget.totalPage) {
      max = widget.totalPage;
    }
    return max;
  }

  int get minLastStart {
    int value = 0;
    if (hasMid == true) {
      int afterMid = minMidStart + effectiveMaxVisibleMid + 1;
      int centerBased = centerIndex + 1;
      value = afterMid;
      if (centerBased > value) {
        value = centerBased;
      }
    } else {
      int centerBased = centerIndex + 1;
      value = centerBased;
    }
    return value;
  }

  int get maxLastStart {
    int max = widget.totalPage - effectiveMaxVisibleLast;
    if (max < 0) {
      max = 0;
    }
    if (max > widget.totalPage) {
      max = widget.totalPage;
    }
    if (max < minLastStart) {
      max = minLastStart;
    }
    return max;
  }

  int get middleMidStart {
    double halfMid = effectiveMaxVisibleMid / 2;
    int halfMidFloor = halfMid.floor();
    int start = centerIndex - halfMidFloor;
    if (start < minMidStart) {
      start = minMidStart;
    }
    if (start > maxMidStart) {
      start = maxMidStart;
    }
    return start;
  }

  int get middleLastStart {
    int last = widget.totalPage - effectiveMaxVisibleLast;
    if (last < minLastStart) {
      last = minLastStart;
    }
    if (last > maxLastStart) {
      last = maxLastStart;
    }
    return last;
  }

  @override
  void initState() {
    super.initState();
    internalCurrentPage = widget.currentPage;
    windowStart = 0;
    midWindowStart = middleMidStart;
    lastWindowStart = middleLastStart;
    _recalculateWindowsForPage(internalCurrentPage);
  }

  @override
  void didUpdateWidget(covariant RzPaginationBasic oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool needReset = false;

    if (oldWidget.totalPage != widget.totalPage) {
      needReset = true;
    }
    if (oldWidget.maxVisibleStartingNumbers !=
        widget.maxVisibleStartingNumbers) {
      needReset = true;
    }
    if (oldWidget.maxVisibleMidNumbers != widget.maxVisibleMidNumbers) {
      needReset = true;
    }
    if (oldWidget.maxVisibleLastNumbers != widget.maxVisibleLastNumbers) {
      needReset = true;
    }
    if (oldWidget.midThreshold != widget.midThreshold) {
      needReset = true;
    }
    if (oldWidget.showMidButton != widget.showMidButton) {
      needReset = true;
    }
    if (oldWidget.showLastButton != widget.showLastButton) {
      needReset = true;
    }

    if (needReset == true) {
      windowStart = 0;
      midWindowStart = middleMidStart;
      lastWindowStart = middleLastStart;
      _recalculateWindowsForPage(widget.currentPage);
    }

    if (widget.currentPage != internalCurrentPage) {
      internalCurrentPage = widget.currentPage;
      _recalculateWindowsForPage(internalCurrentPage);
    }
  }

  void _recalculateWindowsForPage(int newPage) {
    if (newPage < 0) {
      return;
    }
    if (newPage >= widget.totalPage) {
      return;
    }

    if (newPage == 0) {
      windowStart = 0;
      if (hasMid == true) {
        midWindowStart = middleMidStart;
      }
      if (hasLastNumbers == true) {
        lastWindowStart = middleLastStart;
      }
      return;
    }

    if (newPage == widget.totalPage - 1) {
      windowStart = maxWindowStart;
      midWindowStart = maxMidStart;
      lastWindowStart = maxLastStart;
      return;
    }

    bool isStart = false;
    List<int> currentStartPages = startPages;
    for (int p = 0; p < currentStartPages.length; p++) {
      if (currentStartPages[p] == newPage) {
        isStart = true;
        break;
      }
    }

    bool isMid = false;
    List<int> currentMidPages = midPages;
    for (int p = 0; p < currentMidPages.length; p++) {
      if (currentMidPages[p] == newPage) {
        isMid = true;
        break;
      }
    }

    bool isLast = false;
    List<int> currentLastPages = lastPages;
    for (int p = 0; p < currentLastPages.length; p++) {
      if (currentLastPages[p] == newPage) {
        isLast = true;
        break;
      }
    }

    if (isStart == true) {
      int lastVisible = windowStart + effectiveMaxVisibleStarting - 1;
      if (newPage == lastVisible) {
        if (windowStart < maxWindowStart) {
          windowStart = windowStart + 1;
          if (windowStart > maxWindowStart) {
            windowStart = maxWindowStart;
          }
          if (hasMid == true) {
            midWindowStart = midWindowStart + 1;
            if (midWindowStart < minMidStart) {
              midWindowStart = minMidStart;
            }
            if (midWindowStart > maxMidStart) {
              midWindowStart = maxMidStart;
            }
          }
          if (hasLastNumbers == true) {
            lastWindowStart = lastWindowStart + 1;
            if (lastWindowStart < minLastStart) {
              lastWindowStart = minLastStart;
            }
            if (lastWindowStart > maxLastStart) {
              lastWindowStart = maxLastStart;
            }
          }
        }
      } else if (newPage == windowStart) {
        if (windowStart > 0) {
          windowStart = windowStart - 1;
          if (windowStart < 0) {
            windowStart = 0;
          }
          if (hasMid == true) {
            midWindowStart = midWindowStart - 1;
            if (midWindowStart < minMidStart) {
              midWindowStart = minMidStart;
            }
            if (midWindowStart > maxMidStart) {
              midWindowStart = maxMidStart;
            }
          }
          if (hasLastNumbers == true) {
            lastWindowStart = lastWindowStart - 1;
            if (lastWindowStart < minLastStart) {
              lastWindowStart = minLastStart;
            }
            if (lastWindowStart > maxLastStart) {
              lastWindowStart = maxLastStart;
            }
          }
        }
      }
    } else if (isMid == true) {
      int midLast = midWindowStart + effectiveMaxVisibleMid - 1;
      int midFirst = midWindowStart;
      if (newPage == midLast) {
        if (midWindowStart < maxMidStart) {
          midWindowStart = midWindowStart + 1;
          windowStart = windowStart + 1;
          if (windowStart < 0) {
            windowStart = 0;
          }
          if (windowStart > maxWindowStart) {
            windowStart = maxWindowStart;
          }
          if (hasLastNumbers == true) {
            lastWindowStart = lastWindowStart + 1;
            if (lastWindowStart < minLastStart) {
              lastWindowStart = minLastStart;
            }
            if (lastWindowStart > maxLastStart) {
              lastWindowStart = maxLastStart;
            }
          }
        }
      } else if (newPage == midFirst) {
        if (midFirst > minMidStart) {
          midWindowStart = midWindowStart - 1;
          windowStart = windowStart - 1;
          if (windowStart < 0) {
            windowStart = 0;
          }
          if (windowStart > maxWindowStart) {
            windowStart = maxWindowStart;
          }
          if (hasLastNumbers == true) {
            lastWindowStart = lastWindowStart - 1;
            if (lastWindowStart < minLastStart) {
              lastWindowStart = minLastStart;
            }
            if (lastWindowStart > maxLastStart) {
              lastWindowStart = maxLastStart;
            }
          }
        }
      }
    } else if (isLast == true) {
      int lastLast = lastWindowStart + effectiveMaxVisibleLast - 1;
      int lastFirst = lastWindowStart;
      if (newPage == lastLast) {
        if (lastLast < maxLastStart + effectiveMaxVisibleLast - 1) {
          lastWindowStart = lastWindowStart + 1;
          if (lastWindowStart < minLastStart) {
            lastWindowStart = minLastStart;
          }
          if (lastWindowStart > maxLastStart) {
            lastWindowStart = maxLastStart;
          }
          if (hasMid == true) {
            midWindowStart = midWindowStart + 1;
            if (midWindowStart < minMidStart) {
              midWindowStart = minMidStart;
            }
            if (midWindowStart > maxMidStart) {
              midWindowStart = maxMidStart;
            }
          }
        }
      } else if (newPage == lastFirst) {
        if (lastFirst > minLastStart) {
          lastWindowStart = lastWindowStart - 1;
          if (lastWindowStart < minLastStart) {
            lastWindowStart = minLastStart;
          }
          if (lastWindowStart > maxLastStart) {
            lastWindowStart = maxLastStart;
          }
          if (hasMid == true) {
            midWindowStart = midWindowStart - 1;
            if (midWindowStart < minMidStart) {
              midWindowStart = minMidStart;
            }
            if (midWindowStart > maxMidStart) {
              midWindowStart = maxMidStart;
            }
          }
        }
      }
    } else {
      if (newPage < windowStart) {
        windowStart = newPage;
        if (windowStart < 0) {
          windowStart = 0;
        }
        if (windowStart > maxWindowStart) {
          windowStart = maxWindowStart;
        }
      } else if (newPage >= windowStart + effectiveMaxVisibleStarting) {
        windowStart = newPage - effectiveMaxVisibleStarting + 1;
        if (windowStart < 0) {
          windowStart = 0;
        }
        if (windowStart > maxWindowStart) {
          windowStart = maxWindowStart;
        }
      }
      if (newPage >= minMidStart && newPage < minLastStart) {
        midWindowStart = newPage;
        if (midWindowStart < minMidStart) {
          midWindowStart = minMidStart;
        }
        if (midWindowStart > maxMidStart) {
          midWindowStart = maxMidStart;
        }
      }
      if (newPage >= minLastStart) {
        lastWindowStart = newPage;
        if (lastWindowStart < minLastStart) {
          lastWindowStart = minLastStart;
        }
        if (lastWindowStart > maxLastStart) {
          lastWindowStart = maxLastStart;
        }
      }
    }
  }

  Future<void> _handlePageChange(int newPage) async {
    if (newPage < 0) {
      return;
    }
    if (newPage >= widget.totalPage) {
      return;
    }
    if (newPage == internalCurrentPage) {
      return;
    }

    setState(() {
      internalCurrentPage = newPage;
      _recalculateWindowsForPage(newPage);
    });

    if (widget.onPageChanged != null) {
      await widget.onPageChanged!(newPage);
    }
  }

  Widget _buildContent(dynamic data) {
    if (data is Widget) {
      return data;
    }
    if (data is IconData) {
      return Icon(data, size: widget.fontSize + 4);
    }
    return Text(
      data.toString(),
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
    );
  }

  Widget _dotsButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.buttonPaddingH,
        vertical: widget.buttonPaddingV,
      ),
      decoration: BoxDecoration(
        color: widget.dotsBackgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.dotsBorderColor,
          width: widget.borderWidth,
        ),
      ),
      child: Icon(
        widget.dotsIcon,
        size: widget.fontSize + 4,
        color: widget.dotsIconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.totalPage <= 1) {
      return const SizedBox.shrink();
    }

    List<Widget> children = [];

    Widget btn({
      required dynamic label,
      VoidCallback? onTap,
      bool isActive = false,
      bool isSelected = false,
      Color? selBg,
      Color? selTxt,
      Color? selBorder,
      Color? bg,
      Color? txt,
      Color? border,
      Color? activeBg,
      Color? activeTxt,
      Color? activeBorder,
      String? keyValue,
    }) {
      Color b;
      Color t;
      Color br;
      double bw;
      FontWeight fw;

      if (isSelected == true) {
        b = selBg ?? widget.selectedBackgroundColor;
        t = selTxt ?? widget.activeTextColor;
        br = selBorder ?? widget.selectedBorderColor;
        bw = widget.selectedBorderWidth;
        fw = FontWeight.bold;
      } else if (isActive == true) {
        b = activeBg ?? bg ?? widget.activeBackgroundColor;
        t = activeTxt ?? txt ?? widget.activeTextColor;
        br = activeBorder ?? border ?? widget.activeBorderColor;
        bw = widget.activeBorderWidth;
        fw = FontWeight.bold;
      } else {
        b = bg ?? widget.backgroundColor;
        t = txt ?? widget.textColor;
        br = border ?? widget.borderColor;
        bw = widget.borderWidth;
        fw = widget.fontWeight;
      }

      if (onTap == null && isActive == false && isSelected == false) {
        t = Colors.grey;
      }

      return InkWell(
        key: keyValue != null ? ValueKey(keyValue) : null,
        onTap: onTap,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.buttonPaddingH,
            vertical: widget.buttonPaddingV,
          ),
          decoration: BoxDecoration(
            color: b,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: br, width: bw),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: fw,
              color: t,
            ),
            child: IconTheme(
              data: IconThemeData(size: widget.fontSize + 4, color: t),
              child: _buildContent(label),
            ),
          ),
        ),
      );
    }

    bool firstSel = false;
    if (internalCurrentPage == 0) {
      firstSel = true;
    }

    bool lastSel = false;
    if (internalCurrentPage == widget.totalPage - 1) {
      lastSel = true;
    }

    if (widget.showFirst == true) {
      children.add(
        btn(
          keyValue: 'first',
          label: widget.firstButton,
          isSelected: firstSel,
          selBg: widget.firstSelectedColor,
          selTxt: widget.firstSelectedTextColor,
          selBorder: widget.selectedBorderColor,
          onTap: internalCurrentPage > 0 ? () => _handlePageChange(0) : null,
        ),
      );
    }

    if (widget.showPrevious == true) {
      children.add(
        btn(
          keyValue: 'prev',
          label: widget.previousButton,
          onTap: internalCurrentPage > 0
              ? () => _handlePageChange(internalCurrentPage - 1)
              : null,
        ),
      );
    }

    if (widget.showNumbers == true) {
      if (windowStart > 0) {
        children.add(_dotsButton());
      }

      List<int> sPages = startPages;
      for (int index = 0; index < sPages.length; index++) {
        int p = sPages[index];
        children.add(
          btn(
            keyValue: 's_$p',
            label: '${p + 1}',
            isActive: p == internalCurrentPage,
            onTap: () => _handlePageChange(p),
          ),
        );
      }

      if (hasMid == true) {
        if (startPages.isNotEmpty == true && midPages.isNotEmpty == true) {
          if (startPages.last + 1 < midPages.first) {
            children.add(_dotsButton());
          }
        }

        List<int> mPages = midPages;
        for (int index = 0; index < mPages.length; index++) {
          int m = mPages[index];
          if (startPages.contains(m) == true) {
            continue;
          }
          if (hasLastNumbers == true) {
            if (lastPages.contains(m) == true) {
              continue;
            }
          }
          if (m == 0 && widget.showFirst == true) {
            continue;
          }
          children.add(
            btn(
              keyValue: 'm_$m',
              label: '${m + 1}',
              isActive: m == internalCurrentPage,
              bg: widget.midBackgroundColor,
              txt: widget.midTextColor,
              border: widget.midBorderColor,
              activeBg: widget.midActiveBackgroundColor,
              activeTxt: widget.midActiveTextColor,
              activeBorder: widget.midActiveBorderColor,
              onTap: () => _handlePageChange(m),
            ),
          );
        }
      }

      if (hasLastNumbers == true) {
        if (hasMid == true) {
          if (midPages.isNotEmpty == true && lastPages.isNotEmpty == true) {
            if (midPages.last + 1 < lastPages.first) {
              children.add(_dotsButton());
            }
          }
        } else {
          if (startPages.isNotEmpty == true && lastPages.isNotEmpty == true) {
            if (startPages.last + 1 < lastPages.first) {
              children.add(_dotsButton());
            }
          }
        }

        List<int> lPages = lastPages;
        for (int index = 0; index < lPages.length; index++) {
          int l = lPages[index];
          if (startPages.contains(l) == true) {
            continue;
          }
          if (hasMid == true) {
            if (midPages.contains(l) == true) {
              continue;
            }
          }
          children.add(
            btn(
              keyValue: 'l_$l',
              label: '${l + 1}',
              isActive: l == internalCurrentPage,
              bg: widget.lastNumbersBackgroundColor,
              txt: widget.lastNumbersTextColor,
              border: widget.lastNumbersBorderColor,
              activeBg: widget.lastNumbersActiveBackgroundColor,
              activeTxt: widget.lastNumbersActiveTextColor,
              activeBorder: widget.lastNumbersActiveBorderColor,
              onTap: () => _handlePageChange(l),
            ),
          );
        }

        if (lastPages.isNotEmpty == true) {
          if (lastPages.last < widget.totalPage - 1) {
            children.add(_dotsButton());
          }
        }
      } else {
        if (hasMid == false) {
          if (windowStart + effectiveMaxVisibleStarting < widget.totalPage) {
            if (startPages.isNotEmpty == true) {
              if (startPages.last < widget.totalPage - 1) {
                children.add(_dotsButton());
              }
            }
          }
        } else {
          if (midPages.isNotEmpty == true) {
            if (midPages.last < widget.totalPage - 1) {
              children.add(_dotsButton());
            }
          }
        }
      }
    }

    if (widget.showNext == true) {
      children.add(
        btn(
          keyValue: 'next',
          label: widget.nextButton,
          onTap: internalCurrentPage < widget.totalPage - 1
              ? () => _handlePageChange(internalCurrentPage + 1)
              : null,
        ),
      );
    }

    if (widget.showLast == true) {
      children.add(
        btn(
          keyValue: 'last',
          label: widget.lastButton,
          isSelected: lastSel,
          selBg: widget.lastSelectedColor,
          selTxt: widget.lastSelectedTextColor,
          selBorder: widget.selectedBorderColor,
          onTap: internalCurrentPage < widget.totalPage - 1
              ? () => _handlePageChange(widget.totalPage - 1)
              : null,
        ),
      );
    }

    Alignment alignmentValue;
    switch (widget.align) {
      case RzPaginationBasicAlign.left:
        alignmentValue = Alignment.centerLeft;
        break;
      case RzPaginationBasicAlign.center:
        alignmentValue = Alignment.center;
        break;
      case RzPaginationBasicAlign.right:
        alignmentValue = Alignment.centerRight;
        break;
    }

    return Container(
      width: double.infinity,
      alignment: alignmentValue,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children.map((Widget e) {
            return Padding(
              padding: EdgeInsets.only(right: widget.gap),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}