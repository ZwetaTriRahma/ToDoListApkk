import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Shows a task item text, including date and time.
// Null-safety and Flutter 3 compatible.

class ItemText extends StatelessWidget {
  final bool check;
  final String text;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  const ItemText(
    this.check,
    this.text,
    this.dueDate,
    this.dueTime, {
    Key? key,
  }) : super(key: key);

  Widget _buildText(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 22,
      color: check ? Colors.grey : Colors.black,
      decoration: check ? TextDecoration.lineThrough : null,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: textStyle,
        ),
        const SizedBox(height: 4),
        _buildDateTimeTexts(context),
      ],
    );
  }

  Widget _buildDateText(BuildContext context) {
    if (dueDate == null) return Container();

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
    if (dueTime == null) return Container();

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
    // No date and no time
    if (dueDate == null && dueTime == null) {
      return Container();
    }

    // Only date
    if (dueTime == null) {
      return _buildDateText(context);
    }

    // Date + time
    return Row(
      children: [
        _buildDateText(context),
        const SizedBox(width: 10),
        _buildTimeText(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildText(context);
  }
}
