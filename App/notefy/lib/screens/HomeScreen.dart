import 'package:flutter/material.dart';
import 'package:notefy/constants.dart';
import 'package:notefy/models/classes/task.dart';

List<Task> taskList = [];
List<Task> getList(){
  for(int i=0;i<5;i++){
    taskList.add(Task('Make A app', true, (i).toString(),));
  }
  return taskList;
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
int i=0;
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if(i==0) {
      getList();
      i++;
    }
    Size size =MediaQuery.of(context).size;
    return Container(
      color: kdarkGrey,
      child: Stack(
        children: [
          Positioned(
            top: size.height*0.2-40,
            left: size.width*0.005,
            child: Container(
              height: 0.8*size.height,
              width: size.width*0.99,
              child: Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent,
                ),
                child: ReorderableListView(
                  padding: EdgeInsets.only(top: 170),
                  children: taskList.map((Task items) => _buildListTile(context, items)).toList(),
                  onReorder: ( oldIndex, newIndex){
                    setState((){
                      if(newIndex>oldIndex){
                        newIndex-=1;
                      }
                      final Task item= taskList.removeAt(oldIndex);
                      taskList.insert(newIndex, item);
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: size.height/5,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(left: size.width/15,top: size.height/15),
                child: Text(
                  'Notefy',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow:[BoxShadow(color: Colors.black54,offset: Offset(0.0,1),spreadRadius: 1.0,blurRadius: 4.0)],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40),),
              ),
            ),
          ),
          Positioned(
            top: (size.height/5)-40,
            left: (size.width/2)-40,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: kOrange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 1.0,
                      blurRadius: 4.0),
                ],
              ),
              child: Icon(Icons.add,size: 50,),
            ),
          ),

        ],
      ),
    );
  }
}


Widget _buildListTile(BuildContext context, Task item){
  return ListTile(
    key: Key(item.taskID),
    title: TaskCard(title: item.title,subtitle: 'The general one '+ item.taskID, ),
  );
}


class TaskCard extends StatelessWidget {
  TaskCard({@required this.title, this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Radio(
          ),
          Column(
            children: [
              Text(title,style: TextStyle(fontSize: 30),),
              Text(subtitle,style: TextStyle(fontSize: 15),),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: kOrange,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              spreadRadius: 1.0,
              blurRadius: 4.0),
        ],
      ),
    );
  }
}
