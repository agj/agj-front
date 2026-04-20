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
import phosphor

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
  html.div(
    [
      attribute.styles([
        #("width", rem(20)),
        #("height", rem(20)),
        #("background-color", "pink"),
      ]),
    ],
    [
      html.div([], [
        html.p([], [html.text("I'm Ale, otherwise known as agj. My things:")]),
        html.ul([], [
          html.li([], [
            link("blog", to: "https://blog.agj.cl/"),
          ]),
          html.li([], [
            link("portfolio", to: "https://agj.cl/portfolio/"),
          ]),
        ]),
        html.p([], [html.text("Un- or less-maintained:")]),
        html.ul([], [
          html.li([], [
            link("pictures", to: "https://piclog.agj.cl/"),
          ]),
          html.li([], [
            link("games", to: "https://agj.cl/games/"),
          ]),
        ]),
      ]),
      html.div([], [
        html.p([], [html.text("Elsewhere:")]),
        html.ul([], [
          html.li([], [
            icon.envelope() |> icon.view(),
            html.text(" "),
            html.text("ale☯️agj.cl"),
          ]),
          html.li([], [
            icon.mastodon() |> icon.view(),
            html.text(" "),
            link_ext("Mastodon", to: "https://mstdn.social/@agj"),
          ]),
          html.li([], [
            icon.github() |> icon.view(),
            html.text(" "),
            link_ext("Github", to: "https://github.com/agj"),
          ]),
        ]),
      ]),
      html.style([], global_css()),
    ],
  )
}

fn global_css() -> String {
  [
    #("body", [
      #("background-image", css_svg.pattern_triangles("cyan")),
    ]),
  ]
  |> css_to_string
}

// UTILITIES

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
