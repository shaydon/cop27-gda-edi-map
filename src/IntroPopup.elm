module IntroPopup exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Styled exposing (Html, fromUnstyled)
import Styles exposing (..)


introText : List (Element msg)
introText =
    [ heading """
        Welcome to our interactive map for the Global Day of Action in
        Edinburgh!
        """
    , paragraph []
        [ text """November 12 will see thousands on the streets across regions
            and nations, demanding Climate Justice in solidarity with the Global
            Day of Action called by Egyptian groups at the COP27 UN climate
            talks.
            """
        ]
    , paragraph []
        [ text """Join us starting in """
        , bold """St Andrew Square """
        , text """at """
        , bold """12 noon """
        , text """ for a family-friendly march bringing to life the multiple
            crises we face. At each location along the route, groups will engage
            us in key issues and resistance: expect music, art and excitement!
            """
        ]
    , paragraph [ Font.bold ]
        [ text """Use this map before, after or during the march to find out
            more about the issues raised at each stop and actions 
            """
        , italic """you """
        , text """can take. Simply click or tap on the map pins. """
        ]
    , paragraph [ Font.bold ]
        [ italic """But please remember: """
        , text """routes and plans do change. Please be kind, look out for
             one-another and follow the advice of our friendly stewards over
             anything you see here."""
        ]
    , paragraph []
        [ text """You should also be aware that if you look at this map on your
             phone during the march it will use your mobile data.
             """
        ]
    , paragraph [ Font.alignLeft, Font.italic ]
        [ text """Please email any corrections to """
        , newTabLink [ Font.underline ]
            { url =
                "mailto:edinburghclimatecoalition.web@gmail.com?subject=\"GDA map\""
            , label = text """edinburghclimatecoalition.web@gmail.com"""
            }
        , text """ ."""
        ]
    ]


heading : String -> Element msg
heading str =
    paragraph [ Region.heading 2, Font.size headingSize, Font.bold ]
        [ text str ]


bold : String -> Element msg
bold str =
    el [ Font.bold ] (text str)


italic : String -> Element msg
italic str =
    el [ Font.italic ] (text str)


view : msg -> Html msg
view dismissIntroClicked =
    layout
        [ width fill
        , height fill
        , padding 40
        , Background.color (fromRgb255 { midGray | alpha = 0.5 })
        ]
        (el
            [ width (fill |> maximum 600)
            , height fill
            , centerX
            , clip
            , Border.rounded cornerRadius
            , Background.image "/stylised-route.jpg"
            ]
            (column
                [ width fill
                , height fill
                , padding defaultWhitespace
                , spacing defaultWhitespace
                , Background.color (fromRgb255 { white | alpha = 0.95 })
                ]
                [ textColumn
                    [ width fill
                    , height fill
                    , scrollbarY
                    , spacing paragraphSpacing
                    , Font.size bodySize
                    , Font.justify
                    ]
                    introText
                , Input.button
                    [ centerX
                    , padding defaultWhitespace
                    , Border.rounded cornerRadius
                    , Background.color (fromRgb255 lineGreen)
                    , Font.color (fromRgb255 white)
                    ]
                    { onPress = Just dismissIntroClicked
                    , label = text "Go to the map"
                    }
                ]
            )
        )
        |> fromUnstyled
