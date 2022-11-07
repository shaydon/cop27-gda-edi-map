module IntroPopup exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Input as Input
import Html.Styled exposing (Html, fromUnstyled)


view : msg -> Html msg
view dismissIntroClicked =
    layout
        [ width fill
        , height fill
        , padding 40
        , Background.color (rgba 0.5 0.5 0.5 0.5)
        ]
        (el
            [ width (fill |> maximum 600)
            , height fill
            , padding 10
            , centerX
            , Background.color (rgb 1 1 1)
            ]
            (column [ width fill, height fill ]
                [ textColumn [ height fill ]
                    [ paragraph [] [ text "Welcome to our interactive map!" ]
                    ]
                , Input.button [ centerX ]
                    { onPress = Just dismissIntroClicked
                    , label = text "Go to map"
                    }
                ]
            )
        )
        |> fromUnstyled
