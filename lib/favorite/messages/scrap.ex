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
    |> cast(attrs, [:content, :author, :recipient])
    |> validate_required([:content])
    |> validate_not_alone
  end
  
  defp validate_not_alone(
        %{changes: %{author: author, recipient: recipient}} = changeset
       ) do
    if author == recipient do
      add_error(changeset, :changes, "author and recipient must be different users")
    else
      changeset
    end
  end
end
