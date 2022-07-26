defmodule FavoriteWeb.MovieView do
  use FavoriteWeb, :view

  def display(movie) do
    movie.title <> "\n(" <> (movie.year |> to_string()) <> ")"
  end
end
