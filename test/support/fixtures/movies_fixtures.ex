defmodule Favorite.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Favorite.Movies` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        poster_url: "some poster_url",
        title: "some title"
      })
      |> Favorite.Movies.create_movie()

    movie
  end
end
