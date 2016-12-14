module Main.Update exposing (..)

import Main.Models exposing (Model)
import Main.Routing exposing (parseLocation)
import Main.Types exposing (Msg(..), Route(..))
import Main.Ports exposing (..)
import Pages.Home as Home
import Pages.About as About
import Pages.Details.Update as Details
import Pages.Details.Types as DetailsTypes
import Navigation
import Debug


-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        debug =
            Debug.log "DetailsTypes" DetailsTypes.Reset
    in
        case msg of
            ChangePage page ->
                ( model, Navigation.newUrl page )

            HomeMsg msg ->
                let
                    ( homeModel, cmd ) =
                        Home.update msg model.home
                in
                    ( { model | home = homeModel }
                    , Cmd.map HomeMsg cmd
                    )

            AboutMsg msg ->
                let
                    ( aboutModel, cmd ) =
                        About.update msg model.about
                in
                    ( { model | about = aboutModel }
                    , Cmd.map AboutMsg cmd
                    )

            DetailsMsg msg ->
                let
                    ( detailsModel, cmd ) =
                        Details.update msg model.details
                in
                    ( { model | details = detailsModel }
                    , Cmd.map DetailsMsg cmd
                    )

            OnLocationChange location ->
                let
                    newRoute =
                        parseLocation location

                    debug =
                        Debug.log "OnLocationChange" newRoute

                    cmd =
                        case newRoute of
                            DetailsRoute ->
                                Cmd.batch
                                    [ Cmd.map DetailsMsg Details.pageInit
                                      -- , Cmd.map DetailsMsg Details.pageChange DetailsTypes.Resetmodel.details
                                    ]

                            _ ->
                                Cmd.batch
                                    [ pageChangePort ()
                                      -- , Cmd.map DetailsMsg Details.pageChange
                                    ]
                in
                    ( { model | route = newRoute }, cmd )
