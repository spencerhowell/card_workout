import 'package:cardworkout/main.dart';
import 'package:cardworkout/workout_set.dart';
import 'package:flutter/material.dart';
import 'strings.dart';

class SummaryPage extends StatelessWidget {
  SummaryPage({Key key, this.sets}) : super(key: key);
  final List<WorkoutSet> sets;

  Widget _buildRow(int index) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
            title: Text("${sets[index].exercise}"),
            trailing: Text("${sets[index].card.getAbbreviatedString()}"),
            subtitle: Text(
              "${sets[index].goalReps.toString()} " + "${Strings.exerciseReps}",
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Strings.workoutSummary)),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int index) {
                  return _buildRow(index);
                },
                itemCount: sets.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: MaterialButton(
                  minWidth: double.maxFinite,
                  padding: EdgeInsets.all(16.0),
                  color: Theme.of(context).primaryColor,
                  child: Text(Strings.doneButton,
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  }),
            ),
          ],
        ));
  }
}
