module Content exposing
    ( english
    , fromLanguage
    , japanese
    , spanish
    )

import Basics.Extra as Basics
import Dict exposing (Dict)
import Html exposing (Html, a, li, p, text, ul)
import Html.Attributes exposing (class, href)
import Language exposing (Language(..))
import List.Extra as List
import Mark
import Mark.Error
import Markdown


type alias Content msg =
    { title : String
    , intro : List (Html msg)
    , menu : Html msg
    , links : List (Html msg)
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

        Mandarin ->
            mandarin



-- CONTENT


mandarin : Content msg
mandarin =
    { title = "艾磊（Ale Grilli）的個人網站"
    , intro =
        ("歡迎來到*艾磊*（Ale Grilli，*agj*）的網站。"
            ++ "我是住在智利的「跨媒體創作人」。"
            ++ "我會從事互動式媒體程式設計、視覺設計、影片拍攝等。"
            ++ "我對語言非常狂熱。"
            ++ "你想聯絡我的話，請把信寄到“ale¶agj.cl”（¶→@）。"
        )
            |> intro
    , menu = menu "作品集" "部落格"
    , links =
        ("此外，我還有[*圖像日記*]{link| tag=piclog}。"
            ++ "社交媒體裡面，雖然不常，我有時候會用 [Mastodon]{link| tag=mastodon}。"
            ++ "我把做的*影片*放在 [Vimeo]{link| tag=vimeo} 或 [Youtube]{link| tag=youtube} 上。"
            ++ "我一部分*程式碼*在 [Github]{link| tag=github} 上。"
            ++ "在這邊你可以找到我很久以前做過的[*遊戲*]{link| tag=games}。"
            ++ "我寫過的*使用者腳本*都在 [Greasy Fork]{link| tag=greasyfork} 裡面。"
            ++ "曾經在網路上找到的一些東西還在我目前不理的 [Tumblr]{link| tag=tumblr} 裡。"
        )
            |> links
    }


japanese : Content msg
japanese =
    { title = "アレ・グリリのウェブ"
    , intro =
        ("ようこそ、*アレ・グリリ*（Ale Grilli、別名 *agj*）のホームページへ。"
            ++ "チリを拠点にする「メディア・クリエイター」です。"
            ++ "インタラクティブ・メディアのプログラミングや、視覚デザイン、映像制作などに手掛ける者です。"
            ++ "さらに言えば言語オタクです。"
            ++ "ご連絡は “ale¶agj.cl”（¶→@）までお願いします。"
        )
            |> intro
    , menu = menu "作品集" "ブログ"
    , links =
        ("他に、[*画像ログ*]{link| tag=piclog}を持っています。"
            ++ "SNSなら、[マストドン]{link| tag=mastodon}にたまに現れます。"
            ++ "手掛けた*映像作品*が [Vimeo]{link| tag=vimeo}、[Youtube]{link| tag=youtube} に。"
            ++ "書いた*コード*の一部は [Github]{link| tag=github} 上に。"
            ++ "昔作った[*ゲーム*]{link| tag=games}が置いてあるページもあります。"
            ++ "[Greasy Fork]{link| tag=greasyfork} にたまに作るブラウザー用*ユーザースクリプト*があります。"
            ++ "ウェブでの拾い物は [Tumblr]{link| tag=tumblr} に。"
        )
            |> links
    }


english : Content msg
english =
    { title = "Ale Grilli’s website"
    , intro =
        ("Hello. This is my, *Ale Grilli* (a.k.a. *agj*)’s home on the web. "
            ++ "I’m a Chile-based «cross-media creator»\u{200B}—\u{200B}"
            ++ "I program interactive media, design visuals, author videos, and more. "
            ++ "I'm also a languages nerd. You may contact me via “ale¶agj.cl” (¶→@)."
        )
            |> intro
    , menu = menu "Portfolio" "Blog"
    , links =
        ("I also have a [*pictures log*]{link| tag=piclog}. "
            ++ "Socials-wise, I use [Mastodon]{link| tag=mastodon}, although barely. "
            ++ "My *video works* are on [Vimeo]{link| tag=vimeo} and [Youtube]{link| tag=youtube}. "
            ++ "Some of my *code* is up on [Github]{link| tag=github}. "
            ++ "I have a page with [my old *games*]{link| tag=games} in it. "
            ++ "[Greasy Fork]{link| tag=greasyfork} houses my *userscripts*. "
            ++ "My [Tumblr]{link| tag=tumblr} has some stuff I've found around the web."
        )
            |> links
    }


spanish : Content msg
spanish =
    { title = "Web de Ale Grilli"
    , intro =
        ("Hola. Este es el sitio web de *Ale Grilli* (a veces *agj*). "
            ++ "Soy un «creador transmedial»\u{200B}—\u{200B}"
            ++ "desde Chile programo medios interactivos, diseño gráfica, creo videos, y otras cosas. "
            ++ "Me gustan mucho los idiomas. "
            ++ "Me puedes contactar por medio de “ale¶agj.cl” (¶→@)."
        )
            |> intro
    , menu = menu "Portafolio" "Blog"
    , links =
        ("También tengo un [*archivo de imágenes*]{link| tag=piclog}. "
            ++ "En cuanto a redes sociales, uso [Mastodon]{link| tag=mastodon}, a veces. "
            ++ "Mis *videos* están en [Vimeo]{link| tag=vimeo} y [Youtube]{link| tag=youtube}. "
            ++ "Parte de mi *código* está en [Github]{link| tag=github}. "
            ++ "Una página alberga [mis *videojuegos* viejos]{link| tag=games}. "
            ++ "En [Greasy Fork]{link| tag=greasyfork} están mis *userscripts*. "
            ++ "En mi [Tumblr]{link| tag=tumblr} tengo cosas raras de la web."
        )
            |> links
    }



-- INTERNAL


linkUrlsByTag : Dict String String
linkUrlsByTag =
    [ ( "piclog", "//piclog.agj.cl/" )
    , ( "mastodon", "https://mstdn.social/@agj" )
    , ( "youtube", "https://youtube.com/@agjcl" )
    , ( "vimeo", "https://www.vimeo.com/agj" )
    , ( "github", "https://github.com/agj" )
    , ( "games", "/games/" )
    , ( "greasyfork", "https://greasyfork.org/users/175009-agj" )
    , ( "tumblr", "https://alegrilli.tumblr.com/" )
    ]
        |> Dict.fromList


linkAttributesByTag : Dict String (List (Html.Attribute msg))
linkAttributesByTag =
    [ ( "mastodon", [ Html.Attributes.rel "me" ] ) ]
        |> Dict.fromList


intro : String -> List (Html msg)
intro raw =
    parseEmu raw


menu portfolioLabel blogLabel =
    ul [ class "nav" ]
        [ li []
            [ a [ href "/portfolio/" ] [ text portfolioLabel ]
            ]
        , li []
            [ a [ href "//blog.agj.cl/" ] [ text blogLabel ]
            ]
        ]


links : String -> List (Html msg)
links raw =
    parseEmu raw


parseEmu : String -> List (Html msg)
parseEmu raw =
    let
        withErrors : List Mark.Error.Error -> List (Html msg)
        withErrors errors =
            errors
                |> List.map
                    (Mark.Error.toString
                        >> Html.text
                        >> List.singleton
                        >> Html.p []
                    )
    in
    case Mark.compile emuDocument raw of
        Mark.Success result ->
            result

        Mark.Almost { result, errors } ->
            withErrors errors

        Mark.Failure errors ->
            withErrors errors


emuDocument : Mark.Document (List (Html msg))
emuDocument =
    Mark.manyOf
        [ Mark.map (Html.p []) inlineParser
        ]
        |> Mark.document identity


inlineParser : Mark.Block (List (Html msg))
inlineParser =
    Mark.textWith
        { view = renderInline
        , replacements = []
        , inlines =
            [ Mark.annotation "link" renderLink
                |> Mark.field "tag" Mark.string
            ]
        }


renderLink : List ( Mark.Styles, String ) -> String -> Html msg
renderLink stylesTextPairs tag =
    let
        urlM =
            Dict.get tag linkUrlsByTag

        attributes =
            Dict.get tag linkAttributesByTag
                |> Maybe.withDefault []
    in
    case urlM of
        Just url ->
            Html.a (Html.Attributes.href url :: attributes)
                (stylesTextPairs |> List.map (Basics.uncurry renderInline))

        Nothing ->
            Html.text ("[UNKNOWN_LINK_TAG:" ++ tag ++ "]")


renderInline : Mark.Styles -> String -> Html msg
renderInline styles text =
    let
        strong =
            if styles.bold then
                List.singleton >> Html.strong []

            else
                identity

        em =
            if styles.italic then
                List.singleton >> Html.em []

            else
                identity
    in
    strong (em (Html.text text))
