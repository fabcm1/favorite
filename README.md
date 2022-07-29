# Favorite

This is a learning project that aims to create a Phoenix app where users can authenticate themselves, have a page, add, and delete comments on other user pages and mark their favorite movies.

## Installation 

To install Phoenix follow the guide in the [official page](https://hexdocs.pm/phoenix/installation.html). There you will be asked to install Elixir, Hex, Erlang, Phoenix itself, and PostgreSQL.

The file `config/dev.exs` takes the local username and database keys from the environment variables `POSTGRESQL_DATABASE_KEY` and `POSTGRESQL_USERNAME`. If you just installed PostgreSQL and did not configured it, they are both `postgres`. You may set the environment variables in your `~/.bashrc` file as 
```
export POSTGRESQL_DATABASE_KEY="postgres"
export POSTGRESQL_USERNAME="postgres"
```

Fetch and install all project dependencies
```console
$ mix deps.get
$ mix deps.compile
```

Create the local database
```console
$ mix ecto.create
$ mix ecto.migrate
```
A lot of things can go wrong at this step, check [the guide for mix ecto.create](https://hexdocs.pm/phoenix/mix_tasks.html#ecto-specific-mix-tasks) for general troubleshooting.

Insert the first few users, messages, and movies in the database
```console
$ mix run priv/repo/seeds.exs
```

That is all! Run the application with
```console
$ mix phx.server
```
and stop it hitting `ctrl-c` twice.
