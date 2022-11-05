module Main exposing (main)

import Browser
import Browser.Events as Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import InteropPorts
import Json.Decode as JD
import WindowSize exposing (WindowSize)


main : Program JD.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { windowSize : WindowSize }


init : JD.Value -> ( Model, Cmd Msg )
init flags =
    case InteropPorts.decodeFlags flags of
        Err _ ->
            ( { windowSize = { width = 640, height = 480 } }, Cmd.none )

        Ok windowSize ->
            ( { windowSize = windowSize }
            , Cmd.none
            )


type Msg
    = WindowResized WindowSize


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowResized windowSize ->
            ( { model | windowSize = windowSize }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.onResize
        (\width height -> WindowResized { width = width, height = height })


view : Model -> Html Msg
view _ =
    iframe
        [ id "map-frame"
        , src
            "https://umap.openstreetmap.fr/en/map/cop27-global-day-of-action-edinburgh_828539"
        , allow [ "fullscreen", "geolocation *"]
        ]
        []

allow : List String -> Attribute msg
allow features = attribute "allow" (String.join "; " features)
