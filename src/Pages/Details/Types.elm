module Pages.Details.Types exposing (..)

import Http


-- Message Types


type Msg
    = Resize Int Int
    | GetChartData
    | OnFetchChartData (Result Http.Error (List Post))
    | Reset
    | NoOp



-- Model Types


type alias Post =
    { date : String
    , close : Float
    }


type alias Model =
    { name : String
    , chartData : List Post
    , active : Bool
    , screen :
        { width : Int
        , height : Int
        }
    }
