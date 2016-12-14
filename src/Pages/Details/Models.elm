module Pages.Details.Models exposing (..)

import Json.Decode as JD exposing (field)
import Http
import Window exposing (..)


type Msg
    = Resize Int Int
    | GetChartData
    | OnFetchChartData (Result Http.Error (List Post))
    | NoOp



-- model


type alias Post =
    { date : String
    , close : Float
    }


type alias Model =
    { name : String
    , chartData : List Post
    , screen :
        { width : Int
        , height : Int
        }
    }


initModel : Model
initModel =
    { name = "Details Page"
    , chartData = []
    , screen =
        { width = 0
        , height = 0
        }
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


url : String
url =
    "http://localhost:4000/chart"


pageInit : Cmd Msg
pageInit =
    Cmd.batch [ fetchChartData ]


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


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\{ height, width } -> Resize height width)
