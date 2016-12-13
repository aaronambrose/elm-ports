module Main.Types exposing (..)

import Pages.Home as Home
import Pages.About as About
import Pages.Details.Models as Details
import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | Resize Int Int
    | HomeMsg Home.Msg
    | AboutMsg About.Msg
    | DetailsMsg Details.Msg
    | ChangePage String


type Route
    = NotFoundRoute
    | HomeRoute
    | AboutRoute
    | DetailsRoute
