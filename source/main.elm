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
    { title = "Ale Grilli's website"
    , body =
        [ article [ class "container", lang "en" ]
            [ p []
                [ text "Hello. This is my, "
                , b [] [ text "Ale Grilli" ]
                , text " (a.k.a. "
                , b [] [ text "agj" ]
                , text "’s home on the web."
                ]
            , ul [ class "nav" ]
                [ li []
                    [ a [ href "/portfolio/" ] [ text "Portfolio" ]
                    ]
                , li []
                    [ a [ href "//blog.agj.cl/" ] [ text "Blog" ]
                    ]
                ]
            , p []
                [ text "I also have a "
                , a [ href "//piclog.agj.cl/" ] [ text "pictures log" ]
                , text ". I use "
                , a [ href "https://twitter.com/alegrilli" ] [ text "Twitter" ]
                , text " sparingly. My "
                , i [] [ text "video works" ]
                , text " are on "
                , a [ href "https://www.vimeo.com/agj" ] [ text "Vimeo" ]
                , text ". Some of my "
                , i [] [ text "code" ]
                , text " is up on "
                , a [ href "https://github.com/agj" ] [ text "Github" ]
                , text ". I have a page with "
                , text "my old games"
                , text ". "
                , a [ href "https://greasyfork.org/users/175009-agj" ] [ text "Greasy Fork" ]
                , text " houses my "
                , i [] [ text "user scripts" ]
                , text ". My "
                , a [ href "https://alegrilli.tumblr.com/" ] [ text "Tumblr" ]
                , text " has some stuff I've found around the web."
                ]
            ]
        ]
    }


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

