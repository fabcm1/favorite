defmodule Favorite.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :poster_url, :string
    field :title, :string
    field :year, :integer

    many_to_many :users, Favorite.Accounts.User, join_through: "users_movies"
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :poster_url, :year])
    |> validate_required([:title, :poster_url, :year])
    |> normalize_title()

    # |> validate_format(:poster_url, ~r/^[^\s]+(\.jpg)$/, message: "must be the link to a jpg image")
  end

  defp normalize_title(changeset) do
    title = get_change(changeset, :title)

    if title do
      changeset
      |> put_change(:title, String.trim(title))
    else
      changeset
    end
  end
end
