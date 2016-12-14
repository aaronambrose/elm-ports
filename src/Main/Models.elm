module Main.Models exposing (..)

import Pages.Home as Home
import Pages.About as About
import Pages.Details.Models as Details
import Main.Types exposing (Route(..), Msg(..))
import Navigation exposing (Location)
import Main.Routing exposing (parseLocation)


-- model


type alias Model =
    { home : Home.Model
    , about : About.Model
    , details : Details.Model
    , route : Route
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location

        cmd =
            case currentRoute of
                DetailsRoute ->
                    Cmd.map DetailsMsg Details.pageInit

                _ ->
                    Cmd.none
    in
        ( initialModel currentRoute, cmd )


initialModel : Route -> Model
initialModel route =
    let
        ( homeInitModel, homeCmd ) =
            Home.init

        ( aboutInitModel, aboutCmd ) =
            About.init

        ( detailsInitModel, detailsCmd ) =
            Details.init
    in
        { home = homeInitModel
        , about = aboutInitModel
        , details = detailsInitModel
        , route = route
        }



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Details.subscriptions model.details |> Sub.map DetailsMsg
        ]



-- Window.resizes (\{ height, width } -> Resize height width)
