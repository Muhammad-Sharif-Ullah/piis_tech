import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListLoader extends StatelessWidget {
  const ListLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.black26,
            child: ListTile(
              dense: true,
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 25,
              ),
              title: Container(
                height: 15,
                width: 0.3.sw,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              subtitle: Container(
                height: 5,
                width: 0.3.sw,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              trailing: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => 10.verticalSpace,
        itemCount: 100);
  }
}
