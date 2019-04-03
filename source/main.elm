module Main exposing (Document, Model, init, main, subscriptions, update, view)

import Browser
import ContentEnglish exposing (..)
import ContentJapanese exposing (..)
import ContentSpanish exposing (..)
import General exposing (..)
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
                [ if model.language /= English then
                    div [ class "language language-english", onClick (SetLanguage English) ]
                        [ text "in English"
                        ]

                  else
                    text ""
                , if model.language /= Spanish then
                    div [ class "language language-spanish", onClick (SetLanguage Spanish) ]
                        [ text "en español"
                        ]

                  else
                    text ""
                , if model.language /= Japanese then
                    div [ class "language language-japanese", onClick (SetLanguage Japanese) ]
                        [ text "日本語で"
                        ]

                  else
                    text ""
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
