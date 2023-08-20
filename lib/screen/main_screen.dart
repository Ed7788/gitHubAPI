import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_event.dart';
import '../bloc/bloc_state.dart';
import '../bloc/git_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub User Search',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => GithubSearchBloc(),
        child: GithubSearchScreen(),
      ),
    );
  }
}

class GithubSearchScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  GithubSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GithubSearchBloc githubSearchBloc = BlocProvider.of<GithubSearchBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('GitHub User Search')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Enter GitHub Username'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  if(username.isEmpty){
                    return;
                  }
                  githubSearchBloc.add(SearchGithubUserEvent(username));
                },
                child: const Text('Search'),
              ),
              const SizedBox(height: 20),
              BlocBuilder<GithubSearchBloc, GithubSearchState>(
                builder: (context, state) {
                  if (state is GithubSearchInitial) {
                    return const Text('Enter a GitHub username to find user.');
                  } else if (state is GithubSearchLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is GithubSearchSuccess) {
                    final users = state.users;
                    if(users.isEmpty){
                      return const Center(
                        child: Text("User not found"),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatarUrl)
                            ),
                            title: Text(user.login),
                          );
                        },
                      ),
                    );
                  } else if (state is GithubSearchError) {
                    return Text('Error: ${state.error}');
                  } else {
                    return const Text('Unknown state');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}