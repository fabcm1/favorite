defmodule Favorite.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Favorite.Repo

  alias Favorite.Messages.Scrap

  @doc """
  Returns the list of scraps of a given user as recipient.

  ## Examples

      iex> list_scraps()
      [%Scrap{}, ...]

  """
  def list_scraps_recipient(user) do
    Repo.preload(user, scraps: [:author])
    user.scraps
  end

  @doc """
  Gets a single scrap.

  Raises `Ecto.NoResultsError` if the Scrap does not exist.

  ## Examples

      iex> get_scrap!(123)
      %Scrap{}

      iex> get_scrap!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scrap!(id), do: Repo.get!(Scrap, id)

  @doc """
  Creates a scrap.

  ## Examples

      iex> create_scrap(%{field: value})
      {:ok, %Scrap{}}

      iex> create_scrap(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scrap(attrs \\ %{}) do
    %Scrap{}
    |> Scrap.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scrap.

  ## Examples

      iex> update_scrap(scrap, %{field: new_value})
      {:ok, %Scrap{}}

      iex> update_scrap(scrap, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scrap(%Scrap{} = scrap, attrs) do
    scrap
    |> Scrap.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scrap.

  ## Examples

      iex> delete_scrap(scrap)
      {:ok, %Scrap{}}

      iex> delete_scrap(scrap)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scrap(%Scrap{} = scrap) do
    Repo.delete(scrap)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scrap changes.

  ## Examples

      iex> change_scrap(scrap)
      %Ecto.Changeset{data: %Scrap{}}

  """
  def change_scrap(%Scrap{} = scrap, attrs \\ %{}) do
    Scrap.changeset(scrap, attrs)
  end
end
