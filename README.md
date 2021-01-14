# Assignment

We're looking to add weather information for sales prediction and dynamic pricing.

Since we're using GraphQL as our main interface for internal communication, we
have to build a small proxy service to translate REST to GraphQL. We use Absinthe
within Elixir to build GraphQL APIs.

## Setup

- [Phoenix](https://phoenixframework.org) has been set up and is available to run the application server.\
  Ecto has been disabled, as you won't need a database for this service, but can be enabled later if needed.
- [Absinthe](https://hexdocs.pm/absinthe) is included for the GraphQL API.
- [Tesla](https://hexdocs.pm/tesla) is included for the REST API.
- [ExUnit](https://hexdocs.pm/ex_unit) is also set up with some scaffolding in place. You must fill this in with your own tests.

## Expected API

The way it should work is as follows:

- a user sends the GrapQL query to the server (Absinthe)
- the server send the request to the REST API from OpenWeatherMap (Tesla)
- the server responds to the user with the data from OpenWeatherMap in the GrapQL format 

You can go ahead and create your own API key on https://openweathermap.org/api/one-call-api (it’s free)

An example query and input can be found below. Think carefully of what type a field could be.

> Amsterdam: 52.3667° N, 4.8945° E

Endpoint: http://localhost:4000/graphiql

Input:

```json
{
    "latitude": "52.3667",
    "longitude": "4.8945"
}
```
Query:

```graphql
query {
  weatherForecast(latitude: "52.3667", longitude: "4.8945") {
    date
    sunrise,
    sunset,
    temperature,
    feelslike,
    latitude,
    longitude,
    weather {
        description,
        main
    },
    daily {
        date
        pressure
        humidity
        temperature {
            day
            min
            max
            night
            evening
            morning
        }
        feelslike {
            day
            night
            evening
            morning
        }
    }
  }
}
```
OUTPUT:

```graphql
{
    "data": {
        "weatherForecast": {
            "weather": [
                {
                    "main": "Clear",
                    "description": "clear sky"
                }
            ],
            "temperature": 275.82,
            "sunset": 1610639683,
            "sunrise": 1610610232,
            "longitude": 4.8945,
            "latitude": 52.3667,
            "feelslike": 270.77,
            "date": 1610619141,
            "daily": [
                {
                    "temperature": {
                        "night": 273.53,
                        "morning": 275.67,
                        "min": 273.53,
                        "max": 276.4,
                        "evening": 274.79,
                        "day": 275.72
                    },
                    "pressure": 1020,
                    "humidity": 78,
                    "feelslike": {
                        "night": 268.62,
                        "morning": 272.08,
                        "evening": 269.79,
                        "day": 270.73
                    },
                    "date": 1610622000
                },
                {
                    "temperature": {
                        "night": 272.69,
                        "morning": 271.83,
                        "min": 271.79,
                        "max": 275.6,
                        "evening": 274.14,
                        "day": 274.91
                    },
                    "pressure": 1028,
                    "humidity": 83,
                    "feelslike": {
                        "night": 269.45,
                        "morning": 267.36,
                        "evening": 271.16,
                        "day": 271.7
                    },
                    "date": 1610708400
                },
                {
                    "temperature": {
                        "night": 272.18,
                        "morning": 272.06,
                        "min": 272.06,
                        "max": 274.71,
                        "evening": 273.04,
                        "day": 274.01
                    },
                    "pressure": 1026,
                    "humidity": 91,
                    "feelslike": {
                        "night": 266.88,
                        "morning": 268.54,
                        "evening": 268.39,
                        "day": 269.52
                    },
                    "date": 1610794800
                },
                {
                    "temperature": {
                        "night": 275.69,
                        "morning": 271.98,
                        "min": 271.91,
                        "max": 275.97,
                        "evening": 275.97,
                        "day": 273.33
                    },
                    "pressure": 1017,
                    "humidity": 98,
                    "feelslike": {
                        "night": 271.37,
                        "morning": 267.94,
                        "evening": 272.05,
                        "day": 270.7
                    },
                    "date": 1610881200
                },
                {
                    "temperature": {
                        "night": 275.32,
                        "morning": 275.24,
                        "min": 275.24,
                        "max": 277.29,
                        "evening": 275.94,
                        "day": 277.29
                    },
                    "pressure": 1022,
                    "humidity": 95,
                    "feelslike": {
                        "night": 271.36,
                        "morning": 271.37,
                        "evening": 271.81,
                        "day": 273.21
                    },
                    "date": 1610967600
                },
                {
                    "temperature": {
                        "night": 276.02,
                        "morning": 276.33,
                        "min": 274.89,
                        "max": 276.33,
                        "evening": 275.49,
                        "day": 275.2
                    },
                    "pressure": 1011,
                    "humidity": 95,
                    "feelslike": {
                        "night": 269.42,
                        "morning": 271.15,
                        "evening": 269.16,
                        "day": 268.99
                    },
                    "date": 1611054000
                },
                {
                    "temperature": {
                        "night": 277.29,
                        "morning": 279.71,
                        "min": 277.29,
                        "max": 282.21,
                        "evening": 279.44,
                        "day": 281.84
                    },
                    "pressure": 986,
                    "humidity": 91,
                    "feelslike": {
                        "night": 272.54,
                        "morning": 272.77,
                        "evening": 275.13,
                        "day": 276.07
                    },
                    "date": 1611140400
                },
                {
                    "temperature": {
                        "night": 278.42,
                        "morning": 277.59,
                        "min": 276.1,
                        "max": 278.9,
                        "evening": 278.03,
                        "day": 278.9
                    },
                    "pressure": 999,
                    "humidity": 69,
                    "feelslike": {
                        "night": 272.12,
                        "morning": 271.04,
                        "evening": 271.77,
                        "day": 271.34
                    },
                    "date": 1611226800
                }
            ]
        }
    }
}

```
