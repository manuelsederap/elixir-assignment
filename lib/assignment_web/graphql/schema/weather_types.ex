defmodule AssignmentWeb.Graphql.Schema.WeatherTypes do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias AssignmentWeb.Graphql.Resolver.WeatherForecast

  @desc "Weather forecast"
  object :weather do
    field(:date, :integer, description: "current weather dt")
    field(:sunrise, :integer, description: "current weather sunrise")
    field(:sunset, :integer, description: "current weather sunset")
    field(:temperature, :float, description: "current weather temp")
    field(:feelslike, :float, description: "current weather feels like")
    field(:latitude, :float, description: "latitude")
    field(:longitude, :float, description: "longitude")
    field(:weather, list_of(:weathers), description: "current weathers")
    field(:daily, list_of(:daily_weather), description: "daily weather")
  end

  object :weathers do
    field(:main, :string)
    field(:description, :string)
  end

  object :daily_weather do
    field(:date, :integer)
    field(:pressure, :integer)
    field(:humidity, :integer)
    field(:temperature, :temperatures)
    field(:feelslike, :feelsLikes)
  end

  object :temperatures do
    field(:day, :float)
    field(:min, :float)
    field(:max, :float)
    field(:night, :float)
    field(:evening, :float)
    field(:morning, :float)
  end

  object :feelsLikes do
    field(:day, :float)
    field(:night, :float)
    field(:evening, :float)
    field(:morning, :float)
  end

  @desc "Weather queries"
  object :weatherQueries do
    @desc "return weather forecast details"
    field :weather_forecast, :weather do
      arg(:latitude, non_null(:string))
      arg(:longitude, non_null(:string))
      resolve (&WeatherForecast.get_weather_forecast/3)
    end
  end
end
