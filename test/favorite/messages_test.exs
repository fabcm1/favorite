defmodule Favorite.MessagesTest do
  use Favorite.DataCase

  alias Favorite.Messages

  describe "scraps" do
    alias Favorite.Messages.Scrap

    import Favorite.MessagesFixtures

    @invalid_attrs %{content: nil}

    test "list_scraps/0 returns all scraps" do
      scrap = scrap_fixture()
      assert Messages.list_scraps() == [scrap]
    end

    test "get_scrap!/1 returns the scrap with given id" do
      scrap = scrap_fixture()
      assert Messages.get_scrap!(scrap.id) == scrap
    end

    test "create_scrap/1 with valid data creates a scrap" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Scrap{} = scrap} = Messages.create_scrap(valid_attrs)
      assert scrap.content == "some content"
    end

    test "create_scrap/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_scrap(@invalid_attrs)
    end

    test "update_scrap/2 with valid data updates the scrap" do
      scrap = scrap_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Scrap{} = scrap} = Messages.update_scrap(scrap, update_attrs)
      assert scrap.content == "some updated content"
    end

    test "update_scrap/2 with invalid data returns error changeset" do
      scrap = scrap_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_scrap(scrap, @invalid_attrs)
      assert scrap == Messages.get_scrap!(scrap.id)
    end

    test "delete_scrap/1 deletes the scrap" do
      scrap = scrap_fixture()
      assert {:ok, %Scrap{}} = Messages.delete_scrap(scrap)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_scrap!(scrap.id) end
    end

    test "change_scrap/1 returns a scrap changeset" do
      scrap = scrap_fixture()
      assert %Ecto.Changeset{} = Messages.change_scrap(scrap)
    end
  end
end
