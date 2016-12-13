module Pages.About exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Debug


-- model


type alias Model =
    { name : String
    }


initModel : Model
initModel =
    { name = "About Page"
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



-- update


type Msg
    = NoOp
    | PageLoad


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        debug =
            Debug.log "About Page" msg
    in
        case msg of
            _ ->
                ( model, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ text model.name ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
