module General exposing (Content, Language(..), Msg(..), intro, links, menu)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown


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


intro md =
    parseMarkdown md


menu portfolioLabel blogLabel =
    ul [ class "nav" ]
        [ li []
            [ a [ href "/portfolio/" ] [ text portfolioLabel ]
            ]
        , li []
            [ a [ href "//blog.agj.cl/" ] [ text blogLabel ]
            ]
        ]


links md =
    md
        ++ """

[piclog]: //piclog.agj.cl/
[mastodon]: https://mstdn.social/@agj
[twitter]: https://twitter.com/alegrilli
[youtube]: https://youtube.com/@agjcl
[vimeo]: https://www.vimeo.com/agj
[github]: https://github.com/agj
[games]: /games/
[greasyfork]: https://greasyfork.org/users/175009-agj
[tumblr]: https://alegrilli.tumblr.com/
"""
        |> parseMarkdown


parseMarkdown md =
    md
        |> Markdown.toHtml Nothing
        |> List.head
        |> Maybe.withDefault (p [] [])
