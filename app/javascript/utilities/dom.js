export function ready (fn) {
  document.addEventListener('DOMContentLoaded', fn);
}

export function qS (query, node) {
  return (node || document).querySelector(query);
}

export function qSA (query, node) {
  return (node || document).querySelectorAll(query);
}
