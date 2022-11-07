module Styles exposing
    ( Rgb255Value
    , black
    , cornerRadius
    , defaultWhitespace
    , headingSize
    , lineGreen
    , markerPurple
    , midGray
    , paragraphSpacing
    , white, bodySize
    )


defaultWhitespace : Int
defaultWhitespace =
    10


paragraphSpacing : Int
paragraphSpacing =
    round (toFloat defaultWhitespace * 2.0)


cornerRadius : Int
cornerRadius =
    5


headingSize : Int
headingSize =
    16

bodySize : Int
bodySize = 14


type alias Rgb255Value =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Float
    }


white : Rgb255Value
white =
    { red = 0xFF
    , green = 0xFF
    , blue = 0xFF
    , alpha = 1
    }


black : Rgb255Value
black =
    { red = 0x00
    , green = 0x00
    , blue = 0x00
    , alpha = 1
    }


midGray : Rgb255Value
midGray =
    { red = 0x80
    , green = 0x80
    , blue = 0x80
    , alpha = 1
    }


lineGreen : Rgb255Value
lineGreen =
    { red = 0x37
    , green = 0x93
    , blue = 0x7D
    , alpha = 1
    }


markerPurple : Rgb255Value
markerPurple =
    { red = 0x66
    , green = 0x30
    , blue = 0x8B
    , alpha = 1
    }
