defmodule FavoriteWeb.UserSettingsController do
  use FavoriteWeb, :controller

  alias Favorite.Accounts
  alias FavoriteWeb.UserAuth

  plug :assign_name_email_and_password_changesets when action not in [:confirm_delete, :delete]

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def update(conn, %{"action" => "update_name_email"} = params) do
    %{"current_password" => password, "user" => user_params} = params
    user = conn.assigns.current_user

    case Accounts.apply_user_name_email(user, password, user_params) do
      {:ok, applied_user, changes} ->
        with name_response <- maybe_change_name(user, changes),
             email_response <- maybe_deliver_email_instructions(conn, user, applied_user, changes)
        do conn
           |> put_flash(:info, name_response <> email_response)
           |> redirect(to: Routes.user_settings_path(conn, :edit))
        end

      {:error, changeset} ->
        render(conn, "edit.html", name_email_changeset: changeset)
    end
  end

  def update(conn, %{"action" => "update_password"} = params) do
    %{"current_password" => password, "user" => user_params} = params
    user = conn.assigns.current_user

    case Accounts.update_user_password(user, password, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Password updated successfully.")
        |> put_session(:user_return_to, Routes.user_settings_path(conn, :edit))
        |> UserAuth.log_in_user(user)

      {:error, changeset} ->
        render(conn, "edit.html", password_changeset: changeset)
    end
  end
  
  defp maybe_change_name(user, changes) do
    case changes do 
      %{name: new_name} -> 
        Accounts.update_user_name!(user, new_name)
        "Your name has changed. "
      _ -> ""
    end 
  end
  
  defp maybe_deliver_email_instructions(conn, user, applied_user, changes) do
    case changes do 
      %{email: _} -> 
        Accounts.deliver_update_email_instructions(
          applied_user,
          user.email,
          &Routes.user_settings_url(conn, :confirm_email, &1)
        )
        "A link to confirm your email change has been sent to the new address."
      _ -> ""
    end
  end

  def confirm_email(conn, %{"token" => token}) do
    case Accounts.update_user_email(conn.assigns.current_user, token) do
      :ok ->
        conn
        |> put_flash(:info, "Email changed successfully.")
        |> redirect(to: Routes.user_settings_path(conn, :edit))

      :error ->
        conn
        |> put_flash(:error, "Email change link is invalid or it has expired.")
        |> redirect(to: Routes.user_settings_path(conn, :edit))
    end
  end
  
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
  
  defp assign_name_email_and_password_changesets(conn, _opts) do
    user = conn.assigns.current_user

    conn
    |> assign(:name_email_changeset, Accounts.change_user_name_email(user))
    |> assign(:password_changeset, Accounts.change_user_password(user))
  end
end
