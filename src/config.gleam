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

pub fn save(config: Config) -> Effect(x) {
  effect.from(fn(_) {
    storage.local()
    |> result.try(fn(local_storage) {
      storage.set_item(local_storage, "config", to_json(config))
    })
    |> result.unwrap(Nil)
  })
}
