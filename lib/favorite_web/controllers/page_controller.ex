defmodule FavoriteWeb.PageController do
  use FavoriteWeb, :controller
  alias Favorite.Accounts

  def index(conn, _params) do
    users = Accounts.get_all_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"username" => username}) do
    user = Accounts.get_user_by_login(username)
    render(conn, "show.html", user: user)
  end
end
