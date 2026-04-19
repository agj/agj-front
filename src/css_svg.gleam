import gleam/regexp
import gleam/uri

pub fn pattern_triangles(color) {
  "
    M 0, 0
    L 12, 0
    L 0, 12
    Z
  "
  |> path(color)
  |> in_12x12_svg
}

fn path(d, fill_color) {
  let assert Ok(spaces) = regexp.from_string("\\s+")
  let simplified_d = regexp.replace(each: spaces, in: d, with: "")
  "<path fill=\"" <> fill_color <> "\" d=\"" <> simplified_d <> "\" />"
}

fn in_12x12_svg(nodes) {
  {
    "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 12 12\">"
    <> nodes
    <> "</svg>"
  }
  |> wrap
}

fn wrap(svg) {
  let data = uri.percent_encode(svg)
  "url('data:image/svg+xml," <> data <> "')"
}
