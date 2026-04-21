import lustre/element.{type Element}
import lustre/element/html

pub type Texts(msg) {
  Texts(
    introduction: List(Element(msg)),
    less_maintained: List(Element(msg)),
    elsewhere: List(Element(msg)),
    blog: String,
    portfolio: String,
    pictures: String,
    games: String,
    mastodon: String,
    github: String,
  )
}

pub type Language {
  English
  Spanish
  Japanese
}

pub fn for_language(language: Language) -> Texts(msg) {
  case language {
    English -> english()
    Spanish -> spanish()
    Japanese -> japanese()
  }
}

fn english() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("I'm Ale, otherwise known as "),
      html.b([], [html.text("agj")]),
      html.text("."),
      html.br([]),
      html.text("My things:"),
    ],
    less_maintained: [html.text("Under-maintained stuff:")],
    elsewhere: [html.text("Elsewhere:")],
    blog: "blog",
    portfolio: "portfolio",
    pictures: "pictures",
    games: "games",
    mastodon: "Mastodon",
    github: "Github",
  )
}

fn spanish() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("Soy Ale, o también "),
      html.b([], [html.text("agj")]),
      html.text("."),
      html.br([]),
      html.text("Mis cosas:"),
    ],
    less_maintained: [html.text("Sin mucha mantención:")],
    elsewhere: [html.text("En otros lugares:")],
    blog: "blog",
    portfolio: "portafolio",
    pictures: "imágenes",
    games: "juegos",
    mastodon: "Mastodon",
    github: "Github",
  )
}

fn japanese() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("アレです、別名 "),
      html.b([], [html.text("agj")]),
      html.text("。"),
      html.br([]),
      html.text("ここにあるのは："),
    ],
    less_maintained: [html.text("ちょっと補修不足な物：")],
    elsewhere: [html.text("ここ以外の自分：")],
    blog: "ブログ",
    portfolio: "作品集",
    pictures: "画像",
    games: "ゲーム",
    mastodon: "マストドン",
    github: "Github",
  )
}
