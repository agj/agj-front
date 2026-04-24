import gleam/dynamic/decode.{type Decoder}
import gleam/string

pub type Language {
  English
  Spanish
  Japanese
  Mandarin
}

pub fn parse_code(code: String) -> Result(Language, Nil) {
  case string.lowercase(code) {
    "en" <> _ -> Ok(English)
    "es" <> _ -> Ok(Spanish)
    "ja" <> _ -> Ok(Japanese)
    "zh" <> _ -> Ok(Mandarin)
    _ -> Error(Nil)
  }
}

pub fn to_string(language: Language) -> String {
  case language {
    English -> "en"
    Spanish -> "es"
    Japanese -> "ja"
    Mandarin -> "zh"
  }
}

pub fn decoder() -> Decoder(Language) {
  use result <- decode.then(decode.string |> decode.map(parse_code))

  case result {
    Ok(language) -> decode.success(language)
    Error(_) -> decode.failure(English, "Language")
  }
}
