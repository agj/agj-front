module Main exposing (Document, Model, init, main, subscriptions, update, view)

import Browser
import Content
import Dict
import Html exposing (Html, article, div, nav, text)
import Html.Attributes exposing (class, classList, lang)
import Html.Events exposing (onClick)
import Language exposing (Language(..))
import List.Extra as List



-- MAIN


main : Program Flags Model Msg
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
    , previousLanguage : Language
    }


type Msg
    = SetLanguage Language


type alias Flags =
    { languages : List String }


languageCodes =
    Dict.fromList
        [ ( "en", English )
        , ( "es", Spanish )
        , ( "ja", Japanese )
        , ( "zh", Mandarin )
        ]


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        systemLanguage =
            flags.languages
                |> List.map (String.left 2)
                |> List.find (\s -> Dict.member s languageCodes)
                |> Maybe.andThen (\lc -> Dict.get lc languageCodes)
                |> Maybe.withDefault English
    in
    ( Model systemLanguage systemLanguage, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLanguage newLanguage ->
            ( if newLanguage /= model.language then
                Model newLanguage model.language

              else
                model
            , Cmd.none
            )



-- VIEW


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }


view : Model -> Document Msg
view model =
    let
        content =
            Content.fromLanguage model.language
    in
    { title = content.title
    , body =
        [ article [ class "container", lang "en" ]
            [ nav [ class "language-selection" ]
                [ languageButton model Spanish "spanish"
                , languageButton model English "english"
                , languageButton model Japanese "japanese"
                , languageButton model Mandarin "mandarin"
                ]
            , content.intro
            , content.menu
            , content.links
            ]
        ]
    }


languageButton : Model -> Language -> String -> Html Msg
languageButton model language languageName =
    let
        exits =
            model.language

        enters =
            model.previousLanguage

        -- As indices starting from the right.
        -- Assumes this order: es, en, ja, zh.
        ( previousPosition, position ) =
            case language of
                Spanish ->
                    ( 2, 2 )

                English ->
                    case ( enters, exits ) of
                        ( Spanish, English ) ->
                            ( 2, 2 )

                        ( English, Spanish ) ->
                            ( 2, 2 )

                        ( Spanish, _ ) ->
                            ( 2, 1 )

                        ( English, _ ) ->
                            ( 1, 1 )

                        ( _, Spanish ) ->
                            ( 1, 2 )

                        ( _, _ ) ->
                            ( 1, 1 )

                Japanese ->
                    case ( enters, exits ) of
                        ( Japanese, Mandarin ) ->
                            ( 0, 0 )

                        ( Mandarin, Japanese ) ->
                            ( 0, 0 )

                        ( _, Mandarin ) ->
                            ( 1, 0 )

                        ( Mandarin, _ ) ->
                            ( 0, 1 )

                        ( _, _ ) ->
                            ( 1, 1 )

                Mandarin ->
                    ( 0, 0 )

        adjusted =
            position /= previousPosition
    in
    div
        [ classList
            [ ( "language", True )
            , ( "language-" ++ languageName, True )
            , ( "selected", model.language == language )
            , ( "adjusted", adjusted )
            , ( "position-" ++ String.fromInt position, True )
            ]
        , onClick (SetLanguage language)
        ]
        [ text ""
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
