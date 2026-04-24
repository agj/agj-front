import { List$Empty as nil, List$NonEmpty as cons } from "./gleam.mjs";

export const languages = () => {
  const languages =
    window.navigator.languages ??
    (window.navigator.language ? [window.navigator.language] : []);

  return [...languages].reverse().reduce((acc, cur) => cons(cur, acc), nil());
};
