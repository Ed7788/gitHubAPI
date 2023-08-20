

class GithubSearchState {}

class GithubSearchInitial extends GithubSearchState {}

class GithubSearchLoading extends GithubSearchState {}

class GithubSearchSuccess extends GithubSearchState {
  final List<dynamic> users;
  GithubSearchSuccess(this.users);
}

class GithubSearchError extends GithubSearchState {
  final String error;
  GithubSearchError(this.error);
}