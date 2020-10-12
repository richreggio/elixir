defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    # Seperates markdown string into a List of strings according to line breaks
    |> String.split("\n")
    # Checks each string in the list to see if it is a header, list, or paragraph and sends to the appropriate parser
    |> Enum.map(fn markdown_string -> process(markdown_string) end)
    # recombines all the strings in the list back into 1 string
    |> Enum.join()
    # Adds <ul> and </ul> tags to make lists functional
    |> patch()
  end

  defp process(markdown_string) do
    # Checks if the string is a Header or a List
    if String.starts_with?(markdown_string, "#") || String.starts_with?(markdown_string, "*") do
      # If string starts with a Header
      if String.starts_with?(markdown_string, "#") do
        markdown_string
        # Parse number of #'s to determine WHICH header to use
        |> parse_header_md_level()
        # Build the sentence
        |> enclose_with_header_tag()
      else
        # If it's not a header, must be a list
        parse_list_md_level(markdown_string)
      end

      # If not a Header or List then must be a paragraph
    else
      markdown_string
      # Breaks string into a list of words
      |> String.split()
      |> enclose_with_paragraph_tag()
    end
  end

  # Reads the passed string and returns a tuple, first value is the number of #'s at the beginning of the string (Should be 1-6)
  # Second value is the remaining words in the original string all seperated by a single space.
  defp parse_header_md_level(markdown_string) do
    [header_string | string_content_list] = String.split(markdown_string)
    {to_string(String.length(header_string)), Enum.join(string_content_list, " ")}
  end

  defp parse_list_md_level(string) do
    word_list = String.split(String.trim_leading(string, "* "))
    "<li>" <> join_words_with_tags(word_list) <> "</li>"
  end

  # Takes a tuple with the first value being the header length and the second being a string for the header content.
  # Returns the string content wrapped in the appropriate header tags
  defp enclose_with_header_tag({header_value, content_string}) do
    "<h" <> header_value <> ">" <> content_string <> "</h" <> header_value <> ">"
  end

  # Creates the paragraph tag and sends the contents (List of word strings) to be iterated over to form the full paragraph
  defp enclose_with_paragraph_tag(word_list) do
    "<p>#{join_words_with_tags(word_list)}</p>"
  end

  # Iterates over every word in the list and adds a space in between
  defp join_words_with_tags(word_list) do
    word_list
    |> Enum.map(fn word -> replace_md_with_tag(word) end)
    |> Enum.join(" ")
  end

  #
  defp replace_md_with_tag(word) do
    word
    # converts _ and __ into <em> and <strong> tags at the front of words
    |> replace_prefix_md()
    # converts _ and __ into </em> and </strong> tags at the end of words
    |> replace_suffix_md()
  end

  # Checks the beginning of a word to see if it is _italic or __bold, adds tag when appropriate
  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  # Checks the end of a word to see if it is italic_ or bold__, adds tag when appropriate
  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  # Adds the opening and closing unordered list tags before the first list item and after the last list item respectively
  defp patch(html_string) do
    html_string
    # Finds the first <li> element and prepends the <ul> tag
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    # Finds the last <li> element and appends the </ul> tag
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
