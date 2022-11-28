port module Js exposing (Notification(..), requestState, saveState, subscription)

import Json.Decode as D exposing (Value)
import Json.Encode as E
import SaveState exposing (SaveState)


type Notification
    = SaveStateLoaded SaveState
    | Invalid


subscription : (Notification -> msg) -> Sub msg
subscription toMsg =
    portFromJs (parse >> toMsg)


saveState : SaveState -> Cmd msg
saveState state =
    portToJs
        (encode
            { kind = "saveState"
            , value = SaveState.encode state
            }
        )


requestState : Cmd msg
requestState =
    portToJs
        (encode
            { kind = "requestState"
            , value = E.null
            }
        )



-- INTERNAL


type alias JsMessage =
    { kind : String
    , value : E.Value
    }


port portToJs : Value -> Cmd msg


port portFromJs : (Value -> msg) -> Sub msg


parse : Value -> Notification
parse value =
    D.decodeValue decoder value
        |> Result.withDefault Invalid


decoder : D.Decoder Notification
decoder =
    D.field "kind" D.string
        |> D.andThen
            (\kind ->
                case kind of
                    "saveStateLoaded" ->
                        D.field "value" SaveState.decoder
                            |> D.map SaveStateLoaded

                    _ ->
                        D.fail "Kind not recognized"
            )


encode : JsMessage -> Value
encode jsMessage =
    E.object
        [ ( "kind", E.string jsMessage.kind )
        , ( "value", jsMessage.value )
        ]
