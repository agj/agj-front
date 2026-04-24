import gleam/dynamic/decode.{type Decoder}
import gleam/json
import gleam/result
import language.{type Language}
import lustre/effect.{type Effect}
import plinth/javascript/storage

pub type Config {
  Config(language: Language)
}

pub fn to_json(config: Config) -> String {
  json.object([
    #("language", language.to_string(config.language) |> json.string),
  ])
  |> json.to_string
}

pub fn from_json(json_string: String) -> Result(Config, json.DecodeError) {
  json.parse(json_string, decoder())
}

pub fn decoder() -> Decoder(Config) {
  use language <- decode.field("language", language.decoder())
  decode.success(Config(language))
}

pub fn read(to_msg: fn(Result(Config, Nil)) -> msg) -> Effect(msg) {
  use dispatch <- effect.from

  storage.local()
  |> result.try(fn(local_storage) {
    use json_string <- result.try(storage.get_item(local_storage, "config"))
    let config_result =
      from_json(json_string) |> result.map_error(fn(_) { Nil })

    dispatch(to_msg(config_result))
    |> Ok
  })
  |> result.unwrap(Nil)
}

pub fn save(config: Config) -> Effect(x) {
  use _ <- effect.from

  storage.local()
  |> result.try(fn(local_storage) {
    storage.set_item(local_storage, "config", to_json(config))
  })
  |> result.unwrap(Nil)
}
