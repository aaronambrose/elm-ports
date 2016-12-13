port module Main.Ports exposing (..)

import Pages.Details.Models exposing (Post)


port initChart : ( String, List Post ) -> Cmd msg


port removeChart : String -> Cmd msg
