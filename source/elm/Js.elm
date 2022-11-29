port module Js exposing (Notification(..), requestState, saveState, subscription)

import Json.Decode as Decode exposing (Value)
import Json.Encode as Encode
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
            , value = Encode.null
            }
        )



-- INTERNAL


type alias JsMessage =
    { kind : String
    , value : Value
    }


port portToJs : Value -> Cmd msg


port portFromJs : (Value -> msg) -> Sub msg


parse : Value -> Notification
parse value =
    Decode.decodeValue decoder value
        |> Result.withDefault Invalid


decoder : Decode.Decoder Notification
decoder =
    Decode.field "kind" Decode.string
        |> Decode.andThen
            (\kind ->
                case kind of
                    "saveStateLoaded" ->
                        Decode.field "value" SaveState.decoder
                            |> Decode.map SaveStateLoaded

                    _ ->
                        Decode.fail "Kind not recognized"
            )


encode : JsMessage -> Value
encode jsMessage =
    Encode.object
        [ ( "kind", Encode.string jsMessage.kind )
        , ( "value", jsMessage.value )
        ]
