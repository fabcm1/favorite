defmodule Favorite.Messages.Scrap do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scraps" do
    field :content, :string
    belongs_to :author, Favorite.Accounts.User
    belongs_to :recipient, Favorite.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(scrap, attrs) do
    scrap
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
