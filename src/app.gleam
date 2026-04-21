import css_svg
import funtil.{never}
import gleam/float
import gleam/int
import gleam/list
import gleam/string
import icon
import lustre
import lustre/attribute.{type Attribute}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import texts.{type Language, type Texts, English, Japanese, Mandarin, Spanish}

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

type Msg {
  LanguageSelected(Language)
}

type Model {
  Model(language: Language, texts: Texts(Msg))
}

fn init(_) -> #(Model, Effect(Msg)) {
  #(Model(language: English, texts: texts.for_language(English)), effect.none())
}

fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    LanguageSelected(language) -> #(
      Model(language:, texts: texts.for_language(language)),
      effect.none(),
    )
  }
}

// VIEW

fn view(model: Model) -> Element(Msg) {
  html.div([attribute.class("container")], [
    html.style([], global_css()),
    block(
      anchor: TopLeft,
      x: 0,
      y: 0,
      width: 18,
      height: 9,
      attrs: [],
      content: [
        html.p([], model.texts.introduction),
        html.ul([], [
          item([
            html.b([], [link(model.texts.blog, to: "https://blog.agj.cl/")]),
          ]),
          item([
            html.b([], [
              link(model.texts.portfolio, to: "https://agj.cl/portfolio/"),
            ]),
          ]),
        ]),
      ],
    ),
    block(
      anchor: TopRight,
      x: 4,
      y: 6,
      width: 15,
      height: 8,
      attrs: [],
      content: [
        html.p([], model.texts.less_maintained),
        html.ul([], [
          item([
            link(model.texts.pictures, to: "https://piclog.agj.cl/"),
          ]),
          item([
            link(model.texts.games, to: "https://agj.cl/games/"),
          ]),
        ]),
      ],
    ),
    block(
      anchor: BottomRight,
      x: 0,
      y: 0,
      width: 11,
      height: 10,
      attrs: [],
      content: [
        html.p([], model.texts.elsewhere),
        html.ul([], [
          item([
            icon.envelope() |> icon.view() |> element.map(never),
            html.text(" ale"),
            icon.at_sign() |> icon.view() |> element.map(never),
            html.text("agj.cl"),
          ]),
          item([
            icon.mastodon() |> icon.view() |> element.map(never),
            html.text(" "),
            link_ext(model.texts.mastodon, to: "https://mstdn.social/@agj"),
          ]),
          item([
            icon.github() |> icon.view() |> element.map(never),
            html.text(" "),
            link_ext(model.texts.github, to: "https://github.com/agj"),
          ]),
        ]),
      ],
    ),
    block(
      anchor: BottomLeft,
      x: 5,
      y: 2,
      width: 7,
      height: 11,
      attrs: [attribute.styles([#("align-items", "center")])],
      content: list.flatten([
        [
          html.span([attribute.styles([#("font-size", rem_(1.5))])], [
            icon.globe() |> icon.view() |> element.map(never),
          ]),
        ],
        case model.language == English {
          False -> [msg_button("English", msg: LanguageSelected(English))]
          True -> []
        },
        case model.language == Spanish {
          False -> [msg_button("Español", msg: LanguageSelected(Spanish))]
          True -> []
        },
        case model.language == Japanese {
          False -> [msg_button("日本語", msg: LanguageSelected(Japanese))]
          True -> []
        },
        case model.language == Mandarin {
          False -> [msg_button("中文", msg: LanguageSelected(Mandarin))]
          True -> []
        },
      ]),
    ),
  ])
}

fn global_css() -> String {
  [
    #(":root", [
      #("--background-color", background_color),
      #("--background-image", css_svg.pattern_triangles(foreground_color)),
      #("--foreground-color", foreground_color),
      #("--tertiary-color", tertiary_color),
    ]),
  ]
  |> css_to_string
}

// CONSTANTS

const foreground_color = "#616878"

const background_color = "#f5d9e5"

const tertiary_color = "white"

// HTML UTILITIES

type Anchor {
  TopLeft
  TopRight
  BottomLeft
  BottomRight
}

fn block(
  attrs attrs: List(Attribute(Msg)),
  content content: List(Element(Msg)),
  anchor anchor: Anchor,
  x x: Int,
  y y: Int,
  width width: Int,
  height height: Int,
) -> Element(Msg) {
  html.section(
    [
      attribute.class("block"),
      attribute.styles([
        #("min-height", rem(height)),
        #("width", rem(width)),
        ..{
          case anchor {
            TopLeft -> [#("top", rem(y)), #("left", rem(x))]
            TopRight -> [#("top", rem(y)), #("right", rem(x))]
            BottomLeft -> [#("bottom", rem(y)), #("left", rem(x))]
            BottomRight -> [#("bottom", rem(y)), #("right", rem(x))]
          }
        }
      ]),
    ],
    [html.div(attrs, content)],
  )
}

fn item(content: List(Element(Msg))) -> Element(Msg) {
  html.li([], [
    icon.arrow_right() |> icon.view() |> element.map(never),
    html.text(" "),
    ..content
  ])
}

fn link(label: String, to url: String) -> Element(Msg) {
  html.a([attribute.href(url)], [html.text(label)])
}

fn link_ext(label: String, to url: String) -> Element(Msg) {
  html.a([attribute.href(url), attribute.target("_blank")], [html.text(label)])
}

fn msg_button(label: String, msg msg: Msg) -> Element(Msg) {
  html.button([event.on_click(msg)], [html.text(label)])
}

// CSS UTILITIES

fn css_to_string(css: List(#(String, List(#(String, String))))) -> String {
  css
  |> list.map(fn(dec) {
    let #(selector, styles) = dec
    let styles_string =
      styles
      |> list.map(fn(style) {
        let #(property, value) = style
        { property <> ": " <> value }
      })
      |> string.join(";")
    { selector <> " { " <> styles_string <> " }" }
  })
  |> string.join("\n")
}

fn rem(n: Int) -> String {
  { int.to_string(n) } <> "rem"
}

fn rem_(n: Float) -> String {
  { float.to_string(n) } <> "rem"
}
