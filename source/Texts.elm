module Texts exposing (LanguageText, english)


type alias LanguageText =
    { title : String
    , content : String
    }


english : LanguageText
english =
    { title = "Ale Grilli’s website"
    , content = "Hi, this is a test"
    }
