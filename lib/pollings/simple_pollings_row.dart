import 'package:flutter/material.dart';
import 'package:quiki/pollings/models/simple_pollings_row_data.dart';

class SimplePollingsRow extends StatefulWidget {
  final SimplePollingsRowData data;
  final bool isSelected;

  const SimplePollingsRow({
    Key key,
    this.data,
    this.isSelected,
  }) : super(key: key);

  @override
  _SimplePollingsRowState createState() => _SimplePollingsRowState();
}

class _SimplePollingsRowState extends State<SimplePollingsRow> {
  AnimationController _animationController;
  Animation<double> _animation;

  bool hasDrawnOnce = false;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1),
    // );
    // _animation = Tween(begin: 0.0, end: widget.data.pollingPercentage)
    //     .animate(_animationController);
    // _animation.addListener(() {
    //   setState(() {});
    // });
    // _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    hasDrawnOnce = true;
    return Row(
      children: <Widget>[
        Container(
          width: 30,
          child: Text(
            "${(widget.data.pollingPercentage / 1 * 100).toStringAsFixed(0)} %",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.widget.data.title),
              LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(widget.isSelected
                      ? Colors.deepOrange
                      : Colors.deepPurple),
                  value: (widget.data.pollingPercentage.isNaN ||
                          widget.data.pollingPercentage.isInfinite)
                      ? 0
                      : widget.data.pollingPercentage),
              widget.isSelected
                  ? Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "You",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 10),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: widget.isSelected ? 0 : 15,
              ),
            ],
          ),
        )
      ],
    );
  }
}
