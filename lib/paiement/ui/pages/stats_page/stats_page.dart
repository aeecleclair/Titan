class StatsPage extends StatelessWidget {
const StatsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
        PieChart(
  PieChartData(
      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
        setState(() {
          if (pieTouchResponse.touchInput is FlLongPressEnd ||
              pieTouchResponse.touchInput is FlPanEnd) {
            touchedIndex = -1;
          } else {
            touchedIndex = pieTouchResponse.touchedSectionIndex;
          }
        });
      }),
      borderData: FlBorderData(
        show: false,
      ),
      sectionsSpace: 0,
      centerSpaceRadius: 60,
      sections: showingSections()),
),
  }
}