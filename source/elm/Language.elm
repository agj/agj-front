module Language exposing (..)

import Json.Decode exposing (Decoder)
import Json.Encode exposing (Value)


type Language
    = English
    | Spanish
    | Japanese
    | Mandarin


{-| Order is menu position from right to left.
-}
all : List Language
all =
    [ Mandarin
    , Japanese
    , English
    , Spanish
    ]


toName : Language -> String
toName language =
    case language of
        Spanish ->
            "spanish"

        English ->
            "english"

        Japanese ->
            "japanese"

        Mandarin ->
            "mandarin"


toIsoCode : Language -> String
toIsoCode language =
    case language of
        Spanish ->
            "es"

        English ->
            "en"

        Japanese ->
            "ja"

        Mandarin ->
            "zh"


fromIsoCode : String -> Maybe Language
fromIsoCode isoCode =
    case isoCode of
        "en" ->
            Just English

        "es" ->
            Just Spanish

        "ja" ->
            Just Japanese

        "zh" ->
            Just Mandarin

        _ ->
            Nothing


encode : Language -> Value
encode language =
    toIsoCode language
        |> Json.Encode.string


decoder : Decoder Language
decoder =
    Json.Decode.string
        |> Json.Decode.andThen
            (\string ->
                case fromIsoCode string of
                    Just language ->
                        Json.Decode.succeed language

                    Nothing ->
                        Json.Decode.fail "Language not recognized"
            )
