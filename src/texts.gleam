pub type Texts {
  Texts(blog: String, portfolio: String)
}

pub type Language {
  English
  Spanish
  Japanese
}

pub fn for_language(language: Language) -> Texts {
  case language {
    English -> english()
    Spanish -> spanish()
    Japanese -> japanese()
  }
}

fn english() -> Texts {
  Texts(blog: "blog", portfolio: "portfolio")
}

fn spanish() -> Texts {
  Texts(blog: "blog", portfolio: "portafolio")
}

fn japanese() -> Texts {
  Texts(blog: "ブログ", portfolio: "作品集")
}
