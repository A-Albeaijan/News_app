import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../widgets/widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, newsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).searchResult;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Search must not be empty';
                    }
                  },
                  cursorColor: Colors.grey,
                  controller: searchController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    prefix: Icon(
                      Icons.search,
                    ),
                  ),
                  //searching
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(child: ReWidget.artBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
