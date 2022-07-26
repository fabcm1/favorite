defmodule FavoriteWeb.PageController do
  use FavoriteWeb, :controller
  alias Favorite.{Accounts, Messages, Movies}

  def index(conn, _params) do
    users = Accounts.get_all_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"username" => username}) do
    case Accounts.get_user_by_login(username) do
      %Accounts.User{} = user ->
        scraps = Messages.list_scraps_recipient(user) |> Enum.reverse()
        user_movies = Movies.get_favorite_movies(user)
        all_movies = Movies.list_movies()

        render(conn, "show.html",
          user: user,
          scraps: scraps,
          user_movies: user_movies,
          all_movies: all_movies
        )

      nil ->
        conn
        |> put_flash(:error, "User #{username} does not exist.")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
