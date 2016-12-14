module Pages.Details.Update exposing (..)

import Pages.Details.Types exposing (Model, Msg(..), Post)
import Main.Ports exposing (..)
import Json.Decode as JD exposing (field)
import Http
import Debug


-- import Main.Types exposing (Route)
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

        Resize w h ->
            ( { model | screen = { width = w, height = h } }, updateChartSize "update" )

        Reset ->
            ( { model | active = False }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


pageChange : Model -> ( Model, Cmd Msg )
pageChange model =
    let
        debug =
            Debug.log "||| pageChange" "route"
    in
        ( { model | active = True }, Cmd.none )


pageInit : Cmd Msg
pageInit =
    let
        debug =
            Debug.log "Deatils.model" "init"
    in
        Cmd.batch [ fetchChartData ]


url : String
url =
    "http://localhost:4000/chart"


fetchChartData : Cmd Msg
fetchChartData =
    Http.get url postsDecoder
        |> Http.send OnFetchChartData



-- DECODERS


postsDecoder : JD.Decoder (List Post)
postsDecoder =
    JD.list postDecoder


postDecoder : JD.Decoder Post
postDecoder =
    JD.map2 Post
        (field "date" JD.string)
        (field "close" JD.float)
