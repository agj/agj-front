module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MAIN

main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL

type alias Model =
    { language : Language
    }

type Language
    = English
    | Spanish
    | Japanese


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model English, Cmd.none )


type Msg
    = SetLanguage Language

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetLanguage language ->
            ({ model | language = language }, Cmd.none)


-- VIEW

type alias Document msg =
    { title : String
    , body : List (Html msg)
    }

view : Model -> Document Msg
view model =
    let
        content =
            case model.language of
                English -> contentEnglish
                Spanish -> contentSpanish
                Japanese -> contentJapanese
    in
        { title = content.title
        , body =
            [ article [ class "container", lang "en" ]
                [ nav [ class "language-selection" ]
                    [ if model.language /= English
                      then div [ class "language language-english", onClick (SetLanguage English) ]
                            [ text "in English"
                            ]
                      else text ""
                    , if model.language /= Spanish
                      then div [ class "language language-spanish", onClick (SetLanguage Spanish) ]
                        [ text "en español"
                        ]
                      else text ""
                    , if model.language /= Japanese
                      then div [ class "language language-japanese", onClick (SetLanguage Japanese) ]
                        [ text "日本語で"
                        ]
                      else text ""
                    ]
                , content.intro
                , content.menu
                , content.links
                ]
            ]
        }


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- CONTENT

type alias Content =
    { title : String
    , intro : Html Msg
    , menu : Html Msg
    , links : Html Msg
    }


contentEnglish : Content
contentEnglish =
    { title = "Ale Grilli’s website"
    , intro = intro
        "Hello. This is my, "
        "Ale Grilli"
        " (a.k.a. "
        "agj"
        ")’s home on the web. I’m a Chile-based «cross-media creator»—I program interactive media, design visuals, author videos, and more. I'm also a languages nerd. You may contact me via "
        "ale¶agj.cl"
        " (¶→@)."
    , menu = menu "Portfolio" "Blog"
    , links = links
        "I also have a "
        "pictures log"
        ". I use "
        "Twitter"
        " sparingly. My "
        "video works"
        " are on "
        "Vimeo"
        ". Some of my "
        "code"
        " is up on "
        "Github"
        ". I have a page with "
        "my old games"
        ". "
        "Greasy Fork"
        " houses my "
        "user scripts"
        ". My "
        "Tumblr"
        " has some stuff I've found around the web."
    }

contentSpanish : Content
contentSpanish =
    { title = "Web de Ale Grilli"
    , intro = intro
        "Hola. Este es el sitio web de "
        "Ale Grilli"
        " (también conocido como "
        "agj"
        "). Soy un «creador transmedial» asentado en Chile—programo medios interactivos, diseño gráfica, creo videos, y otras cosas. También soy un fanático de los idiomas. Me puedes contactar por medio de "
        "ale¶agj.cl"
        " (¶→@)."
    , menu = menu "Portafolio" "Blog"
    , links = links
        "También tengo un "
        "archivo de imágenes"
        ". Uso "
        "Twitter"
        " moderadamente. Mis "
        "videos"
        " están en "
        "Vimeo"
        ". Parte de mi "
        "código"
        " está en "
        "Github"
        ". Tengo una página que alberga "
        "mis videojuegos viejos"
        ". En "
        "Greasy Fork"
        " están mis "
        "user scripts"
        ". Mi "
        "Tumblr"
        " tiene algunas cosas que he encontrado en la web."
    }

contentJapanese : Content
contentJapanese =
    { title = "アレ・グリリのWebサイト"
    , intro = intro
        "ようこそ、"
        "アレ・グリリ"
        "（Ale Grilli、別名 "
        "agj"
        "）のホームページへ。拠点をチリにした《メディア・クリエイター》です。インタラクティブ・メディアのプログラミングや、視覚デザイン、映像制作、などに手掛ける者です。さらに言えば言語オタクです。ご連絡は "
        "ale¶agj.cl"
        "（¶→@）までにお願いします。"
    , menu = menu "作品集" "ブログ"
    , links = links
        ""
        "画像ログ"
        "を持っています。"
        "Twitter"
        " でたまに呟きます。自分の"
        "映像作品"
        "が "
        "Vimeo"
        " に。"
        "コード"
        "の一部が "
        "Github"
        " 上。昔作った"
        "ゲーム"
        "の置くページもあります。"
        "Greasy Fork"
        " に時に作る"
        "ユーザースクリプト"
        "があります。"
        "Tumblr"
        " にウェブで見つかった物が飾ってあります。"
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
