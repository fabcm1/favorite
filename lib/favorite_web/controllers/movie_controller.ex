defmodule FavoriteWeb.MovieController do
  use FavoriteWeb, :controller

  alias Favorite.Movies

  def index(conn, params) do
    search_term =
      case params do
        %{"s" => %{"q" => query}} -> query
        _ -> ''
      end

    movies = Movies.list_movies(search_term)
    render(conn, "index.html", movies: movies)
  end

  def edit(conn, _params) do
    changeset = Movies.change_new_movie()
    render(conn, "edit.html", changeset: changeset)
  end

  def show(conn, %{"id" => movie_id}) do
    case Movies.get_movie(movie_id, [:users]) do
      %Movies.Movie{} = movie ->
        render(conn, "show.html", movie: movie)

      nil ->
        conn
        |> put_flash(:error, "Movie not found.")
        |> redirect(to: Routes.movie_path(conn, :index))
    end
  end

  def create(conn, %{"movie" => movie_params}) do
    case Movies.create_movie(movie_params) do
      {:ok, _movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def add(conn, %{"add" => %{"movie_id" => movie_id, "redirect_to" => url}}) do
    user = conn.assigns.current_user

    Movies.add_favorite_movie!(String.to_integer(movie_id), user.id)

    conn
    |> redirect(to: url)
  end

  def remove(conn, %{"remove" => %{"movie_id" => movie_id, "redirect_to" => url}}) do
    user = conn.assigns.current_user

    Movies.remove_favorite_movie!(String.to_integer(movie_id), user.id)

    conn
    |> redirect(to: url)
  end
end
