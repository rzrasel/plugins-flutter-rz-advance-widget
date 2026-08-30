import 'package:flutter/material.dart';

enum RzMaterialDataTableBasicAlign { left, center, right }

enum RzMaterialDataTableBasicPaginationMode { full, minimal, compact }

class RzMaterialDataTableBasic<T> extends StatefulWidget {
  final List<dynamic>? headers;
  final List<T> items;
  final List<dynamic> Function(T item)? rowBuilder;
  final String Function(T item) searchableBuilder;
  final Comparable Function(T item, int columnIndex)? sortValueBuilder;
  final void Function(T item)? onRowTap;

  final bool showSearch;
  final bool showPagination;
  final int rowsPerPage;
  final List<int> rowsPerPageOptions;
  final double borderRadius;
  final Color borderColor;

  final bool showHeader;
  final bool enableOddEven;
  final Color oddRowColor;
  final Color evenRowColor;
  final Color headerColor;
  final Widget? footer;
  final Widget? emptyWidget;
  final List<DataColumn>? columns;

  final bool showScrollbar;
  final bool showHorizontalScrollbar;
  final double? maxHeight;

  final List<double>? columnWidths;
  final List<double>? columnMinWidths;

  final RzMaterialDataTableBasicAlign align;
  final RzMaterialDataTableBasicAlign headerAlign;
  final List<RzMaterialDataTableBasicAlign>? columnAligns;

  final FontWeight headerFontWeight;
  final FontWeight cellFontWeight;
  final double? headerFontSize;
  final double? cellFontSize;
  final TextStyle? headerTextStyle;
  final TextStyle? cellTextStyle;

  final dynamic tableHeader;
  final RzMaterialDataTableBasicAlign tableHeaderAlign;
  final double? tableHeaderFontSize;
  final FontWeight tableHeaderFontWeight;
  final TextStyle? tableHeaderTextStyle;

  final dynamic tableFooter;
  final RzMaterialDataTableBasicAlign tableFooterAlign;
  final double? tableFooterFontSize;
  final FontWeight tableFooterFontWeight;
  final TextStyle? tableFooterTextStyle;

  final bool enableDoubleClickEdit;
  final List<bool>? editableColumns;
  final void Function(T item, int columnIndex, dynamic newValue)? onCellChanged;
  final Widget Function(
    T item,
    int columnIndex,
    dynamic currentValue,
    void Function(dynamic newValue) onSave,
    VoidCallback onCancel,
  )?
  cellEditorBuilder;

  final bool enableSorting;
  final List<bool>? sortableColumns;

  final RzMaterialDataTableBasicPaginationMode paginationMode;
  final RzMaterialDataTableBasicAlign paginationAlign;
  final bool showFirstButton;
  final bool showLastButton;
  final bool showPrevNext;
  final bool showPageNumbers;
  final bool showMidRange;
  final int midRangeThreshold;
  final double paginationButtonFontSize;
  final FontWeight paginationButtonFontWeight;
  final Color paginationButtonTextColor;
  final Color paginationButtonActiveColor;
  final Color paginationButtonActiveTextColor;
  final Color paginationButtonBorderColor;
  final double paginationButtonBorderRadius;
  final double paginationButtonPaddingH;
  final double paginationButtonPaddingV;

  final String paginationFirstText;
  final String paginationPrevText;
  final String paginationNextText;
  final String paginationLastText;

