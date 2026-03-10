import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafetch/features/users_list/presentation/bloc/user_event.dart';
import 'package:lafetch/features/users_list/presentation/pages/user_details.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final TextEditingController _searchController = TextEditingController();
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [const Text("Users List")]),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),

          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: "Search by name, email, or company",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            query = value.toLowerCase();
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserLoaded) {
          final users = state.users;

          final filteredUsers = users.where((user) {
            return user.name.toLowerCase().contains(query) ||
                user.email.toLowerCase().contains(query) ||
                user.company.name.toLowerCase().contains(query);
          }).toList();

          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserBloc>().add(GetUsersEvent());
            },

            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(user.email), Text(user.company.name)],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailPage(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }

        if (state is UserError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
