
class GithubSearchEvent {}

class SearchGithubUserEvent extends GithubSearchEvent {
  final String username;
  SearchGithubUserEvent(this.username);
}