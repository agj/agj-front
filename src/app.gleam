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
  html.div([], [
    html.style([], global_css()),
    block(w: 17, h: 16, left: -10, top: -10, content: [
      html.p([], [
        html.text("I'm Ale, otherwise known as "),
        html.b([], [html.text("agj")]),
        html.text(". My things:"),
      ]),
      html.ul([], [
        item([
          link("blog", to: "https://blog.agj.cl/"),
        ]),
        item([
          link("portfolio", to: "https://agj.cl/portfolio/"),
        ]),
      ]),
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
    block(w: 12, h: 10, left: 0, top: 5, content: [
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

const foreground_color = "#4b4f59"

const background_color = "#f3cbe5"

const tertiary_color = "white"

// HTML UTILITIES

fn block(
  content content: List(Element(Msg)),
  w w: Int,
  h h: Int,
  left left: Int,
  top top: Int,
) -> Element(Msg) {
  html.section(
    [
      attribute.class("block"),
      attribute.styles([
        #("left", "calc(50vw + " <> { int.to_string(left) } <> "rem)"),
        #("min-height", rem(h)),
        #("top", "calc(50vh + " <> { int.to_string(top) } <> "rem)"),
        #("width", rem(w)),
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
