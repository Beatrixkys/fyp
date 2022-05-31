import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/services/database.dart';

//https://firebase.flutter.dev/docs/firestore/usage

/*FirebaseFirestore.instance
    .collection('users')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["first_name"]);
        });
    });

    */

class LogicService {
  final String uid;

  LogicService(this.uid);

  final CollectionReference<Map<String, dynamic>> accountsCollection =
      FirebaseFirestore.instance.collection("accounts");

  final CollectionReference<Map<String, dynamic>> recordsCollection =
      FirebaseFirestore.instance.collection("records");

  Future<int> totalAsset() async {
    var total = 0;
    await accountsCollection
        .doc(uid)
        .collection("accountdetails")
        .get()
        .then((QuerySnapshot query) {
      for (var doc in query.docs) {
        total = (total + doc["amount"]).toInt();
      }
    });

    return total;
  }

  Future<int> totalIncome() async {
    var total = 0;
    await FirebaseFirestore.instance
        .collection("records")
        .doc(uid)
        .collection("recordsdetails")
        .where("type", isEqualTo: "Income")
        .get()
        .then((QuerySnapshot query) {
      for (var doc in query.docs) {
        total = (total + doc["amount"]).toInt();
      }
    });

    return total;
  }

  Future<int> totalExpense() async {
    var total = 0;
    await FirebaseFirestore.instance
        .collection("records")
        .doc(uid)
        .collection("recordsdetails")
        .where("type", isEqualTo: "Expense")
        .get()
        .then((QuerySnapshot query) {
      for (var doc in query.docs) {
        total = (total + doc["amount"]).toInt();
      }
    });

    return total;
  }

  Future<int> totalProgress() async {
    var total = 0;
    await FirebaseFirestore.instance
        .collection("goals")
        .doc(uid)
        .collection("goalsdetails")
        .get()
        .then((QuerySnapshot query) {
      for (var doc in query.docs) {
        total = (((total + doc["amount"]) / query.docs.length) * 100).toInt();
      }
      DatabaseService(uid).updateTotalProgress(total);
    });

    return total;
  }

  Future<void> updateGoalProgress() async {
    var progress = 0;
    var totalIncome;
    var totalExpense;

    totalIncome = totalIncome();
    totalExpense = totalExpense();

    await FirebaseFirestore.instance
        .collection("goals")
        .doc(uid)
        .collection("goalsdetails")
        .get()
        .then((QuerySnapshot query) {
      for (var doc in query.docs) {
        if (doc["type"].isEqualto("Income") && doc["title"].isEqualto("Save")) {
          var target = totalIncome * (doc["amount"] / 100);
          var reality = totalIncome - totalExpense;
          progress = ((target - reality) / target) * 100;
          DatabaseService(uid).updateGoalProgress(progress, doc.id);
        } else if (doc["type"].isEqualto("Expense") &&
            doc["title"].isEqualto("Reduce")) {
          var target = totalExpense * (doc["amount"] / 100);
          //update this after redesigning structure
          var reality = totalExpense - (doc["prevAmount"]);
          progress = ((target - reality) / target) * 100;
          DatabaseService(uid).updateGoalProgress(progress, doc.id);
        }
      }
    });
  }
}

//Total goals progress
// int goalsTotal;
// call the progress to add to goal total / docs.length *100
//return goalsTotal
