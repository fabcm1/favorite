defmodule FavoriteWeb.UserScrapsController do
  use FavoriteWeb, :controller

  alias Favorite.{Messages, Accounts}

  plug :can_edit  when action in [:delete]
 
  def delete(conn, _params) do
    scrap = conn.assigns.scrap
    Messages.delete_scrap!(scrap)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :show, scrap.recipient.login))
  end
  
  def create(conn, %{"create_scrap" => params}) do
    %{"recipient" => recipient_login, "content" => content} = params
  
    if conn.assigns.current_user.confirmed_at do
      Accounts.get_user_by_login(recipient_login)
      |> Messages.create_scrap(conn.assigns.current_user, content)  
      
      conn
      |> put_flash(:info, "Message created successfully.")
      |> redirect(to: Routes.page_path(conn, :show, recipient_login))
    else
      conn
      |> put_flash(:error, "You have to confirm your email before sending a message.")
      |> redirect(to: Routes.page_path(conn, :show, recipient_login))
    end
  end
  
  def can_edit(conn, _params) do
    %{params: %{"id" => scrap_id}} = conn
    case Messages.get_scrap(scrap_id, [:recipient]) do
      %Messages.Scrap{} = scrap ->
        user = conn.assigns.current_user
        if user.id == scrap.author_id || user.id == scrap.recipient_id do
          assign(conn, :scrap, scrap)
        else
          conn
          |> put_flash(:error, "You cannot edit this message.")
          |> redirect(to: Routes.page_path(conn, :show, scrap.recipient.login))
          |> halt()
        end
      nil ->
        conn
        |> put_flash(:error, "Messsage not found.")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end
  end
  
end
