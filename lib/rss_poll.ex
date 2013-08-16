defmodule RssPoll do
  alias HTTPotion.Response

  @user_agent ["User-agent": "RSSFeedParser/1.0"]

  def fetch(rss_url) do
    case HTTPotion.get(rss_url, @user_agent) do
      Response[body: body, status_code: status, headers: _headers] when status in 200..299 -> {:ok,body |> parse_xml}
      response -> {:error, response}
    end
  end

  defp parse_xml(xml) do
    xml
  end
end
