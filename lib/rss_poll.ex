defmodule RssPoll do
  alias HTTPotion.Response

  @user_agent ["User-agent": "RSSFeedParser/1.0"]

  def fetch(rss_url) do
    case HTTPotion.get(rss_url, @user_agent) do
      Response[body: body, status_code: status, headers: _headers] when status in 200..299 ->
        {parsed, _} = :binary.bin_to_list(body) |> :xmerl_scan.string([xmlbase: rss_url, space: :normalize])
        {:ok, parsed}
      response ->
        {:error, response}
    end
  end

  def parse(xml) do
    defrecord :xmlDecl,      Record.extract(:xmlDecl,      from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlNamespace, Record.extract(:xmlNamespace, from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlNsNode,    Record.extract(:xmlNsNode,    from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlElement,   Record.extract(:xmlElement,   from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlText,      Record.extract(:xmlText,      from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlComment,   Record.extract(:xmlComment,   from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlPI,        Record.extract(:xmlPI,        from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlDocument,  Record.extract(:xmlDocument,  from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlContext,   Record.extract(:xmlContext,   from_lib: "xmerl/include/xmerl.hrl")
    defrecord :xmlObj,       Record.extract(:xmlObj,       from_lib: "xmerl/include/xmerl.hrl")
  end



  # -record(xmlElement,{
  # 	  name,			% atom()
  # 	  expanded_name = [],	% string() | {URI,Local} | {"xmlns",Local}
  # 	  nsinfo = [],	        % {Prefix, Local} | []
  # 	  namespace=#xmlNamespace{},
  # 	  parents = [],		% [{atom(),integer()}]
  # 	  pos,			% integer()
  # 	  attributes = [],	% [#xmlAttribute()]
  # 	  content = [],
  # 	  language = "",	% string()
  # 	  xmlbase="",           % string() XML Base path, for relative URI:s
  # 	  elementdef=undeclared % atom(), one of [undeclared | prolog | external | element]
  # 	 }).

  # defrecordp :xmlElement, name: :undefined, expanded_name: [], nsinfo: [], namespace: {:xmlNamespace, [], []}, parents: [], pos: :undefined, attributes: [], content: [], language: [], xmlbase: [], elementdef: :undeclared
  #  {:ok, xml} = RssPoll.fetch "http://feeds.reuters.com/Counterparties?format=xml"
  #  [i] = :xmerl_xpath.string('/rss/channel/item[1]/content:encoded',xml)
end
