defmodule AssignmentWeb.Graphql.Schema do
  use Absinthe.Schema

  import_types(AssignmentWeb.Graphql.Schema.WeatherTypes)

  query do
    import_fields(:weatherQueries)
  end
  
end
