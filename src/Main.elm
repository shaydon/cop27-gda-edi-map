module Main exposing (main)

import Browser
import Browser.Events as Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (attribute, css, id, src)
import InteropPorts
import Json.Decode as JD
import WindowSize exposing (WindowSize)


baseMapUrl : String
baseMapUrl =
    "https://umap.openstreetmap.fr/en/map/cop27-global-day-of-action-edinburgh_828539"


fitMap : WindowSize -> String
fitMap { width } =
    baseMapUrl
        ++ "#"
        ++ (if width > 1330 then
                "16/55.9525/-3.1865"

            else if width > 740 then
                "15/55.9525/-3.1872"

            else
                "14/55.9485/-3.1871"
           )


main : Program JD.Value Model Msg
main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
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
view { windowSize } =
    iframe
        [ src (fitMap windowSize)
        , css
            [ position absolute
            , width (pct 100)
            , height (pct 100)
            , borderStyle none
            , overflow hidden
            ]
        , allow [ "fullscreen", "geolocation *" ]
        ]
        []


allow : List String -> Attribute msg
allow features =
    attribute "allow" (String.join "; " features)
