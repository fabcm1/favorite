defmodule Favorite.Repo.Migrations.AddUserAccessible do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :accessible, :boolean, default: true
      add :reason, :string
    end
  end
end
