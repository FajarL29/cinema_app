import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:cinema_app/ui/screen/home/section/categories/cubit/categories_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Categories',
                style: TextStyle(
                    color: ColorPallete.colorSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              'View all',
              style: TextStyle(
                color: ColorPallete.colorOrange,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoaded){
              return SizedBox(
                height: 31,
                child: ListView.separated(
                  itemCount: state.data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  itemBuilder: (context, index) {
                    var namaCategories = state.data[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 31, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: ColorPallete.colorGrey),
                      child: Center(
                        child: Text(
                          '${namaCategories.name}',
                          style: TextStyle(color: ColorPallete.colorSecondary),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CategoriesFailed){
              return Text(state.message);
            } else {
              return const CircularProgressIndicator();
            }
          }
        ),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
