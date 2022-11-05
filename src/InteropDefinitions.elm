module InteropDefinitions exposing (Flags, FromElm, ToElm, interop)

import TsJson.Decode as TsDecode exposing (Decoder)
import TsJson.Encode as TsEncode exposing (Encoder)
import WindowSize exposing (WindowSize)


type alias FromElm =
    ()


type alias ToElm =
    ()


type alias Flags =
    WindowSize


interop :
    { toElm : Decoder ToElm
    , fromElm : Encoder FromElm
    , flags : TsDecode.Decoder Flags
    }
interop =
    { toElm = TsDecode.null ()
    , fromElm = TsEncode.null
    , flags = flags
    }


flags : Decoder Flags
flags =
    TsDecode.field "windowSize"
        (TsDecode.map2 WindowSize
            (TsDecode.field "width" TsDecode.int)
            (TsDecode.field "height" TsDecode.int)
        )
