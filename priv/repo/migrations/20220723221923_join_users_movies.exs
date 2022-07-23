defmodule Favorite.Repo.Migrations.JoinUsersMovies do
  use Ecto.Migration

  def change do
    create table(:users_movies) do
      add :user_id, references(:users)
      add :movie_id, references(:movies)
    end

    create unique_index(:users_movies, [:user_id, :movie_id])
  end
end
