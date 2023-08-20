import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';
import 'package:http/http.dart' as http;
class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc() : super(GithubSearchInitial()) {
    on<SearchGithubUserEvent>((event, emit) async {
      emit(GithubSearchLoading());
      try {
        final response = await http.get(Uri.parse('https://api.github.com/search/users?q=${event.username}'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final users = data['items'].map((userData) => User.fromJson(userData)).toList();
          emit(GithubSearchSuccess(users));
        } else {
          emit(GithubSearchError('Error fetching data'));
        }
      } catch (e) {
        emit(GithubSearchError('An error occurred'));
      }
    });
  }
  }

