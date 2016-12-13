port module Pages.Details.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Pages.Details.Models exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ div [] [ text model.name ]
        , div [ id "chart" ] []
        , div [ onClick RemoveChart ] [ text "remove chart" ]
        , div [ onClick GetChartData ] [ text "get chart data" ]
        ]
