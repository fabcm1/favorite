defmodule FavoriteWeb.UserDeleteController do
  use FavoriteWeb, :controller

  alias Favorite.Accounts
 
  def confirm_delete(conn, _params) do
    changeset = Accounts.change_user_password(conn.assigns.current_user)
    render(conn, "confirm_delete.html", changeset: changeset)
  end
  
  def delete(conn, %{"current_password" => password}) do
    user = conn.assigns.current_user
  
    case Accounts.delete_user(user, password) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account #{user.name} deleted successfully.")
        |> redirect(to: "/")

      {:error, changeset} ->        
        conn
        |> put_flash(:error, "Something went wrong.")
        |> render("confirm_delete.html", changeset: changeset)
    end
  end
end
