module Main exposing (main)

import Browser
import Browser.Events as Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (attribute, css, src, tabindex)
import InteropPorts
import IntroPopup
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
    { windowSize : WindowSize
    , showIntro : Bool
    }


init : JD.Value -> ( Model, Cmd Msg )
init flags =
    ( { windowSize =
            case InteropPorts.decodeFlags flags of
                Err _ ->
                    { width = 640, height = 480 }

                Ok windowSize ->
                    windowSize
      , showIntro = True
      }
    , Cmd.none
    )


type Msg
    = WindowResized WindowSize
    | DismissIntroClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        WindowResized windowSize ->
            { model | windowSize = windowSize }

        DismissIntroClicked ->
            { model | showIntro = False }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.onResize
        (\width height -> WindowResized { width = width, height = height })


view : Model -> Html Msg
view { windowSize, showIntro } =
    div []
        (iframe
            [ src (fitMap windowSize)
            , css
                [ fillWindow
                , borderStyle none
                , overflow hidden
                , if showIntro then
                    pointerEvents none

                  else
                    pointerEvents auto
                ]
            , tabindex
                (if showIntro then
                    -1

                 else
                    0
                )
            , allow [ "fullscreen", "geolocation *" ]
            ]
            []
            :: (if showIntro then
                    [ div [ css [ fillWindow ] ]
                        [ IntroPopup.view DismissIntroClicked ]
                    ]

                else
                    []
               )
        )


fillWindow : Style
fillWindow =
    Css.batch
        [ position absolute
        , width (pct 100)
        , height (pct 100)
        ]


allow : List String -> Attribute msg
allow features =
    attribute "allow" (String.join "; " features)
