defmodule Favorite.Movies.MovieUserJoin do
  use Ecto.Schema

  schema "users_movies" do
    belongs_to :movie, Favorite.Movies.Movie
    belongs_to :user, Favorite.Accounts.User
  end
end
