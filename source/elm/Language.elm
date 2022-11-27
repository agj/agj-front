module Language exposing (..)


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
