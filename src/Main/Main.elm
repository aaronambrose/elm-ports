port module Main.Main exposing (..)

import Main.Models exposing (Model, subscriptions, init)
import Main.Types exposing (Msg(..), Route)
import Main.Update exposing (update)
import Main.View exposing (view)
import Navigation


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
