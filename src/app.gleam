import css_svg
import gleam/int
import gleam/list
import gleam/string
import icon
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

type Msg =
  Nil

type Model =
  Nil

fn init(_) -> #(Model, Effect(Msg)) {
  #(Nil, effect.none())
}

fn update(_: Msg, _: Model) -> #(Model, Effect(Msg)) {
  #(Nil, effect.none())
}

// VIEW

fn view(_: Model) -> Element(Msg) {
  html.div([attribute.class("container")], [
    html.style([], global_css()),
    block(anchor: TopLeft, x: 0, y: 0, width: 18, height: 9, content: [
      html.p([], [
        html.text("I'm Ale, otherwise known as "),
        html.b([], [html.text("agj")]),
        html.text("."),
        html.br([]),
        html.text("My things:"),
      ]),
      html.ul([], [
        item([
          html.b([], [link("blog", to: "https://blog.agj.cl/")]),
        ]),
        item([
          html.b([], [link("portfolio", to: "https://agj.cl/portfolio/")]),
        ]),
      ]),
    ]),
    block(anchor: TopLeft, x: 10, y: 6, width: 17, height: 8, content: [
      html.p([], [html.text("Less maintained but still here:")]),
      html.ul([], [
        item([
          link("pictures", to: "https://piclog.agj.cl/"),
        ]),
        item([
          link("games", to: "https://agj.cl/games/"),
        ]),
      ]),
    ]),
    block(anchor: BottomRight, x: 0, y: 0, width: 11, height: 10, content: [
      html.p([], [html.text("Elsewhere:")]),
      html.ul([], [
        item([
          icon.envelope() |> icon.view(),
          html.text(" ale"),
          icon.at_sign() |> icon.view(),
          html.text("agj.cl"),
        ]),
        item([
          icon.mastodon() |> icon.view(),
          html.text(" "),
          link_ext("Mastodon", to: "https://mstdn.social/@agj"),
        ]),
        item([
          icon.github() |> icon.view(),
          html.text(" "),
          link_ext("Github", to: "https://github.com/agj"),
        ]),
      ]),
    ]),
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
    [html.div([], content)],
  )
}

fn item(content: List(Element(Msg))) -> Element(Msg) {
  html.li([], [icon.arrow_right() |> icon.view(), html.text(" "), ..content])
}

fn link(label: String, to url: String) -> Element(Msg) {
  html.a([attribute.href(url)], [html.text(label)])
}

fn link_ext(label: String, to url: String) -> Element(Msg) {
  html.a([attribute.href(url), attribute.target("_blank")], [html.text(label)])
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

fn px(n: Int) -> String {
  { int.to_string(n) } <> "px"
}

fn pct(n: Int) -> String {
  { int.to_string(n) } <> "%"
}
