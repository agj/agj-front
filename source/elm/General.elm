module General exposing
    ( Language(..)
    , Msg(..)
    )


type Msg
    = SetLanguage Language


type Language
    = English
    | Spanish
    | Japanese
