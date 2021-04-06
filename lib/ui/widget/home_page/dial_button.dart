import 'dart:async';

import 'package:flutter/material.dart';

class DialButton extends StatefulWidget {
  final Key key;
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final ValueSetter<String> onTap;
  final bool shouldAnimate;
  final BoxConstraints constraints;

  DialButton({
    this.key,
    this.title,
    this.subtitle,
    this.color,
    this.textColor,
    this.icon,
    this.iconColor,
    this.shouldAnimate,
    this.onTap,
    this.constraints,
  });

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _colorTween = ColorTween(
      begin: widget.color != null ? widget.color : Colors.white24,
      end: widget.textColor,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    if (widget.shouldAnimate == null || widget.shouldAnimate) {
      _animationController.dispose();
      if (_timer != null) _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeFactor = widget.constraints.maxHeight * 0.2;

    return GestureDetector(
      onTap: () {
        if (this.widget.onTap != null) this.widget.onTap(widget.title);

        if (widget.shouldAnimate == null || widget.shouldAnimate) {
          if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          } else {
            _animationController.forward();
            _timer = Timer(const Duration(milliseconds: 200), () {
              setState(() {
                _animationController.reverse();
              });
            });
          }
        }
      },
      child: ClipOval(
        child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) => Container(
            color: _colorTween.value,
            height: sizeFactor,
            width: sizeFactor,
            child: Center(
              child: widget.icon == null
                  ? widget.subtitle != null
                      ? Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                              ),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: widget.constraints.maxHeight * 0.08,
                                  color: widget.textColor != null
                                      ? widget.textColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              widget.subtitle,
                              style: TextStyle(
                                color: widget.textColor != null
                                    ? widget.textColor
                                    : Colors.white,
                              ),
                            )
                          ],
                        )
                      : Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: widget.constraints.maxHeight * 0.08,
                            color: widget.textColor != null
                                ? widget.textColor
                                : Colors.white,
                          ),
                        )
                  : Icon(
                      widget.icon,
                      size: widget.constraints.maxHeight * 0.08,
                      color: widget.iconColor != null
                          ? widget.iconColor
                          : Colors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
