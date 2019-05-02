defmodule Scrape.IR.Text do
  @moduledoc """
  Collection of text mining algorithms, like summarization, classification and
  clustering.

  Details are hidden within the algorithms, so a clean interface can be provided.
  """

  def generate_summary(text) do
    text
  end

  def extract_summary(text) do
    text
  end

  @doc """
  Find out in which natural language the given text is written in.

  Currently only german and (fallback) english are valid results. Uses external
  library [Paasaa](https://hex.pm/packages/paasaa).

  ## Example
      iex> Scrape.IR.Text.detect_language("the quick brown fox jumps over...")
      :en

      iex> Scrape.IR.Text.detect_language("Es ist ein schönes Wetter heute...")
      :de
  """

  @spec detect_language(String.t()) :: :de | :en

  def detect_language(text) do
    case Paasaa.detect(text) do
      "deu" -> :de
      _ -> :en
    end
  end

  @doc """
    Remove all occurences of javascript from a HTML snippet.

    Uses a regex (!)

    ## Example
        iex> Scrape.IR.Text.without_js("a<script>b</script>c")
        "ac"
  """

  @spec without_js(String.t()) :: String.t()

  def without_js(text) do
    rx = ~r/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/i
    String.replace(text, rx, "")
  end

  @doc """
    Strip all HTML tags from a text.

    ## Example
        iex> Scrape.IR.Text.without_html("<p>stuff</p>")
        "stuff"
  """

  @spec without_html(String.t()) :: String.t()

  def without_html(text) do
    text
    |> Floki.parse()
    |> Floki.text()
  end

  @doc """
    A text paragraph shall not include any whitespace except single spaces
    between words.

    ## Example
      iex> Scrape.IR.Text.normalize_whitespace("\r\thello world\r ")
      "hello world"
  """

  @spec normalize_whitespace(String.t()) :: String.t()

  def normalize_whitespace(text) do
    text
    |> String.replace(~r/\s+/, " ")
    |> String.replace(~r/\s+/, " ")
    |> String.trim()
  end
end
