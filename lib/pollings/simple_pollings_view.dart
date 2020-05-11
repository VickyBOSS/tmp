import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:quiki/pollings/models/simple_poll_data.dart';
import 'package:quiki/pollings/models/simple_pollings_row_data.dart';
import 'package:quiki/pollings/polls_repos.dart';
import 'package:quiki/pollings/simple_pollings_row.dart';

import 'dart:developer' as logger;

class SimplePollingsView extends StatefulWidget {
  final SimplePollData pollData;

  SimplePollingsView({
    Key key,
    this.pollData,
  }) : super(key: key);

  @override
  _SimplePollingsViewState createState() => _SimplePollingsViewState();
}

class _SimplePollingsViewState extends State<SimplePollingsView> {
  final pollsBox = Hive.box("polls");

  final letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
  var selectedRadioVal;
  var totalPolls;
  var date;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(
        DateTime(2030).millisecondsSinceEpoch -
            int.parse(widget.pollData.pollId));
    date = DateFormat('d MMMM   hh:mm').format(dateTime);

    totalPolls = widget.pollData.pollings.values.length == 0
        ? 0
        : widget.pollData.pollings.values.reduce((a, b) => a + b);
    logger.log("Total Polls : $totalPolls");
    // pollsBox.delete(widget.pollData.pollId);
    return Card(
      margin: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.pollData.question,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ValueListenableBuilder(
              valueListenable:
                  pollsBox.listenable(keys: [this.widget.pollData.pollId]),
              builder: (_, Box box, child) => Column(
                children: box.get(widget.pollData.pollId) == null
                    ? buildRadioTiles()
                    : buildPollResultTiles(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(width: 30),
                Icon(
                  Icons.remove_red_eye,
                  size: 15,
                ),
                SizedBox(width: 10),
                Text(
                  totalPolls.toString(),
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  buildRadioTiles() {
    int index = 0;
    return widget.pollData.options.map((option) {
      index++; // index = 1
      return RadioListTile<int>(
          title: Text(option),
          value: index, // 0
          groupValue: selectedRadioVal,
          onChanged: (val) {
            setState(() {
              selectedRadioVal = val;
            });
            pollsBox.put(widget.pollData.pollId, option);
            PollsRepos.instance.upvoteSimplePoll(widget.pollData.pollId, val);
          });
    }).toList();
  }

  buildPollResultTiles() {
    var index = 0;
    return widget.pollData.options.map((option) {
      index++;
      var isSelected = false;
      if (option == pollsBox.get(widget.pollData.pollId)) {
        isSelected = true;
      }
      return SimplePollingsRow(
        isSelected: isSelected,
        data: SimplePollingsRowData(
            title: option,
            optionIndicatorText: letters[index - 1],
            pollingPercentage:
                ((widget.pollData.pollings['o$index'] ?? 0) / totalPolls)
                    .toDouble()),
      );
    }).toList();
  }
}
