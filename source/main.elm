
import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
--import Html.Styled.Events exposing (..)

import Texts


-- MAIN

main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


-- MODEL

type alias Model =
    { language : Language
    }

type Language
    = English
    | Spanish
    | Japanese


init : Model
init =
    Model English


-- UPDATE

type Msg
    = SetLanguage Language

update : Msg -> Model -> Model
update msg model =
    case msg of
        SetLanguage language ->
            { model | language = language }


-- VIEW

view : Model -> Html msg
view model =
    div []
        [ text Texts.english.content
        ]
