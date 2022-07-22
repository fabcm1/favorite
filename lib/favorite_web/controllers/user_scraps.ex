defmodule FavoriteWeb.UserScrapsController do
  use FavoriteWeb, :controller

  alias Favorite.Messages

  plug :can_edit  when action in [:delete]
 
  def delete(conn, _params) do
    scrap = conn.assigns.scrap
    Messages.delete_scrap!(scrap)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :show, scrap.recipient.login))
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
