defmodule AssignmentWeb.Graphql.Resolver.WeatherForecast do
  use Tesla
  plug Tesla.Middleware.JSON

  def get_weather_forecast(_, params, _), do: get_weather_forecast(params)

  def get_weather_forecast(%{latitude: "", longitude: ""}), do: {:error, message: "Enter latitude and longitude"}

  def get_weather_forecast(%{latitude: "", longitude: _}), do: {:error, message: "Enter latitude"}

  def get_weather_forecast(%{latitude: _, longitude: ""}), do: {:error, message: "Enter longitude"}

  def get_weather_forecast(params) do
    appid = "1baf3dd1bb8706afd88642a76cccbe46"
    {:ok, response} = get("https://api.openweathermap.org/data/2.5/onecall?lat=#{params.latitude}&lon=#{params.longitude}&exclude=hourly,minutely&appid=#{appid}")
    get_result(response.body)
  end

  def get_result(%{"cod" => _status_code} = result) do
    {:error, message: result["message"]}
  end

  def get_result(result) do
    current_weather = result["current"]["weather"]
    daily_weather = result["daily"]
    {:ok,
      %{
        date: result["current"]["dt"],
        sunrise: result["current"]["sunrise"],
        sunset: result["current"]["sunset"],
        temperature: result["current"]["temp"],
        feelslike: result["current"]["feels_like"],
        latitude: result["lat"],
        longitude: result["lon"],
        weather: [
          %{
            main: List.first(current_weather)["main"],
            description: List.first(current_weather)["description"],
          }
        ],
        daily: get_daily_weather(daily_weather)
      }
    }
  end

  def get_daily_weather(dw) do
    dw
    |> Enum.map(fn dw -> 
      %{
        date: dw["dt"],
        pressure: dw["pressure"],
        humidity: dw["humidity"],
        temperature: %{
          day: dw["temp"]["day"],
          min: dw["temp"]["min"],
          max: dw["temp"]["max"],
          night: dw["temp"]["night"],
          evening: dw["temp"]["eve"],
          morning: dw["temp"]["morn"],
        },
        feelslike: %{
          day: dw["feels_like"]["day"],
          night: dw["feels_like"]["night"],
          evening: dw["feels_like"]["eve"],
          morning: dw["feels_like"]["morn"]
        }
      }
    end)
  end
end
