module Main.Update exposing (..)

import Main.Models exposing (Model)
import Main.Routing exposing (parseLocation)
import Main.Types exposing (Msg(..), Route(..))
import Pages.Home as Home
import Pages.About as About
import Pages.Details.Update as Details
import Pages.Details.Models exposing (pageInit)
import Navigation


-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resize w h ->
            ( { model | screen = { width = w, height = h } }, Cmd.none )

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

                cmd =
                    case newRoute of
                        DetailsRoute ->
                            Cmd.map DetailsMsg pageInit

                        _ ->
                            Cmd.none
            in
                ( { model | route = newRoute }, cmd )
