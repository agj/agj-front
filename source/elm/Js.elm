port module Js exposing (Notification(..), receive, requestState, saveState)

import Json.Decode as D
import Json.Encode as E
import SaveState exposing (SaveState)


type Notification
    = SaveStateLoaded SaveState
    | Invalid


receive : (Notification -> msg) -> Sub msg
receive toMsg =
    notification (parse >> toMsg)


saveState : SaveState -> Cmd msg
saveState state =
    command
        { kind = "saveState"
        , value = SaveState.encode state
        }


requestState : Cmd msg
requestState =
    command
        { kind = "requestState"
        , value = E.null
        }



-- INTERNAL


type alias ToJs =
    { kind : String
    , value : E.Value
    }


type alias FromJs =
    { kind : String
    , value : E.Value
    }


port command : ToJs -> Cmd msg


port notification : (FromJs -> msg) -> Sub msg


parse : FromJs -> Notification
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
