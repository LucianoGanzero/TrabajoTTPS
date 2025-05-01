AlgoliaSearch.configuration = {
  application_id: ENV["ALGOLIA_APPLICATION_ID"],
  api_key: ENV["ALGOLIA_API_KEY"]
}

raise "Falta ALGOLIA_API_KEY" unless ENV["ALGOLIA_API_KEY"]
raise "Falta ALGOLIA_APPLICATION_ID" unless ENV["ALGOLIA_APPLICATION_ID"]