  const RzMaterialDataTableBasic({
    super.key,
    this.headers,
    this.columns,
    required this.items,
    this.rowBuilder,
    required this.searchableBuilder,
    this.sortValueBuilder,
    this.onRowTap,
    this.showSearch = true,
    this.showPagination = true,
    this.rowsPerPage = 10,
    this.rowsPerPageOptions = const [5, 10, 25, 50, 100],
    this.borderRadius = 8,
    this.borderColor = const Color(0xFFE0E0E0),
    this.showHeader = true,
    this.enableOddEven = true,
    this.oddRowColor = const Color(0xFFFFFFFF),
    this.evenRowColor = const Color(0xFFF9FAFB),
    this.headerColor = const Color(0xFFF5F5F5),
    this.footer,
    this.emptyWidget,
    this.showScrollbar = true,
    this.showHorizontalScrollbar = true,
    this.maxHeight,
    this.columnWidths,
    this.columnMinWidths,
    this.align = RzMaterialDataTableBasicAlign.center,
    this.headerAlign = RzMaterialDataTableBasicAlign.center,
    this.columnAligns,
    this.headerFontWeight = FontWeight.w600,
    this.cellFontWeight = FontWeight.w400,
    this.headerFontSize,
    this.cellFontSize,
    this.headerTextStyle,
    this.cellTextStyle,
    this.tableHeader,
    this.tableHeaderAlign = RzMaterialDataTableBasicAlign.left,
    this.tableHeaderFontSize = 18,
    this.tableHeaderFontWeight = FontWeight.bold,
    this.tableHeaderTextStyle,
    this.tableFooter,
    this.tableFooterAlign = RzMaterialDataTableBasicAlign.left,
    this.tableFooterFontSize = 14,
    this.tableFooterFontWeight = FontWeight.w500,
    this.tableFooterTextStyle,
    this.enableDoubleClickEdit = false,
    this.editableColumns,
    this.onCellChanged,
    this.cellEditorBuilder,
    this.enableSorting = true,
    this.sortableColumns,
    this.paginationMode = RzMaterialDataTableBasicPaginationMode.full,
    this.paginationAlign = RzMaterialDataTableBasicAlign.right,
    this.showFirstButton = true,
    this.showLastButton = true,
    this.showPrevNext = true,
    this.showPageNumbers = true,
    this.showMidRange = true,
    this.midRangeThreshold = 30,
    this.paginationButtonFontSize = 13,
    this.paginationButtonFontWeight = FontWeight.w500,
    this.paginationButtonTextColor = Colors.black87,
    this.paginationButtonActiveColor = const Color(0xFF1976D2),
    this.paginationButtonActiveTextColor = Colors.white,
    this.paginationButtonBorderColor = const Color(0xFFE0E0E0),
    this.paginationButtonBorderRadius = 6,
    this.paginationButtonPaddingH = 10,
    this.paginationButtonPaddingV = 6,
    this.paginationFirstText = 'First',
    this.paginationPrevText = 'Previous',
    this.paginationNextText = 'Next',
    this.paginationLastText = 'Last',
  });

  @override
  State<RzMaterialDataTableBasic<T>> createState() =>
      _RzMaterialDataTableBasicState<T>();
}

