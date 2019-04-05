module Main exposing (Document, Model, init, main, subscriptions, update, view)

import Browser
import ContentEnglish exposing (..)
import ContentJapanese exposing (..)
import ContentSpanish exposing (..)
import General exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List.Extra exposing (..)



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


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model English, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLanguage language ->
            ( { model | language = language }, Cmd.none )



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
                English ->
                    contentEnglish

                Spanish ->
                    contentSpanish

                Japanese ->
                    contentJapanese
    in
    { title = content.title
    , body =
        [ article [ class "container", lang "en" ]
            [ nav [ class "language-selection" ]
                [ languageButton model English "english" "in English"
                , languageButton model Spanish "spanish" "en español"
                , languageButton model Japanese "japanese" "日本語で"
                ]
            , content.intro
            , content.menu
            , content.links
            ]
        ]
    }


languageButton : Model -> Language -> String -> String -> Html Msg
languageButton model language languageName label =
    div
        [ classList
            [ ( "language language-" ++ languageName, True )
            , ( "selected", model.language == language )
            ]
        , onClick (SetLanguage language)
        , style "right" (em (separation model language * 7.2))
        ]
        [ text label
        ]


em : Float -> String
em amount =
    String.fromFloat amount ++ "em"


separation model language =
    let
        languages =
            [ Japanese, Spanish, English ]

        counted =
            takeWhile (\l -> l /= language) languages

        bump =
            List.map (\l -> l /= model.language) counted

        bumpAmounts =
            List.map
                (\v ->
                    if v then
                        1

                    else
                        0
                )
                bump
    in
    List.foldl (+) 0 bumpAmounts



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
