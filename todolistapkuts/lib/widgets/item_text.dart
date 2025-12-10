import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Show task title, due date, and due time.
/// Includes strike-through if `check = true`.
class ItemText extends StatelessWidget {
  final bool check;
  final String text;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  // Constructor yang benar
  const ItemText({
    Key? key,
    required this.check,
    required this.text,
    this.dueDate,
    this.dueTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMainText(),
        const SizedBox(height: 4),
        _buildDateTimeTexts(context),
      ],
    );
  }

  Widget _buildMainText() {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 22,
        color: check ? Colors.grey : Colors.black,
        decoration: check ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  Widget _buildDateText(BuildContext context) {
    if (dueDate == null) return const SizedBox.shrink();

    return Text(
      DateFormat.yMMMd().format(dueDate!),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: check ? Colors.grey : Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _buildTimeText(BuildContext context) {
    if (dueTime == null) return const SizedBox.shrink();

    return Text(
      dueTime!.format(context),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: check ? Colors.grey : Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _buildDateTimeTexts(BuildContext context) {
    if (dueDate == null && dueTime == null) return const SizedBox.shrink();

    if (dueDate != null && dueTime == null) return _buildDateText(context);
    if (dueDate == null && dueTime != null) return _buildTimeText(context);

    return Row(
      children: [
        _buildDateText(context),
        const SizedBox(width: 10),
        _buildTimeText(context),
      ],
    );
  }
}