class _RzMaterialDataTableBasicState<T>
    extends State<RzMaterialDataTableBasic<T>> {
  late List<T> filtered;
  late List<T> displayed;
  String query = '';
  int sortCol = -1;
  bool asc = true;
  int page = 0;
  late int _currentRowsPerPage;
  final _hScroll = ScrollController();
  final _vScroll = ScrollController();
  int? editingRow;
  int? editingCol;
  final _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentRowsPerPage = widget.rowsPerPage;
    filtered = List.from(widget.items);
    displayed = [];
    _paginate();
  }

  @override
  void didUpdateWidget(covariant RzMaterialDataTableBasic<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      filtered = List.from(widget.items);
      if (query.isNotEmpty) {
        filtered = widget.items
            .where(
              (e) => widget
                  .searchableBuilder(e)
                  .toLowerCase()
                  .contains(query.toLowerCase()),
            )
            .toList();
      }
      if (sortCol != -1) {
        _applySortWithoutSetState();
      }
      page = 0;
      _paginate();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _hScroll.dispose();
    _vScroll.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _filter(String q) {
    setState(() {
      query = q;
      filtered = q.isEmpty
          ? List.from(widget.items)
          : widget.items
                .where(
                  (e) => widget
                      .searchableBuilder(e)
                      .toLowerCase()
                      .contains(q.toLowerCase()),
                )
                .toList();
      page = 0;
      _paginate();
    });
  }

  bool _isSortable(int col) {
    if (!widget.enableSorting) return false;
    if (widget.sortableColumns != null) {
      if (col < widget.sortableColumns!.length) {
        return widget.sortableColumns![col];
      } else {
        return false;
      }
    }
    return true;
  }

  void _applySortWithoutSetState() {
    if (sortCol < 0) return;
    if (!_isSortable(sortCol)) return;
    if (widget.sortValueBuilder != null) {
      filtered.sort((a, b) {
        final av = widget.sortValueBuilder!(a, sortCol);
        final bv = widget.sortValueBuilder!(b, sortCol);
        return asc ? Comparable.compare(av, bv) : Comparable.compare(bv, av);
      });
    } else if (widget.rowBuilder != null) {
      filtered.sort((a, b) {
        final av = widget.rowBuilder!(a)[sortCol];
        final bv = widget.rowBuilder!(b)[sortCol];
        String sa = av is String
            ? av
            : av is Widget
            ? ''
            : av.toString();
        String sb = bv is String
            ? bv
            : bv is Widget
            ? ''
            : bv.toString();
        return asc ? sa.compareTo(sb) : sb.compareTo(sa);
      });
    }
  }

  void _sort(int col) {
    if (!_isSortable(col)) return;
    setState(() {
      if (sortCol == col) {
        asc = !asc;
      } else {
        sortCol = col;
        asc = true;
      }
      _applySortWithoutSetState();
      _paginate();
    });
  }

  void _paginate() {
    if (!widget.showPagination) {
      displayed = List.from(filtered);
      return;
    }
    if (filtered.isEmpty) {
      displayed = [];
      return;
    }
    final start = page * _currentRowsPerPage;
    if (start >= filtered.length) {
      page = 0;
      displayed = filtered.take(_currentRowsPerPage).toList();
      return;
    }
    final end = (start + _currentRowsPerPage).clamp(0, filtered.length);
    displayed = filtered.sublist(start, end);
  }

  void _changeRowsPerPage(int? v) {
    if (v == null) return;
    setState(() {
      _currentRowsPerPage = v;
      page = 0;
      _paginate();
    });
  }

  void _goToPage(int p) {
    final total = (filtered.length / _currentRowsPerPage).ceil();
    setState(() {
      page = p.clamp(0, total - 1);
      _paginate();
    });
  }

  Alignment _toAlign(RzMaterialDataTableBasicAlign a) {
    switch (a) {
      case RzMaterialDataTableBasicAlign.left:
        return Alignment.centerLeft;
      case RzMaterialDataTableBasicAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  MainAxisAlignment _toMainAlign(RzMaterialDataTableBasicAlign a) {
    switch (a) {
      case RzMaterialDataTableBasicAlign.left:
        return MainAxisAlignment.start;
      case RzMaterialDataTableBasicAlign.right:
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.center;
    }
  }

  RzMaterialDataTableBasicAlign _colAlign(int i) =>
      widget.columnAligns != null && i < widget.columnAligns!.length
      ? widget.columnAligns![i]
      : widget.align;

  RzMaterialDataTableBasicAlign _headerColAlign(int i) =>
      widget.columnAligns != null && i < widget.columnAligns!.length
      ? widget.columnAligns![i]
      : widget.headerAlign;

  bool _isEditable(int col) =>
      widget.editableColumns != null && col < widget.editableColumns!.length
      ? widget.editableColumns![col]
      : true;

  Widget _wrapSizedAligned(Widget child, int index, {bool isHeader = false}) {
    final w = widget.columnWidths != null && index < widget.columnWidths!.length
        ? widget.columnWidths![index]
        : null;
    final minW =
        widget.columnMinWidths != null && index < widget.columnMinWidths!.length
        ? widget.columnMinWidths![index]
        : null;
    final align = isHeader ? _headerColAlign(index) : _colAlign(index);
    Widget aligned = Align(alignment: _toAlign(align), child: child);
    if (w != null) return SizedBox(width: w, child: aligned);
    if (minW != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: minW),
        child: aligned,
      );
    }
    return aligned;
  }

  Widget _buildHeaderItem(dynamic item) {
    TextStyle style =
        widget.headerTextStyle ??
        TextStyle(
          fontWeight: widget.headerFontWeight,
          fontSize: widget.headerFontSize ?? 14,
        );
    if (item is Widget) return item;
    return Text(item.toString(), style: style);
  }

  Widget _buildCellItem(dynamic item) {
    TextStyle style =
        widget.cellTextStyle ??
        TextStyle(
          fontWeight: widget.cellFontWeight,
          fontSize: widget.cellFontSize ?? 13,
        );
    if (item is Widget) return item;
    return Text(item.toString(), style: style, overflow: TextOverflow.ellipsis);
  }

  Widget _buildDynamicText(
    dynamic data, {
    required RzMaterialDataTableBasicAlign align,
    required double? fontSize,
    required FontWeight fontWeight,
    TextStyle? customStyle,
  }) {
    if (data == null) return const SizedBox();
    if (data is Widget) return Align(alignment: _toAlign(align), child: data);
    return Align(
      alignment: _toAlign(align),
      child: Text(
        data.toString(),
        style:
            customStyle ??
            TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    if (widget.columns != null) return widget.columns!;
    if (widget.headers != null) {
      return List.generate(widget.headers!.length, (i) {
        final sortable = _isSortable(i);
        return DataColumn(
          label: _wrapSizedAligned(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeaderItem(widget.headers![i]),
                if (sortable) const SizedBox(width: 4),
                if (sortable)
                  Icon(
                    sortCol == i
                        ? (asc ? Icons.arrow_upward : Icons.arrow_downward)
                        : Icons.unfold_more,
                    size: 14,
                    color: sortCol == i ? Colors.black87 : Colors.black38,
                  ),
              ],
            ),
            i,
            isHeader: true,
          ),
          onSort: sortable ? (idx, _) => _sort(idx) : null,
        );
      });
    }
    if (filtered.isNotEmpty && widget.rowBuilder != null) {
      final count = widget.rowBuilder!(filtered.first).length;
      return List.generate(count, (i) {
        final sortable = _isSortable(i);
        return DataColumn(
          label: _wrapSizedAligned(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Col ${i + 1}'),
                if (sortable) const SizedBox(width: 4),
                if (sortable)
                  Icon(
                    sortCol == i
                        ? (asc ? Icons.arrow_upward : Icons.arrow_downward)
                        : Icons.unfold_more,
                    size: 14,
                  ),
              ],
            ),
            i,
            isHeader: true,
          ),
          onSort: sortable ? (idx, _) => _sort(idx) : null,
        );
      });
    }
    return [];
  }

  List<Widget> _buildPageNumbers(int totalPages) {
    List<Widget> widgets = [];
    int current = page;

    Widget pageBtn(int index) {
      bool active = index == current;
      return InkWell(
        onTap: () => _goToPage(index),
        borderRadius: BorderRadius.circular(
          widget.paginationButtonBorderRadius,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.paginationButtonPaddingH,
            vertical: widget.paginationButtonPaddingV,
          ),
          decoration: BoxDecoration(
            color: active
                ? widget.paginationButtonActiveColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              widget.paginationButtonBorderRadius,
            ),
            border: Border.all(
              color: active
                  ? widget.paginationButtonActiveColor
                  : widget.paginationButtonBorderColor,
            ),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: widget.paginationButtonFontSize,
              fontWeight: active
                  ? FontWeight.bold
                  : widget.paginationButtonFontWeight,
              color: active
                  ? widget.paginationButtonActiveTextColor
                  : widget.paginationButtonTextColor,
            ),
          ),
        ),
      );
    }

    Widget dots() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '...',
        style: TextStyle(
          fontSize: widget.paginationButtonFontSize,
          color: widget.paginationButtonTextColor,
        ),
      ),
    );

    if (totalPages <= 7 ||
        widget.paginationMode ==
            RzMaterialDataTableBasicPaginationMode.compact) {
      for (int i = 0; i < totalPages; i++) {
        widgets.add(pageBtn(i));
      }
    } else {
      Set<int> added = {};
      List<Widget> result = [];

      for (int i = 0; i < 3 && i < totalPages; i++) {
        result.add(pageBtn(i));
        added.add(i);
      }

      if (current > 4) result.add(dots());

      if (widget.showMidRange && totalPages >= widget.midRangeThreshold) {
        if (current <= 4) {
          if (!added.contains(3)) {
            result.add(pageBtn(3));
            added.add(3);
          }
          if (!added.contains(4)) {
            result.add(pageBtn(4));
            added.add(4);
          }
        } else if (current >= totalPages - 5) {
          if (!added.contains(totalPages - 5)) {
            result.add(pageBtn(totalPages - 5));
            added.add(totalPages - 5);
          }
          if (!added.contains(totalPages - 4)) {
            result.add(pageBtn(totalPages - 4));
            added.add(totalPages - 4);
          }
        } else {
          if ((current - 1) > 2 &&
              (current - 1) < totalPages - 3 &&
              !added.contains(current - 1)) {
            result.add(pageBtn(current - 1));
            added.add(current - 1);
          }
          if (current > 2 &&
              current < totalPages - 3 &&
              !added.contains(current)) {
            result.add(pageBtn(current));
            added.add(current);
          }
          if ((current + 1) > 2 &&
              (current + 1) < totalPages - 3 &&
              !added.contains(current + 1)) {
            result.add(pageBtn(current + 1));
            added.add(current + 1);
          }
        }

        int mid = totalPages ~/ 2;
        if (mid > 2 && mid < totalPages - 3) {
          if (mid - 1 > 2 &&
              mid - 1 < totalPages - 3 &&
              !added.contains(mid - 1) &&
              (mid - 1) != current &&
              (mid - 1) != current - 1 &&
              (mid - 1) != current + 1) {
            result.add(pageBtn(mid - 1));
            added.add(mid - 1);
          }
          if (!added.contains(mid) &&
              mid != current &&
              mid != current - 1 &&
              mid != current + 1) {
            result.add(pageBtn(mid));
            added.add(mid);
          }
          if (mid + 1 > 2 &&
              mid + 1 < totalPages - 3 &&
              !added.contains(mid + 1) &&
              (mid + 1) != current &&
              (mid + 1) != current - 1 &&
              (mid + 1) != current + 1) {
            result.add(pageBtn(mid + 1));
            added.add(mid + 1);
          }
        }
      } else {
        if (current > 3 && current < totalPages - 4) {
          if (!added.contains(current - 1)) {
            result.add(pageBtn(current - 1));
            added.add(current - 1);
          }
          if (!added.contains(current)) {
            result.add(pageBtn(current));
            added.add(current);
          }
          if (!added.contains(current + 1)) {
            result.add(pageBtn(current + 1));
            added.add(current + 1);
          }
        } else if (current <= 3) {
          if (!added.contains(3)) {
            result.add(pageBtn(3));
            added.add(3);
          }
          if (!added.contains(4)) {
            result.add(pageBtn(4));
            added.add(4);
          }
        } else {
          if (!added.contains(totalPages - 5)) {
            result.add(pageBtn(totalPages - 5));
            added.add(totalPages - 5);
          }
          if (!added.contains(totalPages - 4)) {
            result.add(pageBtn(totalPages - 4));
            added.add(totalPages - 4);
          }
        }
      }

      if (current < totalPages - 5) result.add(dots());

      for (int i = totalPages - 3; i < totalPages; i++) {
        if (i >= 0 && i < totalPages && !added.contains(i)) {
          result.add(pageBtn(i));
          added.add(i);
        }
      }

      widgets = result;
    }

    return widgets;
  }

  Widget _navButton(String label, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(widget.paginationButtonBorderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.paginationButtonPaddingH + 2,
          vertical: widget.paginationButtonPaddingV,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            widget.paginationButtonBorderRadius,
          ),
          border: Border.all(color: widget.paginationButtonBorderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: widget.paginationButtonFontSize,
            fontWeight: widget.paginationButtonFontWeight,
            color: onTap == null
                ? Colors.grey
                : widget.paginationButtonTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    if (totalPages <= 1) return const SizedBox();
    if (widget.paginationMode ==
        RzMaterialDataTableBasicPaginationMode.minimal) {
      return Row(
        mainAxisAlignment: _toMainAlign(widget.paginationAlign),
        children: [
          if (widget.showPrevNext)
            _navButton(
              widget.paginationPrevText,
              page > 0
                  ? () {
                      setState(() {
                        page--;
                        _paginate();
                      });
                    }
                  : null,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${page + 1} / $totalPages',
              style: TextStyle(
                fontSize: widget.paginationButtonFontSize,
                fontWeight: widget.paginationButtonFontWeight,
              ),
            ),
          ),
          if (widget.showPrevNext)
            _navButton(
              widget.paginationNextText,
              page < totalPages - 1
                  ? () {
                      setState(() {
                        page++;
                        _paginate();
                      });
                    }
                  : null,
            ),
        ],
      );
    }
    List<Widget> controls = [];
    if (widget.showFirstButton) {
      controls.add(
        _navButton(
          widget.paginationFirstText,
          page > 0 ? () => _goToPage(0) : null,
        ),
      );
    }
    if (widget.showPrevNext) {
      controls.add(
        _navButton(
          widget.paginationPrevText,
          page > 0
              ? () {
                  setState(() {
                    page--;
                    _paginate();
                  });
                }
              : null,
        ),
      );
    }
    if (widget.showPageNumbers) controls.addAll(_buildPageNumbers(totalPages));
    if (widget.showPrevNext) {
      controls.add(
        _navButton(
          widget.paginationNextText,
          page < totalPages - 1
              ? () {
                  setState(() {
                    page++;
                    _paginate();
                  });
                }
              : null,
        ),
      );
    }
    if (widget.showLastButton) {
      controls.add(
        _navButton(
          widget.paginationLastText,
          page < totalPages - 1 ? () => _goToPage(totalPages - 1) : null,
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: _toMainAlign(widget.paginationAlign),
        children: controls
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = _currentRowsPerPage == 0
        ? 1
        : (filtered.length / _currentRowsPerPage).ceil();
    final columns = _buildColumns();

    Widget table = DataTable(
      headingRowColor: WidgetStatePropertyAll(widget.headerColor),
      headingRowHeight: widget.showHeader ? 56 : 0,
      sortColumnIndex: sortCol == -1 ? null : sortCol,
      sortAscending: asc,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: widget.borderColor.withValues(alpha: 0.5),
        ),
      ),
      columns: columns,
      rows: displayed.asMap().entries.map((entry) {
        final rowIndex = entry.key;
        final globalIndex = page * _currentRowsPerPage + rowIndex;
        final item = entry.value;
        final isOdd = globalIndex % 2 == 1;
        final rowData = widget.rowBuilder != null
            ? widget.rowBuilder!(item)
            : [];
        List<DataCell> cells = List.generate(rowData.length, (colIndex) {
          final isEditing = editingRow == rowIndex && editingCol == colIndex;
          final currentValue = rowData[colIndex];
          final canEdit = widget.enableDoubleClickEdit && _isEditable(colIndex);
          Widget cellContent;
          if (isEditing) {
            if (widget.cellEditorBuilder != null) {
              cellContent = widget.cellEditorBuilder!(
                item,
                colIndex,
                currentValue,
                (newVal) {
                  setState(() {
                    editingRow = null;
                    editingCol = null;
                  });
                  widget.onCellChanged?.call(item, colIndex, newVal);
                },
                () {
                  setState(() {
                    editingRow = null;
                    editingCol = null;
                  });
                },
              );
            } else {
              cellContent = SizedBox(
                width:
                    widget.columnWidths != null &&
                        colIndex < widget.columnWidths!.length
                    ? widget.columnWidths![colIndex]
                    : 150,
                child: TextField(
                  controller: _editController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (v) {
                    setState(() {
                      editingRow = null;
                      editingCol = null;
                    });
                    widget.onCellChanged?.call(item, colIndex, v);
                  },
                ),
              );
            }
          } else {
            cellContent = _buildCellItem(currentValue);
            if (canEdit) {
              cellContent = GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    editingRow = rowIndex;
                    editingCol = colIndex;
                    _editController.text = currentValue is String
                        ? currentValue
                        : currentValue is Widget
                        ? ''
                        : currentValue.toString();
                  });
                },
                child: cellContent,
              );
            }
          }
          return DataCell(
            _wrapSizedAligned(cellContent, colIndex),
            onTap: widget.onRowTap != null
                ? () => widget.onRowTap!(item)
                : null,
          );
        });
        return DataRow(
          color: widget.enableOddEven
              ? WidgetStatePropertyAll(
                  isOdd ? widget.evenRowColor : widget.oddRowColor,
                )
              : null,
          cells: cells,
        );
      }).toList(),
    );

    Widget content = columns.isEmpty
        ? (widget.emptyWidget ??
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text('No data'),
              ))
        : LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: double.infinity,
                child: Scrollbar(
                  controller: _hScroll,
                  thumbVisibility: widget.showHorizontalScrollbar,
                  child: SingleChildScrollView(
                    controller: _hScroll,
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: table,
                    ),
                  ),
                ),
              );
            },
          );

    Widget verticalWrapper = widget.maxHeight != null
        ? SizedBox(
            height: widget.maxHeight,
            width: double.infinity,
            child: Scrollbar(
              controller: _vScroll,
              thumbVisibility: widget.showScrollbar,
              child: SingleChildScrollView(
                controller: _vScroll,
                child: content,
              ),
            ),
          )
        : content;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.tableHeader != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildDynamicText(
                widget.tableHeader,
                align: widget.tableHeaderAlign,
                fontSize: widget.tableHeaderFontSize,
                fontWeight: widget.tableHeaderFontWeight,
                customStyle: widget.tableHeaderTextStyle,
              ),
            ),
          if (widget.showSearch)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                onChanged: _filter,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                ),
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: widget.borderColor),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: Colors.white,
              ),
              child: Material(color: Colors.white, child: verticalWrapper),
            ),
          ),
          if (widget.tableFooter != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _buildDynamicText(
                widget.tableFooter,
                align: widget.tableFooterAlign,
                fontSize: widget.tableFooterFontSize,
                fontWeight: widget.tableFooterFontWeight,
                customStyle: widget.tableFooterTextStyle,
              ),
            ),
          if (widget.footer != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: widget.footer!,
            ),
          if (widget.showPagination && widget.footer == null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.paginationMode !=
                      RzMaterialDataTableBasicPaginationMode.minimal)
                    Row(
                      children: [
                        const Text('Rows per page:'),
                        const SizedBox(width: 8),
                        DropdownButton<int>(
                          value:
                              widget.rowsPerPageOptions.contains(
                                _currentRowsPerPage,
                              )
                              ? _currentRowsPerPage
                              : widget.rowsPerPageOptions.first,
                          items: widget.rowsPerPageOptions
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text('$e'),
                                ),
                              )
                              .toList(),
                          onChanged: _changeRowsPerPage,
                          isDense: true,
                          underline: const SizedBox(),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${filtered.isEmpty ? 0 : page * _currentRowsPerPage + 1}-${(page * _currentRowsPerPage + displayed.length).clamp(0, filtered.length)} of ${filtered.length}',
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: _toAlign(widget.paginationAlign),
                    child: _buildPagination(totalPages),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/*
Usages:
RzMaterialDataTableBasic<UserModel>(
    // 1. DATA MODEL
    items: users,
    searchableBuilder: (u) => '${u.name} ${u.email} ${u.role}',
    onRowTap: (u) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clicked ${u.name}'))),

    // 2. HEADER - String or Widget (checkbox, textfield etc)
    headers: [
        StatefulBuilder(builder: (c, set) => Checkbox(value: selectAll, onChanged: (v) { setState(() { selectAll = v!; for (var u in users) u.selected = selectAll; }); })),
        'Name',
        'Email',
        'Role',
        'Action',
    ],
    headerAlign: RzMaterialDataTableAlign.center,
    headerFontSize: 14,
    headerFontWeight: FontWeight.w700,
    headerColor: const Color(0xFFF1F3F9),

    // 3. COLUMN SIZE
    columnWidths: [60, 140, 240, 110, 120],
    columnMinWidths: [50, 100, 150, 80, 80],
    columnAligns: [
        RzMaterialDataTableAlign.center, // checkbox
        RzMaterialDataTableAlign.left, // name
        RzMaterialDataTableAlign.left, // email
        RzMaterialDataTableAlign.center, // role
        RzMaterialDataTableAlign.center, // action
    ],
    align: RzMaterialDataTableAlign.center, // default center
    cellFontSize: 13,
    cellFontWeight: FontWeight.w400,

    // 4. ROW - text or widget
    rowBuilder: (u) => [
        Checkbox(value: u.selected, onChanged: (v) => setState(() => u.selected = v!)),
        u.name,
        u.email,
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: u.role == 'Admin'? Colors.blue.shade100 : Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
            child: Text(u.role, style: const TextStyle(fontSize: 12)),
        ),
        Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () => setState(() => users.remove(u))),
        ]),
    ],

    // 5. TABLE HEADER / FOOTER - String or Widget + size + weight + align
    tableHeader: 'User Management Table',
    tableHeaderAlign: RzMaterialDataTableAlign.left,
    tableHeaderFontSize: 22,
    tableHeaderFontWeight: FontWeight.w800,
    // tableHeader: Row(children: [Icon(Icons.people), SizedBox(width:8), Text('Users')]), // widget also

    tableFooter: 'Total ${users.length} users found',
    tableFooterAlign: RzMaterialDataTableAlign.right,
    tableFooterFontSize: 13,
    tableFooterFontWeight: FontWeight.w500,

    // 6. ODD EVEN + HEADER NULL + FOOTER NULL
    showHeader: true,
    enableOddEven: true,
    oddRowColor: Colors.white,
    evenRowColor: const Color(0xFFF9FAFB),

    // 7. SCROLLBAR ON/OFF - if off show full content
    showScrollbar: true,
    showHorizontalScrollbar: true,
    maxHeight: 420,
    borderRadius: 12,
    borderColor: const Color(0xFFE0E0E0),

    // 8. SEARCH + SORT
    showSearch: true,
    enableSorting: true,
    sortableColumns: [false, true, true, true, false], // checkbox & action not sortable
    sortValueBuilder: (u, col) => [u.selected.toString(), u.name, u.email, u.role, ''][col],

    // 9. DOUBLE CLICK EDITABLE
    enableDoubleClickEdit: true,
    editableColumns: [false, true, true, true, false],
    onCellChanged: (item, colIndex, newValue) {
        setState(() {
            if (colIndex == 1) item.name = newValue;
            if (colIndex == 2) item.email = newValue;
            if (colIndex == 3) item.role = newValue;
        });
    },
    cellEditorBuilder: (item, colIndex, currentValue, onSave, onCancel) {
        if (colIndex == 3) {
            return DropdownButton<String>(
                value: ['Admin', 'User', 'Guest'].contains(currentValue.toString())? currentValue.toString() : 'User',
                items: ['Admin', 'User', 'Guest'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) { if (v!= null) onSave(v); },
            );
        }
        return SizedBox(
            width: 180,
            child: TextField(
                autofocus: true,
                controller: TextEditingController(text: currentValue is String? currentValue : ''),
                decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
                onSubmitted: onSave,
            ),
        );
    },

    // 10. PAGINATION - Full Feature + Customizable
    showPagination: true,
    rowsPerPage: 10,
    rowsPerPageOptions: [5, 10, 25, 50, 100],

    // pagination align - uses RzMaterialDataTableBasicAlign
    paginationMode: RzMaterialDataTableBasicPaginationMode.full, // full, minimal, compact
    paginationAlign: RzMaterialDataTableBasicAlign.center, // left, center, right
    showFirstButton: true,
    showLastButton: true,
    showPrevNext: true,
    showPageNumbers: true,
    showMidRange: true,
    midRangeThreshold: 30, // 30, 40 etc - if totalPages >=30 show mid logic (page/2-1, page/2, page/2+1)

    // pagination button style
    paginationFirstText: 'First',
    paginationPrevText: 'Previous',
    paginationNextText: 'Next',
    paginationLastText: 'Last',

    paginationButtonFontSize: 13,
    paginationButtonFontWeight: FontWeight.w600,
    paginationButtonTextColor: Colors.black87,
    paginationButtonActiveColor: Colors.blue,
    paginationButtonActiveTextColor: Colors.white,
    paginationButtonBorderColor: Colors.grey.shade300,
    paginationButtonBorderRadius: 8,
    paginationButtonPaddingH: 12,
    paginationButtonPaddingV: 7,
),
*/
