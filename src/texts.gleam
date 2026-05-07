import language.{type Language, English, Japanese, Mandarin, Spanish}
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
    language_button: String,
    language_menu: String,
  )
}

pub fn for_language(language: Language) -> Texts(msg) {
  case language {
    English -> english()
    Spanish -> spanish()
    Japanese -> japanese()
    Mandarin -> mandarin()
  }
}

fn english() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("I'm Ale, otherwise known as "),
      html.b([], [html.text("agj")]),
      html.text("."),
      html.br([]),
      html.text("Some stuff I have here:"),
    ],
    less_maintained: [html.text("Under-maintained stuff:")],
    elsewhere: [html.text("Elsewhere:")],
    blog: "blog",
    portfolio: "portfolio",
    pictures: "pictures",
    games: "games",
    mastodon: "Mastodon",
    github: "Github",
    language_button: "Change language",
    language_menu: "Language selection",
  )
}

fn spanish() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("Soy Ale, o también "),
      html.b([], [html.text("agj")]),
      html.text("."),
      html.br([]),
      html.text("Cosas que tengo aquí:"),
    ],
    less_maintained: [html.text("Sin mucha mantención:")],
    elsewhere: [html.text("En otros lugares:")],
    blog: "blog",
    portfolio: "portafolio",
    pictures: "imágenes",
    games: "juegos",
    mastodon: "Mastodon",
    github: "Github",
    language_button: "Cambiar idioma",
    language_menu: "Selección de idioma",
  )
}

fn japanese() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("アレです、別名 "),
      html.b([], [html.text("agj")]),
      html.text("。"),
      html.br([]),
      html.text("この辺に置いておいた物："),
    ],
    less_maintained: [html.text("ちょっと補修不足な物：")],
    elsewhere: [html.text("ここ以外の自分：")],
    blog: "ブログ",
    portfolio: "作品集",
    pictures: "画像",
    games: "ゲーム",
    mastodon: "マストドン",
    github: "Github",
    language_button: "言語を変更",
    language_menu: "言語リスト",
  )
}

fn mandarin() -> Texts(msg) {
  Texts(
    introduction: [
      html.text("我是 Ale，別名 "),
      html.b([], [html.text("agj")]),
      html.text("。"),
      html.br([]),
      html.text("我把一些東西放在這裡了："),
    ],
    less_maintained: [html.text("（還有我不太維修的這些）")],
    elsewhere: [html.text("別處的我：")],
    blog: "部落格",
    portfolio: "作品集",
    pictures: "圖片",
    games: "遊戲",
    mastodon: "Mastodon",
    github: "Github",
    language_button: "換語言",
    language_menu: "語言清單",
  )
}
