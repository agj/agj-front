module Main exposing (Document, Model, init, main, subscriptions, update, view)

import Browser
import Content
import Html exposing (Html, article, button, nav, text)
import Html.Attributes exposing (attribute, class, classList, disabled, lang)
import Html.Events exposing (onClick)
import Language exposing (Language(..))
import List.Extra as List
import Ports



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
    | JsNotification Ports.Msg


type alias Flags =
    { languages : List String }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        systemLanguage =
            flags.languages
                |> List.map (String.left 2)
                |> List.filterMap Language.fromIsoCode
                |> List.head
                |> Maybe.withDefault English
    in
    ( Model systemLanguage systemLanguage, Ports.requestState )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLanguage newLanguage ->
            ( if newLanguage /= model.language then
                Model newLanguage model.language

              else
                model
            , Ports.saveState { language = newLanguage }
            )

        JsNotification (Ports.SaveStateLoaded state) ->
            ( { model | language = state.language }
            , Cmd.none
            )

        JsNotification (Ports.Invalid _) ->
            ( model, Cmd.none )



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

        navElement =
            nav [ class "language-selection" ]
                (Language.all
                    |> List.map
                        (\language ->
                            languageButton model language (Language.toName language)
                        )
                )
    in
    { title = content.title
    , body =
        [ article
            [ class "container"
            , lang (Language.toIsoCode model.language)
            ]
            (navElement
                :: content.intro
                ++ [ content.menu ]
                ++ content.links
            )
        ]
    }


languageButton : Model -> Language -> String -> Html Msg
languageButton model language languageName =
    let
        ( position, previousPosition ) =
            let
                posM =
                    List.remove model.language Language.all
                        |> List.elemIndex language

                prevPosM =
                    List.remove model.previousLanguage Language.all
                        |> List.elemIndex language
            in
            case ( posM, prevPosM ) of
                ( Just pos, Just prevPos ) ->
                    ( pos, prevPos )

                ( Just pos, Nothing ) ->
                    ( pos, pos )

                ( Nothing, Just prevPos ) ->
                    ( prevPos, prevPos )

                ( Nothing, Nothing ) ->
                    ( 0, 0 )

        selected =
            model.language == language
    in
    button
        [ classList
            [ ( "language", True )
            , ( "language-" ++ languageName, True )
            , ( "selected", selected )
            , ( "adjusted", position /= previousPosition )
            , ( "position-" ++ String.fromInt position, True )
            ]
        , onClick (SetLanguage language)
        , attribute "aria-hidden"
            (if selected then
                "true"

             else
                "false"
            )
        , disabled selected
        ]
        [ text ""
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.subscription JsNotification
