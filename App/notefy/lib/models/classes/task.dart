class Task{
  String title;
  List<Task> tasks;
  String notes;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  String taskID;
  Task(this.title,this.completed,this.taskID);
}