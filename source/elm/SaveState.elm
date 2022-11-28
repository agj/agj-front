module SaveState exposing (SaveState, decoder, encode)

import Json.Decode as Decode exposing (Decoder, Value)
import Json.Decode.Extra as Decode
import Json.Encode as Encode
import Language exposing (Language)


type alias SaveState =
    { language : Language
    }


encode : SaveState -> Value
encode state =
    Encode.object
        [ ( "language", Language.encode state.language )
        ]
        |> Encode.encode 0
        |> Encode.string


decoder : Decoder SaveState
decoder =
    Decode.doubleEncoded objectDecoder



-- INTERNAL


objectDecoder : Decoder SaveState
objectDecoder =
    Decode.map SaveState
        (Decode.field "language" Language.decoder)
