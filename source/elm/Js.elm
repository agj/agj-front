port module Js exposing (Notification(..), requestState, saveState, subscription)

import Json.Decode as D
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
        { kind = "saveState"
        , value = SaveState.encode state
        }


requestState : Cmd msg
requestState =
    portToJs
        { kind = "requestState"
        , value = E.null
        }



-- INTERNAL


type alias JsMessage =
    { kind : String
    , value : E.Value
    }


port portToJs : JsMessage -> Cmd msg


port portFromJs : (JsMessage -> msg) -> Sub msg


parse : JsMessage -> Notification
parse { kind, value } =
    case kind of
        "saveStateLoaded" ->
            case D.decodeValue SaveState.decoder value of
                Ok ss ->
                    SaveStateLoaded ss

                Err _ ->
                    Invalid

        _ ->
            Invalid
