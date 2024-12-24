// // import 'package:expenses/datetime/dete_time_helper.dart';
// import 'package:expenses/datetime/date_time_helper.dart';
// import 'package:expenses/models/expense_items.dart';
// import 'package:get/get.dart';

// class ExpenseData extends GetxController {
//   // list of All expenses
//   List<ExpenseItem> overallExpenseList = [];

//   // get expense list
//   List<ExpenseItem> getAllExpenseList() {
//     return overallExpenseList;
//   }

//   // add new expense
//   void addNewExpense(ExpenseItem newExpense) {
//     overallExpenseList.add(newExpense);
//   }

//   // delete expese
//   void deleteExpense(ExpenseItem expense) {
//     overallExpenseList.remove(expense);
//   }

//   // get weekely (mon, tue,wed) from a datetime object
//   String getDayName(DateTime dateTime) {
//     switch (dateTime.weekday) {
//       case 1:
//         return 'Mon';
//       case 2:
//         return 'Tue';
//       case 3:
//         return 'Wed';
//       case 4:
//         return 'Thur';
//       case 5:
//         return 'Fri';
//       case 6:
//         return 'Sat';
//       case 7:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }
//   // get the start of the week (sunday)

//   DateTime startOfWeekDate() {
//     DateTime? startOfWeek;

//     // get todays date
//     DateTime today = DateTime.now();

//     // go backwards from today to find sunday
//     for (int i = 0; i < 7; i++) {
//       if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
//         startOfWeek = today.subtract(Duration(days: i));
//       }
//     }
//     return startOfWeek!;
//   }

//   /*
//   convert overall list of expenses into a dailyy expense summery


//   overall expenseslist=>
//   [

//   [food,2024/02/30],
//   [food,2024/02/30],
//   [food,2024/02/30],
//   [food,2024/02/30],
//   [food,2024/02/30],
//   [food,2024/02/30],

  
  
//   ]
//   daily expensessummery=>
//   [2024/02/30],
//   [2024/02/30],
//   [2024/02/30],
//   [2024/02/30],
//   [2024/02/30],


  

//     */
//   Map<String, double> calculateDailyExpenseSummary() {
//     Map<String, double> dailyExpenseSummary = {
//       // date(yymmdd): amount total for day
//     };
//     for (var expense in overallExpenseList) {
//       // String date = convertDateTimeToString(expense.dateTime as DateTime);
//       double amount = double.parse(expense.amount);

//       if (dailyExpenseSummary.containsKey(date)) {
//         double currentAmount = dailyExpenseSummary[date]!;
//         currentAmount += amount;
//         dailyExpenseSummary[date] = currentAmount;
//       } else {
//         dailyExpenseSummary.addAll({date: amount});
//       }
//     }
//     return dailyExpenseSummary;
//   }
// }
