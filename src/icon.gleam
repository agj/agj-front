import funtil.{type Never}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html
import phosphor

pub opaque type Icon {
  Icon(function: PhosphorIcon)
}

type PhosphorIcon =
  fn(List(Attribute(Never))) -> Element(Never)

fn to_icon(icon_fn: PhosphorIcon) -> Icon {
  Icon(function: icon_fn)
}

pub fn view(icon: Icon) -> Element(Never) {
  html.div([attribute.class("icon")], [icon.function([])])
}

// ICONS

pub fn envelope() -> Icon {
  phosphor.envelope_regular |> to_icon
}

pub fn at_sign() -> Icon {
  phosphor.at_regular |> to_icon
}

pub fn mastodon() -> Icon {
  phosphor.mastodon_logo_fill |> to_icon
}

pub fn github() -> Icon {
  phosphor.github_logo_fill |> to_icon
}

pub fn arrow_right() -> Icon {
  phosphor.arrow_right_regular |> to_icon
}

pub fn globe() -> Icon {
  phosphor.globe_regular |> to_icon
}
