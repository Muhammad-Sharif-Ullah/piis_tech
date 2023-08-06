import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/core/widgets/list_loader.dart';
import 'package:piis_tech/core/widgets/on_network_image.dart';
import 'package:piis_tech/features/home/presentation/cubit/leave_list/leave_list_cubit.dart';

class LeaveListScreen extends StatelessWidget {
  const LeaveListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? CupertinoColors.black : null,
        title: const Text('Leave List'),
      ),
      body: const LeaveListView(),
    );
  }
}

class LeaveListView extends StatelessWidget {
  const LeaveListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveListCubit, LeaveListState>(
      builder: (context, state) {
        if (state is LeaveListLoaded) {
          if (state.leaveList['leaveApplicant'].isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const OnNetWorkImage(
                  url:
                      "https://toppng.com/uploads/preview/form-icon-leave-form-11563399902l3xwyckxi9.png",
                  height: 80,
                  width: 80,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Leave List is Empty",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    context.read<LeaveListCubit>().leaveListEvent(context);
                  },
                  child: const Text("Refresh"),
                )
              ],
            ));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<LeaveListCubit>().leaveListEvent(context);
            },
            child: Text(
              state.leaveList.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            // child: ListView.separated(
            //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //   itemBuilder: (context, index) {
            //     var leaveApplication = state.leaveList[index];

            //     // return Card(
            //     //     shape: RoundedRectangleBorder(
            //     //         borderRadius: BorderRadius.circular(10)),
            //     //     child: Padding(
            //     //       padding: const EdgeInsets.all(8.0),
            //     //       child: Text(
            //     //         leaveApplication,
            //     //         style: const TextStyle(color: Colors.black),
            //     //       ),
            //     //     ));
            //   },
            //   separatorBuilder: (context, index) => 10.verticalSpace,
            //   itemCount: state.leaveList.length,
            // ),
          );
        } else if (state is LeaveListFailure) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<LeaveListCubit>().leaveListEvent(context);
                },
                child: const Text("Please Try Again"),
              )
            ],
          ));
        }
        return const ListLoader();
      },
    );
  }
}
