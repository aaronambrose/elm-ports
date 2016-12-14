port module Main.Ports exposing (..)

import Pages.Details.Models exposing (Post)


port initChart : ( String, List Post ) -> Cmd msg


port updateChartSize : String -> Cmd msg



-- Clear previous pages data on location change


port pageChangePort : () -> Cmd msg
