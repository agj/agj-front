module SaveState exposing (SaveState, decoder, encode)

import Json.Decode as Decode exposing (Decoder, Value)
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
    let
        toResult =
            Decode.decodeString
                (Decode.map SaveState
                    (Decode.field "language" Language.decoder)
                )

        resultDecoder res =
            case res of
                Ok ss ->
                    Decode.succeed ss

                Err _ ->
                    Decode.fail "error"
    in
    Decode.string
        |> Decode.andThen (toResult >> resultDecoder)
