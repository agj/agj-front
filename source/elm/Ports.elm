port module Ports exposing (Msg(..), requestState, saveState, subscription)

import Json.Decode as Decode exposing (Value)
import Json.Encode as Encode
import Result.Extra as Result
import SaveState exposing (SaveState)



-- INPUT


type Msg
    = SaveStateLoaded SaveState
    | Invalid (Maybe JsMessage)


subscription : (Msg -> msg) -> Sub msg
subscription toMsg =
    portFromJs (parse >> toMsg)



-- OUTPUT


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
        , value = Encode.null
        }



-- INTERNAL


jsMessageToMsg : JsMessage -> Result Decode.Error Msg
jsMessageToMsg ({ kind, value } as jsMessage) =
    case kind of
        "saveStateLoaded" ->
            Decode.decodeValue SaveState.decoder value
                |> Result.map SaveStateLoaded

        _ ->
            Result.Ok (Invalid (Just jsMessage))


type alias JsMessage =
    { kind : String
    , value : Value
    }


port portToJs : JsMessage -> Cmd msg


port portFromJs : (Value -> msg) -> Sub msg


parse : Value -> Msg
parse raw =
    let
        jsMessageM =
            Decode.decodeValue jsMessageDecoder raw
                |> Result.toMaybe
    in
    case jsMessageM of
        Nothing ->
            Invalid jsMessageM

        Just jsMessage ->
            jsMessageToMsg jsMessage
                |> Result.mapError (always (Invalid jsMessageM))
                |> Result.merge


jsMessageDecoder : Decode.Decoder JsMessage
jsMessageDecoder =
    Decode.map2 JsMessage
        (Decode.field "kind" Decode.string)
        (Decode.field "value" Decode.value)
