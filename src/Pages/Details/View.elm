port module Pages.Details.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Pages.Details.Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ div [] [ text model.name ]
        , div [ id "chart" ] []
        , div [ onClick GetChartData ] [ text "get chart data" ]
        ]
