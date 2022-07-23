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

alias Favorite.{Accounts, Messages}

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
