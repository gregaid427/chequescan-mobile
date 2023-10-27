import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../constants/api_client.dart';
import '../../components/home_card.dart';

bool? load = false;

class CardScrollView extends StatefulWidget {
  CardScrollView({
    Key? key,
  }) : super(key: key);

  List? cardItems;

  @override
  State<CardScrollView> createState() => _CardScrollViewState();
}

List? result;

class _CardScrollViewState extends State<CardScrollView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardScollViewModel>.reactive(
        onViewModelReady: (model) => model.ReadySetup(),
        builder: (context, model, child) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  model.data?.length == null ? 0 : model.data!.length,
                  (index) => model.data?.isEmpty != true
                      ? HomeCard(
                          accountType: model.data?.length == null
                              ? ''
                              : model.data?[index]["accountType"].toString(),
                          accountNumber: model.data?.length == null
                              ? ''
                              : model.data?[index]["accountNumber"].toString(),
                          scanneedNumber: model.data?.length == null
                              ? ''
                              : model.data?[index]["total_no_scan"].toString(),
                          TotalscanneedAmount: model.data?.length == null
                              ? ''
                              : model.data?[index]["total_no_scan"].toString())
                      : HomeCardEmpty(),
                ),
              ),
            ),
        viewModelBuilder: () => CardScollViewModel());
  }
}

class CardScollViewModel extends ChangeNotifier {
  List? data;

  void ReadySetup() async {
    apicall();
  }

  void apicall() async {
    ApiClient apiClient = ApiClient();
    data = await apiClient.getUserLinkedaccount() as List?;
    notifyListeners();
    print(data);

    load = true;
    notifyListeners();
  }
}

class HomeCardEmpty extends StatelessWidget {
  const HomeCardEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 140,
        width: 320,
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.orange),
        child: Center(
            child: load == true
                ? CircularProgressIndicator()
                : Text(
                    'No linked accounts',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )),
      ),
    );
  }
}
