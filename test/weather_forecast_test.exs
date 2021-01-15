defmodule WeatherForecastTest do

  use AssignmentWeb.ConnCase
  use ExUnit.Case, async: true

  test "with valid params" do
    query = """
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
    """
    conn =
      post(
        Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
        "/graphiql",
        query
      )
    
    response = json_response(conn, 200)["data"]["weatherForecast"]
    assert response["latitude"] === 52.3667
    assert response["longitude"] === 4.8945
  end

  test "with no latitude and longitude" do
    query = """
      query {
        weatherForecast(latitude: "", longitude: "") {
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
    """
    conn =
      post(
        Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
        "/graphiql",
        query
      )
    
    response = json_response(conn, 200)["errors"]
    assert List.first(response)["message"] == "Enter latitude and longitude"
  end

  test "with no latitude but valid longitude" do
    query = """
      query {
        weatherForecast(latitude: "", longitude: "-94.037689") {
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
    """
    conn =
      post(
        Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
        "/graphiql",
        query
      )
    
    response = json_response(conn, 200)["errors"]
    assert List.first(response)["message"] == "Enter latitude"
  end

  test "with no longitude but valid latitude" do
    query = """
      query {
        weatherForecast(latitude: "33.441792", longitude: "") {
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
    """
    conn =
      post(
        Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
        "/graphiql",
        query
      )
    
    response = json_response(conn, 200)["errors"]
    assert List.first(response)["message"] == "Enter longitude"
  end

  test "with invalid latitude" do
    query = """
      query {
        weatherForecast(latitude: "invalid", longitude: "-94.037689") {
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
    """
    conn =
      post(
        Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
        "/graphiql",
        query
      )
    
    response = json_response(conn, 200)["errors"]
    assert List.first(response)["message"] == "wrong latitude"
  end

  test "with invalid longitude" do
    query = """
      query {
        weatherForecast(latitude: "33.441792", longitude: "invalid") {
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
    """
    conn =
      post(
        Plug.Conn.put_req_header(build_conn(), "content-type", "plain/text"),
        "/graphiql",
        query
      )
    
    response = json_response(conn, 200)["errors"]
    assert List.first(response)["message"] == "wrong longitude"
  end  
end