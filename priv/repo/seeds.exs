# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Favorite.Repo.insert!(%Favorite.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Favorite.{Accounts, Messages, Movies}

Accounts.register_user(%{
  name: "User A",
  email: "aaa@acbd.com",
  login: "userA",
  password: "senha00A"
})

Accounts.register_user(%{
  name: "User B",
  email: "bbb@acbd.com",
  login: "userB",
  password: "senha00B"
})

Accounts.register_user(%{
  name: "User C",
  email: "ccc@acbd.com",
  login: "userC",
  password: "senha00C"
})

userA = Accounts.get_user_by_login("userA")
userB = Accounts.get_user_by_login("userB")
userC = Accounts.get_user_by_login("userC")

Messages.create_scrap(userA, userB, "Hello there!")
Messages.create_scrap(userA, userB, "Hello!")
Messages.create_scrap(userA, userB, "there!")
Messages.create_scrap(userC, userB, "C!")
Messages.create_scrap(userB, userC, "B!")

movies_params = [
  %{
    title: "Le fabuleux destin d'Amélie Poulain",
    year: 2001,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/voj9yngs/le-fabuleux-destin-damelie-poulain-french-movie-poster.jpg"
  },
  %{
    title: "Mother!",
    year: 2017,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/y3w7dxgr/mother-australian-movie-poster.jpg"
  },
  %{
    title: "Fantastic Mr. Fox",
    year: 2009,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/nyswpzub/fantastic-mr-fox-movie-poster.jpg"
  },
  %{
    title: "L'écume des jours",
    year: 2013,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/ljq3a6oq/lecume-des-jours-french-movie-poster.jpg"
  },
  %{
    title: " Medianeras",
    year: 2011,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/txwvqavg/medianeras-argentinian-movie-poster.jpg"
  },
  %{
    title: "Inception",
    year: 2010,
    poster_url: "https://movieposters2.com/images/692793-b.jpg"
  },
  %{
    title: "The Wolf of Wall Street",
    year: 2013,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/ww791icg/the-wolf-of-wall-street-movie-poster.jpg"
  },
  %{
    title: "The Great Gatsby",
    year: 2013,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/tb78gura/the-great-gatsby-movie-poster.jpg"
  },
  %{
    title: "Django Unchained",
    year: 2012,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/hj2oda1x/django-unchained-theatrical-movie-poster.jpg"
  },
  %{
    title: "Inglourious Basterds",
    year: 2009,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/etvsauby/inglourious-basterds-movie-poster.jpg"
  },
  %{
    title: "Kill Bill: Vol. 1",
    year: 2003,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/y4lekhlk/kill-bill-vol-1-movie-poster.jpg"
  },
  %{
    title: "Pulp Fiction",
    year: 1994,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/hmc4otl5/pulp-fiction-theatrical-movie-poster.jpg"
  },
  %{
    title: "Doctor Strange",
    year: 2016,
    poster_url: "https://movieposters2.com/images/1573600-b.jpg"
  },
  %{
    title: "The Imitation Game",
    year: 2014,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/ss6kbuu8/the-imitation-game-british-movie-poster.jpg"
  },
  %{
    title: "Sherlock",
    year: 2010,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/cqzeug1z/sherlock-british-movie-poster.jpg"
  },
  %{
    title: "Eternal Sunshine of the Spotless Mind",
    year: 2004,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/rhjzyudl/eternal-sunshine-of-the-spotless-mind-movie-poster.jpg"
  },
  %{
    title: "The Matrix",
    year: 1999,
    poster_url: "https://media-cache.cinematerial.com/p/500x/uq49lqmo/the-matrix-movie-poster.jpg"
  },
  %{
    title: "John Wick",
    year: 2014,
    poster_url: "https://movieposters2.com/images/1204393-b.jpg"
  },
  %{
    title: "The Matrix Reloaded",
    year: 2003,
    poster_url:
      "https://media-cache.cinematerial.com/p/500x/tmeigl34/the-matrix-reloaded-movie-poster.jpg"
  }
]

for params <- movies_params do
  try do
    Movies.create_movie(params)
  rescue
    Ecto.ConstraintError -> ''
  end
end

m1 = Movies.get_movie!(1)
m2 = Movies.get_movie!(2)
m3 = Movies.get_movie!(3)

Movies.update_favorite_movies(userA, [m1, m2, m3])
Movies.update_favorite_movies(userB, [m1])
