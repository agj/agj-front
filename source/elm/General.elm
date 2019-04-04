module General exposing (Content, Language(..), Msg(..), intro, links, menu)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type Msg
    = SetLanguage Language


type Language
    = English
    | Spanish
    | Japanese



-- CONTENT


type alias Content =
    { title : String
    , intro : Html Msg
    , menu : Html Msg
    , links : Html Msg
    }


intro : String -> String -> String -> String -> String -> String -> String -> Html msg
intro l1 l2 l3 l4 l5 l6 l7 =
    p []
        [ text l1
        , b [] [ text l2 ]
        , text l3
        , b [] [ text l4 ]
        , text l5
        , i [] [ text l6 ]
        , text l7
        ]


menu : String -> String -> Html msg
menu portfolioLabel blogLabel =
    ul [ class "nav" ]
        [ li []
            [ a [ href "/portfolio/" ] [ text portfolioLabel ]
            ]
        , li []
            [ a [ href "//blog.agj.cl/" ] [ text blogLabel ]
            ]
        ]


links : String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> String -> Html msg
links l1 l2 l3 l4 l5 l6 l7 l8 l9 l10 l11 l12 l13 l14 l15 l16 l17 l18 l19 l20 l21 =
    p []
        [ text l1
        , a [ href "//piclog.agj.cl/" ] [ text l2 ]
        , text l3
        , a [ href "https://twitter.com/alegrilli" ] [ text l4 ]
        , text l5
        , i [] [ text l6 ]
        , text l7
        , a [ href "https://www.vimeo.com/agj" ] [ text l8 ]
        , text l9
        , i [] [ text l10 ]
        , text l11
        , a [ href "https://github.com/agj" ] [ text l12 ]
        , text l13
        , a [ href "/games/" ] [ text l14 ]
        , text l15
        , a [ href "https://greasyfork.org/users/175009-agj" ] [ text l16 ]
        , text l17
        , i [] [ text l18 ]
        , text l19
        , a [ href "https://alegrilli.tumblr.com/" ] [ text l20 ]
        , text l21
        ]
