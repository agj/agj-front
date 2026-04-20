import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import phosphor

pub opaque type Icon {
  Icon(function: PhosphorIcon)
}

type PhosphorIcon =
  fn(List(Attribute(Nil))) -> Element(Nil)

fn to_icon(icon_fn: PhosphorIcon) -> Icon {
  Icon(function: icon_fn)
}

pub fn view(icon: Icon) {
  icon.function([attribute.class("icon")])
}

pub fn envelope() {
  phosphor.envelope_regular |> to_icon
}

pub fn mastodon() {
  phosphor.mastodon_logo_fill |> to_icon
}

pub fn github() {
  phosphor.github_logo_fill |> to_icon
}
