module Main exposing (Document, Model, init, main, subscriptions, update, view)

import Browser
import ContentEnglish exposing (..)
import ContentJapanese exposing (..)
import ContentSpanish exposing (..)
import Dict
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
    , languageButtons :
        { english : LanguageButtonStatus
        , spanish : LanguageButtonStatus
        , japanese : LanguageButtonStatus
        }
    }


type alias LanguageButtonStatus =
    { adjusted : Bool }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model English
        { english = LanguageButtonStatus False
        , spanish = LanguageButtonStatus False
        , japanese = LanguageButtonStatus False
        }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLanguage newLanguage ->
            let
                previousLanguage =
                    model.language

                setButton thisLanguage =
                    LanguageButtonStatus (buttonAdjusted thisLanguage)

                buttonAdjusted thisLanguage =
                    (thisLanguage == Spanish)
                        && ((previousLanguage == Spanish && newLanguage == Japanese)
                                || (previousLanguage == Japanese && newLanguage == Spanish)
                           )
            in
            ( Model newLanguage
                { english = setButton English
                , spanish = setButton Spanish
                , japanese = setButton Japanese
                }
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
    let
        currentLanguage =
            model.language

        buttonStatus l =
            case l of
                English ->
                    model.languageButtons.english

                Spanish ->
                    model.languageButtons.spanish

                Japanese ->
                    model.languageButtons.japanese

        isAdjusted l =
            (buttonStatus l).adjusted

        separation =
            [ Japanese, Spanish, English ]
                |> takeWhile (negate (equals language))
                |> List.filter (neither (equals currentLanguage) isAdjusted)
                |> List.map (always 1)
                |> List.foldl (+) 0
    in
    div
        [ classList
            [ ( "language language-" ++ languageName, True )
            , ( "selected", currentLanguage == language )
            , ( "adjusted", (buttonStatus language).adjusted )
            ]
        , onClick (SetLanguage language)
        , style "right" (em (separation * 7.2))
        ]
        [ text label
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
