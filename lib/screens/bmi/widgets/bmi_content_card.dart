import 'package:flutter/material.dart';

class BmiContentCard extends StatelessWidget {
  const BmiContentCard({
    @required this.title,
    @required this.child,
    this.unit,
  });

  final String title;
  final String unit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    title.toUpperCase(),
                    style: textTheme.subtitle2,
                  ),
                  if (unit != null)
                    Text(
                      '[$unit]',
                      style: textTheme.caption,
                    ),
                ],
              ),
              Expanded(
                child: Center(
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
