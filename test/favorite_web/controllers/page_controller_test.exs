defmodule FavoriteWeb.PageControllerTest do
  use FavoriteWeb.ConnCase
  import Favorite.AccountsFixtures

  setup %{conn: conn} do
    %{user: user_fixture(), conn: conn}
  end

  test "GET /", %{conn: conn, user: user} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<a href=\"/profiles/#{user.login}\">#{user.name}</a>"
  end
end
