module Main.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (class)
import Main.Models exposing (Model)
import Main.Types exposing (Msg(..), Route(..))
import Pages.Home as Home
import Pages.About as About
import Pages.Details.View as Details


-- import Navigation
-- view


view : Model -> Html Msg
view model =
    div []
        [ pageHeader model
        , div []
            [ page model ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            Html.map HomeMsg (Home.view model.home)

        AboutRoute ->
            Html.map AboutMsg (About.view model.about)

        DetailsRoute ->
            Html.map DetailsMsg (Details.view model.details)

        NotFoundRoute ->
            notFoundView


navButton : Model -> String -> String -> Route -> Html Msg
navButton model path name route =
    li [ onClick <| ChangePage path, class (routeToStyle model route) ] [ text name ]


routeToStyle : Model -> Route -> String
routeToStyle model route =
    if model.route == route then
        "button selected"
    else
        "button"


pageHeader : Model -> Html Msg
pageHeader model =
    header []
        [ ul []
            [ navButton model "/home" "Home" HomeRoute
            , navButton model "/about" "About" AboutRoute
            , navButton model "/details" "Details" DetailsRoute
            ]
        ]


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
