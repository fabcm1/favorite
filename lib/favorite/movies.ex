defmodule Favorite.Movies do
  @moduledoc """
  The Movies context.
  """

  import Ecto.Query, warn: false
  alias Favorite.Repo

  alias Favorite.Accounts.User
  alias Favorite.Movies.Movie
  alias Favorite.Movies.MovieUserJoin

  @doc """
  Returns the list of movies a user has favorited.

  ## Examples

      iex> get_favorite_movies()
      [%Movie{}, ...]

  """
  def get_favorite_movies(%User{} = user) do
    user
    |> Repo.preload(:movies)
    |> Map.get(:movies)
  end

  @doc """
  Update the list of movies a user has favorited.

  ## Examples

      iex> update_favorite_movies(%User{} = user, movies)
      %User{movies: movies}

  """
  def update_favorite_movies(%User{} = user, movies) do
    user
    |> Repo.preload(:movies)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:movies, movies)
    |> Repo.update!()
  end

  @doc """
  Returns the list of movies.

  ## Examples

      iex> list_movies()
      [%Movie{}, ...]

  """
  def list_movies do
    Repo.all(Movie) |> Enum.sort_by(& &1.title)
  end

  @doc """
  Gets a single movie.

  Raises `Ecto.NoResultsError` if the Movie does not exist.

  ## Examples

      iex> get_movie!(123)
      %Movie{}

      iex> get_movie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie!(id), do: Repo.get!(Movie, id)

  @doc """
  Creates a movie.

  ## Examples

      iex> create_movie(%{field: value})
      {:ok, %Movie{}}

      iex> create_movie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie(attrs \\ %{}) do
    %Movie{}
    |> Movie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for creating a movie.

  ## Examples

      iex> change_new_movie()
      %Ecto.Changeset{data: %Movie{}}

  """
  def change_new_movie(attrs \\ %{}) do
    Movie.changeset(%Movie{}, attrs)
  end

  @doc """
  Updates a movie.

  ## Examples

      iex> update_movie(movie, %{field: new_value})
      {:ok, %Movie{}}

      iex> update_movie(movie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie(%Movie{} = movie, attrs) do
    movie
    |> Movie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movie.

  ## Examples

      iex> delete_movie(movie)
      {:ok, %Movie{}}

      iex> delete_movie(movie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie(%Movie{} = movie) do
    Repo.delete(movie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie changes.

  ## Examples

      iex> change_movie(movie)
      %Ecto.Changeset{data: %Movie{}}

  """
  def change_movie(%Movie{} = movie, attrs \\ %{}) do
    Movie.changeset(movie, attrs)
  end

  # Many to many update methods: the following two commented methods
  # work, (once "on_replace: :delete" is added to both schemas) but
  # they load the entire association list to make one change.
  # Instead, it is better to work with the join table directly.

  # def add_favorite_movie!(movie, user) do
  #   movie = Repo.preload(movie, :users)
  #   movie
  #   |> Ecto.Changeset.change()
  #   |> Ecto.Changeset.put_assoc(:users, [user | movie.users])
  #   |> Repo.update!()
  # end

  # def remove_favorite_movie!(movie, user) do
  #   movie = Repo.preload(movie, :users)
  #   movie
  #   |> Ecto.Changeset.change()
  #   |> Ecto.Changeset.put_assoc(:users, movie.users |> Enum.reject(fn u -> u == user end))
  #   |> Repo.update!()
  # end

  def add_favorite_movie!(movie_id, user_id) do
    %MovieUserJoin{movie_id: movie_id, user_id: user_id}
    |> Ecto.Changeset.change()
    |> Repo.insert!(on_conflict: :nothing)
  end

  def remove_favorite_movie!(movie_id, user_id) do
    MovieUserJoin
    |> Repo.get_by(user_id: user_id, movie_id: movie_id)
    |> Repo.delete!()
  end
end
