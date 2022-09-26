defmodule Favorite.Repo.Migrations.CreateScraps do
  use Ecto.Migration

  def change do
    create table(:scraps) do
      add :content, :string
      add :author_id, references(:users, on_delete: :nothing)
      add :recipient_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:scraps, [:recipient_id])
  end
end
