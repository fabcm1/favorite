defmodule FavoriteWeb.UserSessionController do
  use FavoriteWeb, :controller

  alias Favorite.Accounts
  alias FavoriteWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"login" => login, "password" => password} = user_params

    if user = Accounts.get_user_by_login_and_password(login, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the login is registered.
      render(conn, "new.html", error_message: "Invalid login or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
