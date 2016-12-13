module Pages.Details.Update exposing (..)

import Pages.Details.Models exposing (Model, Msg(..), fetchChartData)
import Main.Ports exposing (..)


-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetChartData ->
            ( model, fetchChartData )

        OnFetchChartData (Ok posts) ->
            ( { model | chartData = posts }, initChart ( "chart", posts ) )

        OnFetchChartData (Err _) ->
            ( model, Cmd.none )

        InitPage ->
            ( model, initChart ( "chart", model.chartData ) )

        RemoveChart ->
            ( model, removeChart "chart" )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
