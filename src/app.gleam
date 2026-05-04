import config.{type Config}
import css_svg
import funtil.{never}
import gleam/dynamic/decode.{type Decoder}
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import icon
import js
import language.{type Language, English, Japanese, Mandarin, Spanish}
import lustre
import lustre/attribute.{type Attribute}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import plinth/browser/document
import plinth/browser/element as pelement
import plinth/browser/event as pevent
import texts

pub fn main() -> Nil {
  let app = lustre.application(init, update, view)
  let assert Ok(_) =
    lustre.start(app, "#app", Flags(language: get_environment_language()))

  Nil
}

type Flags {
  Flags(language: Language)
}

type Msg {
  GotSavedConfig(Result(Config, Nil))
  LanguageSelectionRequested(Bool)
  LanguageSelected(Language)
  ClickedOutsideLanguageSelection
  LanguageSelectionAnimationFinished(String)
}

type Model {
  Model(language: Language, language_selection_state: OpenState)
}

type OpenState {
  OpenState
  ClosingState
  ClosedState
}

fn init(flags: Flags) -> #(Model, Effect(Msg)) {
  #(
    Model(language: flags.language, language_selection_state: ClosedState),
    effect.batch([
      config.read(GotSavedConfig),
      on_click_outside(
        [language_change_block_name, language_selection_block_name]
          |> list.map(block_name_to_class)
          |> list.map(class_to_selector),
        ClickedOutsideLanguageSelection,
      ),
    ]),
  )
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    GotSavedConfig(Ok(config)) -> #(
      Model(..model, language: config.language),
      effect.none(),
    )

    GotSavedConfig(Error(Nil)) -> #(model, effect.none())

    LanguageSelectionRequested(open) -> #(
      Model(..model, language_selection_state: case open {
        True -> OpenState
        False -> ClosingState
      }),
      effect.none(),
    )

    LanguageSelected(language) -> #(
      Model(language:, language_selection_state: ClosingState),
      config.save(config.Config(language:)),
    )

    ClickedOutsideLanguageSelection -> #(
      Model(
        ..model,
        language_selection_state: case model.language_selection_state {
          OpenState | ClosingState -> ClosingState
          ClosedState -> ClosedState
        },
      ),
      effect.none(),
    )

    LanguageSelectionAnimationFinished("exit") -> #(
      Model(..model, language_selection_state: ClosedState),
      effect.none(),
    )

    LanguageSelectionAnimationFinished(_) -> #(model, effect.none())
  }
}

// VIEW

fn view(model: Model) -> Element(Msg) {
  let texts = texts.for_language(model.language)

  html.div([attribute.class("container")], [
    html.style([], global_css()),

    block("introduction", [], [
      html.p([], texts.introduction),
      html.ul([], [
        item([
          html.b([], [link(texts.blog, to: "https://blog.agj.cl/")]),
        ]),
        item([
          html.b([], [
            link(texts.portfolio, to: "https://agj.cl/portfolio/"),
          ]),
        ]),
      ]),
    ]),

    block("unmaintained", [], [
      html.p([], texts.less_maintained),
      html.ul([], [
        item([
          link(texts.pictures, to: "https://piclog.agj.cl/"),
        ]),
        item([
          link(texts.games, to: "https://agj.cl/games/"),
        ]),
      ]),
    ]),

    block("elsewhere", [], [
      html.p([], texts.elsewhere),
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
          link_ext(texts.mastodon, to: "https://mstdn.social/@agj"),
        ]),
        item([
          icon.github() |> icon.view() |> element.map(never),
          html.text(" "),
          link_ext(texts.github, to: "https://github.com/agj"),
        ]),
      ]),
    ]),

    // Language selection button.
    block("language-change", [], [
      html.button(
        [
          attribute.aria_label(texts.language_button),
          attribute.aria_haspopup("listbox"),
          attribute.aria_expanded(model.language_selection_state == OpenState),
          attribute.aria_activedescendant(language.to_id(model.language)),
          event.on_click(
            LanguageSelectionRequested(case model.language_selection_state {
              OpenState -> False
              ClosingState | ClosedState -> True
            }),
          )
            |> event.prevent_default,
        ],
        [icon.globe() |> icon.view() |> element.map(never)],
      ),
    ]),

    // Language selection menu.
    case model.language_selection_state {
      ClosedState -> element.none()

      OpenState | ClosingState ->
        block(
          "language-selection",
          [
            attribute.class(open_state_to_class(model.language_selection_state)),
            attribute.aria_label(texts.language_menu),
            attribute.role("listbox"),
            event.on(
              "animationend",
              animation_name_decoder()
                |> decode.map(LanguageSelectionAnimationFinished),
            ),
          ],
          [
            view_language_button(
              "English",
              current: model.language,
              target: English,
            ),
            view_language_button(
              "Español",
              current: model.language,
              target: Spanish,
            ),
            view_language_button(
              "日本語",
              current: model.language,
              target: Japanese,
            ),
            view_language_button(
              "中文",
              current: model.language,
              target: Mandarin,
            ),
          ],
        )
    },
  ])
}

fn view_language_button(
  label: String,
  current current: Language,
  target target: Language,
) -> Element(Msg) {
  let selected = target == current
  let check_icon = case selected {
    True -> icon.check()
    False -> icon.empty()
  }
  html.button(
    [
      attribute.id(language.to_id(target)),
      attribute.role("option"),
      attribute.aria_selected(selected),
      event.on_click(LanguageSelected(target)),
    ],
    [
      check_icon |> icon.view() |> element.map(never),
      html.text(" " <> label),
    ],
  )
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

const language_change_block_name = "language-change"

const language_selection_block_name = "language-selection"

// HTML UTILITIES

fn block(
  name: String,
  attrs: List(Attribute(Msg)),
  content: List(Element(Msg)),
) -> Element(Msg) {
  html.section(
    [attribute.class("block " <> block_name_to_class(name)), ..attrs],
    [
      html.div([], content),
    ],
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

fn open_state_to_class(state: OpenState) -> String {
  case state {
    OpenState -> ""
    ClosingState -> "exit"
    ClosedState -> ""
  }
}

fn rem(n: Int) -> String {
  int.to_string(n) <> "rem"
}

fn rem_(n: Float) -> String {
  { float.to_string(n) } <> "rem"
}

// OTHER

/// Triggers a message when a click event is triggered in the document but
/// outside of a list of elements whose DOM selectors you provide.
fn on_click_outside(selectors: List(String), msg: Msg) -> Effect(Msg) {
  use dispatch <- effect.from

  document.add_event_listener("click", fn(event) {
    let maybe_target = pevent.target(event) |> pelement.cast

    case maybe_target {
      Ok(target) -> {
        let is_outside_all_selectors =
          list.map(selectors, fn(selector) {
            pelement.query_selector(target, selector)
          })
          |> list.all(result.is_ok)

        case is_outside_all_selectors {
          True -> dispatch(msg)
          False -> Nil
        }
      }
      Error(_) -> Nil
    }
  })
}

fn block_name_to_class(name: String) -> String {
  "block-" <> name
}

fn class_to_selector(class: String) -> String {
  "." <> class
}

fn get_environment_language() -> Language {
  js.languages()
  |> list.filter_map(language.parse_code)
  |> list.first
  |> result.unwrap(English)
}

fn animation_name_decoder() -> Decoder(String) {
  decode.at(["animationName"], decode.string)
}
