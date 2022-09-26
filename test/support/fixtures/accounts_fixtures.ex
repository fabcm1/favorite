defmodule Favorite.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Favorite.Accounts` context.
  """

  @unique_id System.unique_integer()

  def unique_user_email, do: "user#{@unique_id}@example.com"
  def unique_user_login, do: "user#{@unique_id}"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: "TEST_USER",
      login: unique_user_login(),
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Favorite.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
