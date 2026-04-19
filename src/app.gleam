import css_svg
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
        #("background-image", css_svg.pattern_triangles("cyan")),
        #("background-size", "1rem"),
      ]),
    ],
    [html.text("hi")],
  )
}
