import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvm/data/response/status.dart';
import 'package:provider_mvm/res/components/custom_color.dart';
import 'package:provider_mvm/utils/routes/route_name.dart';
import 'package:provider_mvm/viewmodel/home_view_model.dart';
import 'package:provider_mvm/viewmodel/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Using addPostFrameCallback to ensure the build phase is complete before making API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeViewViewModel homeViewViewModel =
          Provider.of<HomeViewViewModel>(context, listen: false);
      homeViewViewModel.fetchProductsApiList();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    HomeViewViewModel homeViewViewModel =
        Provider.of<HomeViewViewModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          actions: [
            InkWell(
                onTap: () {
                  userViewModel.remove().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  }).onError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error.toString());
                    } else {}
                  });
                },
                child: Center(child: Text("Logout"))),
          ],
        ),
        body: Consumer<HomeViewViewModel>(builder: (context, value, child) {
          switch (value.productList.status) {
            case Status.Loading:
              return Center(child: CircularProgressIndicator());

            case Status.Error:
              print(value.productList.message.toString());
              break;
            case Status.Completed:
              return ListView.builder(
                  itemCount: value.productList.data!.data!.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(value
                                .productList.data!.data![index].shop!.image
                                .toString()),
                          ),
                          trailing: Text(value
                              .productList.data!.data![index].shop!.shopemail
                              .toString()),
                          title: Text(value
                              .productList.data!.data![index].shop!.shopcity
                              .toString()),
                        ),
                        Container(
                          height: 300,
                          width: 500,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.productList.data!.data![index]
                                  .images!.length,
                              itemBuilder: ((context, position) {
                                return Container(
                                  height: 250,
                                  width: 500,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(value
                                              .productList
                                              .data!
                                              .data![index]
                                              .images![position]
                                              .url
                                              .toString()))),
                                );
                              })),
                        )
                      ],
                    );
                  }));
            default:
              print("NO case match");
          }
          return Container();
        }));
  }
}
