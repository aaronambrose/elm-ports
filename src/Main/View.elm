module Main.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
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


navButton : String -> String -> Html Msg
navButton route name =
    li [ onClick (ChangePage route) ] [ text name ]


pageHeader : Model -> Html Msg
pageHeader model =
    header []
        [ ul []
            [ navButton "/home" "Home"
            , navButton "/about" "About"
            , navButton "/details" "Details"
            ]
        ]


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
