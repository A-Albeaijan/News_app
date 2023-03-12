import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusinessData(),
      child: BlocConsumer<NewsCubit, newsState>(
          listener: (context, state) =>
              {if (state is NewsGetBusinessLoadingState) {}},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('News app'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'search');
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      NewsCubit.get(context).changeAppMode();
                    },
                    icon: Icon(
                      NewsCubit.get(context).isdark == false
                          ? Icons.brightness_2_outlined
                          : Icons.sunny,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: ((index) {
                  cubit.ChangeBottmNavBar(index);
                }),
                currentIndex: cubit.currentindex,
                items: cubit.bottomItem,
              ),
              body: cubit.screens[cubit.currentindex],
            );
          }),
    );
  }
}
