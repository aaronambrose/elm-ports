module Main.Routing exposing (..)

import Navigation exposing (Location)
import Main.Types exposing (Msg(..), Route(..))
import UrlParser exposing (..)
import Main.Types exposing (Route(..))


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map HomeRoute (s "home")
        , map AboutRoute (s "about")
        , map DetailsRoute (s "details")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
