module Pages.Details.Models exposing (..)

import Window exposing (..)
import Pages.Details.Types exposing (Model, Msg(..), Post)


initModel : Model
initModel =
    { name = "Details Page"
    , chartData = []
    , active = False
    , screen =
        { width = 0
        , height = 0
        }
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



-- TODO: if page is no longer in view then retrun Sub.none


subscriptions : Model -> Sub Msg
subscriptions model =
    -- let
    --     debug =
    --         Debug.log "Subscription: Details" model.active
    --
    --     subMsg =
    --         case model.active of
    --             False ->
    --                 Sub.none
    --
    --             True ->
    --                 Window.resizes (\{ height, width } -> Resize height width)
    -- in
    Window.resizes (\{ height, width } -> Resize height width)
