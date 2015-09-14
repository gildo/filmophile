defmodule Filmophile.Base do
  use HTTPoison.Base

  def process_url(endpoint) do
    "http://api.themoviedb.org/3" <> endpoint <> api_key
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def process_headers(headers) do
    headers
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  defp api_key do
    "api_key=" <> System.get_env("TMDB_KEY")
  end

end

defmodule Filmophile do
  alias Filmophile.Base, as: Base

  def movie(id) do
    Base.get!("/movie/#{id}?")
  end

  def popular_movies(page \\ 1) do
    Base.get!("/movie/popular?page=#{page}&")
  end
end
