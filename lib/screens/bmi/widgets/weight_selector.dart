import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WeightSelector extends StatefulWidget {
  @override
  _WeightSelectorState createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  final tempWeights = [50, 60, 70, 80];

  int _currentWeightIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey[100],
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildPointer(isTop: true),
              CarouselSlider(
                items: tempWeights.map(
                  (weight) {
                    final weightIndex = tempWeights.indexOf(weight);
                    final isSelectedWeight = weightIndex == _currentWeightIndex;
                    final textTheme = Theme.of(context).textTheme;
                    final textStyle = isSelectedWeight
                        ? textTheme.headline5
                        : textTheme.bodyText1;

                    return Builder(
                      builder: (context) => Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 150),
                          style: textStyle,
                          child: Text(
                            '$weight',
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 0.33,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentWeightIndex = index;
                    });
                  },
                ),
              ),
              _buildPointer(isTop: false)
            ],
          ),
        ],
      ),
    );
  }

  Positioned _buildPointer({@required bool isTop}) => Positioned(
        top: isTop ? 0 : null,
        bottom: isTop ? null : 0,
        right: 0,
        left: 0,
        child: Icon(
          isTop ? Icons.arrow_drop_down : Icons.arrow_drop_up,
          size: 30,
          color: const Color(0xFFFF69B4),
        ),
      );
}
