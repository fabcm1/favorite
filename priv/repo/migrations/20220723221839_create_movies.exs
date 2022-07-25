defmodule Favorite.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :poster_url, :string
      add :year, :integer
    end

    create unique_index(:movies, [:title, :year])
  end
end
