import css_svg
import gleam/list
import gleam/string
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

fn view(_: Model) -> Element(Nil) {
  html.div(
    [
      attribute.styles([
        #("width", "20rem"),
        #("height", "20rem"),
        #("background-color", "pink"),
      ]),
    ],
    [
      html.text("hi"),
      html.style([], global_css()),
    ],
  )
}

fn global_css() -> String {
  [
    #(":root", [#("padding", "0"), #("height", "100%")]),
    #("body", [
      #("display", "flex"),
      #("height", "100%"),
      #("justify-content", "center"),
      #("align-items", "center"),
      #("margin", "0"),
      #("background-image", css_svg.pattern_triangles("cyan")),
      #("background-size", "1rem"),
      #("background-position", "top calc(50vh - 10rem) left calc(50vw - 10rem)"),
    ]),
  ]
  |> css_to_string
}

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
