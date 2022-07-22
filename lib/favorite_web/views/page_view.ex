defmodule FavoriteWeb.PageView do
  use FavoriteWeb, :view

  def my_to_string(date = %NaiveDateTime{}) do
    "#{date.hour}:#{date.minute} #{date.day}/#{date.month}/#{date.year}"
  end
  
  def can_edit(user, scrap) do
    if user do
      user.id == scrap.author_id || user.id == scrap.recipient_id
    else
      false
    end
  end

end
