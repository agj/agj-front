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
                [ languageButton model English "english"
                , languageButton model Spanish "spanish"
                , languageButton model Japanese "japanese"
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

        position =
            case language of
                English ->
                    1

                Spanish ->
                    if (exits == Japanese) || ((exits == Spanish) && (enters == Japanese)) then
                        0

                    else
                        1

                Japanese ->
                    0

        adjusted =
            (language == Spanish)
                && ((enters == English && exits == Japanese)
                        || (enters == Japanese && exits == English)
                   )
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


em : Float -> String
em amount =
    String.fromFloat amount ++ "em"


equals : a -> a -> Bool
equals a b =
    a == b


negate : (a -> Bool) -> a -> Bool
negate f value =
    not (f value)


both : (a -> Bool) -> (a -> Bool) -> a -> Bool
both f g value =
    f value && g value


neither : (a -> Bool) -> (a -> Bool) -> a -> Bool
neither f g value =
    not (f value) && not (g value)


either : (a -> Bool) -> (a -> Bool) -> a -> Bool
either f g value =
    f value || g value



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
