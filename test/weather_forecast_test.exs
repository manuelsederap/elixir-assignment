defmodule WeatherForecastTest do

  alias AssignmentWeb.Graphql.Resolver.WeatherForecast, as: WF
  use ExUnit.Case, async: true

  test "with no latitude and longitude" do
    params = %{
      latitude: "",
      longitude: ""
    }
    assert WF.get_weather_forecast(params) == {:error, [message: "Enter latitude and longitude"]}
  end

  test "with no latitude but valid longitude" do
    params = %{
      latitude: "",
      longitude: "-94.037689"
    }
    assert WF.get_weather_forecast(params) == {:error, [message: "Enter latitude"]}
  end

  test "with no longitude but valid latitude" do
    params = %{
      latitude: "33.441792",
      longitude: ""
    }
    assert WF.get_weather_forecast(params) == {:error, [message: "Enter longitude"]}
  end

  test "with invalid latitude" do
    params = %{
      latitude: "invalid",
      longitude: "-94.037689"
    }
    assert WF.get_weather_forecast(params) == {:error, [message: "wrong latitude"]}
  end

  test "with invalid longitude" do
    params = %{
      latitude: "33.441792",
      longitude: "invalid"
    }
    assert WF.get_weather_forecast(params) == {:error, [message: "wrong longitude"]}
  end
end