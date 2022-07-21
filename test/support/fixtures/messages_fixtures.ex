defmodule Favorite.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Favorite.Messages` context.
  """

  @doc """
  Generate a scrap.
  """
  def scrap_fixture(attrs \\ %{}) do
    {:ok, scrap} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> Favorite.Messages.create_scrap()

    scrap
  end
end
