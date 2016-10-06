port module Main exposing (..)

import Dict exposing (Dict)
import Html.App
import Html
import Imports exposing (Import)


main =
    Html.App.programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = \_ -> Html.text ""
        }



-- MODEL


type alias Model =
    { query : String
    , imports : Dict String Import
    , modules : List String
    }


type alias Flags =
    { file : String
    , query : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model flags.query (Imports.parse flags.file) [], Cmd.none )



-- UPDATE


type Msg
    = Module String


port output : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Module source ->
            ( { model | modules = source :: model.modules }, Cmd.none )



-- SUBSCRIPTIONS


port modules : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    modules Module
