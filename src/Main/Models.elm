module Main.Models exposing (..)

import Pages.Home as Home
import Pages.About as About
import Pages.Details.Types as Details
import Pages.Details.Models as DetailsModels
import Pages.Details.Update as DetailsUpdate
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
                    Cmd.batch
                        [ Cmd.map DetailsMsg DetailsUpdate.pageInit
                          -- , Cmd.map DetailsMsg DetailsUpdate.pageChange
                        ]

                _ ->
                    -- Cmd.batch [ Cmd.map DetailsMsg DetailsUpdate.pageChange ]
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
            DetailsModels.init
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
        [ DetailsModels.subscriptions model.details |> Sub.map DetailsMsg
        ]
