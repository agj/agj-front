module Content exposing
    ( english
    , fromLanguage
    , japanese
    , spanish
    )

import Html exposing (Html, a, li, p, text, ul)
import Html.Attributes exposing (class, href)
import Language exposing (Language(..))
import Markdown


type alias Content msg =
    { title : String
    , intro : Html msg
    , menu : Html msg
    , links : Html msg
    }


fromLanguage : Language -> Content msg
fromLanguage language =
    case language of
        English ->
            english

        Spanish ->
            spanish

        Japanese ->
            japanese



-- CONTENT


japanese : Content msg
japanese =
    { title = "アレ・グリリのウェブ"
    , intro =
        intro
            ("ようこそ、**アレ・グリリ**（Ale Grilli、別名 **agj**）のホームページへ。"
                ++ "チリを拠点にする「メディア・クリエイター」です。"
                ++ "インタラクティブ・メディアのプログラミングや、視覚デザイン、映像制作などに手掛ける者です。"
                ++ "さらに言えば言語オタクです。"
                ++ "ご連絡は “ale¶agj.cl”（¶→@）までお願いします。"
            )
    , menu = menu "作品集" "ブログ"
    , links =
        links
            ("他に、[**画像ログ**][piclog]を持っています。"
                ++ "SNSなら[マストドン][mastodon]と[ツイッター][twitter]を滅多にしかやりません。"
                ++ "手掛けた**映像作品**が [Vimeo][vimeo]、[Youtube][youtube] に。"
                ++ "書いた**コード**の一部は [Github][github] 上に。"
                ++ "昔作った[**ゲーム**][games]が置いてあるページもあります。"
                ++ "[Greasy Fork][greasyfork] にたまに作るブラウザー用**ユーザースクリプト**があります。"
                ++ "ウェブでの拾い物は [Tumblr][tumblr] に。"
            )
    }


english : Content msg
english =
    { title = "Ale Grilli’s website"
    , intro =
        intro
            ("Hello. This is my, **Ale Grilli** (a.k.a. **agj**)’s home on the web. "
                ++ "I’m a Chile-based «cross-media creator»\u{200B}—\u{200B}"
                ++ "I program interactive media, design visuals, author videos, and more. "
                ++ "I'm also a languages nerd. You may contact me via “ale¶agj.cl” (¶→@)."
            )
    , menu = menu "Portfolio" "Blog"
    , links =
        links
            ("I also have a [**pictures log**][piclog]. "
                ++ "Socials-wise, I barely use [Mastodon][mastodon] and [Twitter][twitter]. "
                ++ "My **video works** are on [Vimeo][vimeo] and [Youtube][youtube]. "
                ++ "Some of my **code** is up on [Github][github]. "
                ++ "I have a page with [my old **games**][games] in it. "
                ++ "[Greasy Fork][greasyfork] houses my **userscripts**. "
                ++ "My [Tumblr][tumblr] has some stuff I've found around the web."
            )
    }


spanish : Content msg
spanish =
    { title = "Web de Ale Grilli"
    , intro =
        intro
            ("Hola. Este es el sitio web de **Ale Grilli** (a veces **agj**). "
                ++ "Soy un «creador transmedial»\u{200B}—\u{200B}"
                ++ "desde Chile programo medios interactivos, diseño gráfica, creo videos, y otras cosas. "
                ++ "Me gustan mucho los idiomas. "
                ++ "Me puedes contactar por medio de “ale¶agj.cl” (¶→@)."
            )
    , menu = menu "Portafolio" "Blog"
    , links =
        links
            ("También tengo un [**archivo de imágenes**][piclog]. "
                ++ "Respecto a redes sociales, apenas uso [Mastodon][mastodon] y [Twitter][twitter]. "
                ++ "Mis **videos** están en [Vimeo][vimeo] y [Youtube][youtube]. "
                ++ "Parte de mi **código** está en [Github][github]. "
                ++ "Una página alberga [mis **videojuegos** viejos][games]. "
                ++ "En [Greasy Fork][greasyfork] están mis **userscripts**. "
                ++ "En mi [Tumblr][tumblr] tengo cosas raras de la web."
            )
    }



-- INTERNAL


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
