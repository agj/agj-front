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
