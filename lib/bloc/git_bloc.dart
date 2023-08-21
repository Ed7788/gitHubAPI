import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/Repo.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';
class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  UserRepo userRepo = UserRepo();

  GithubSearchBloc() : super(GithubSearchInitial()) {
    on<SearchGithubUserEvent>((event, emit) async {
      emit(GithubSearchLoading());
      try {
        final users = await userRepo.searchUsersByUsername(event.username);
        emit(GithubSearchSuccess(users));
      } catch (e) {
        emit(GithubSearchError('An error occurred'));
      }
    });
  }
}



