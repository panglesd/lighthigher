# LightHigher

A little helper that takes a "highlighting function", and an element, and use that function to syntax highlight the element, but **without losing the internal HTML structure**! (Element nodes are never removed from the DOM).

This allows you to add links, listen to events, ... in your `<code>` elements while still being able to highlight them.

## Demo

See [this demo](https://choum.net/panglesd/lighthigher.html)!

## Usage:

- Include the Javascript file currently at location `bin/lighthigher.js` (you can use a CDN: `<script src="https://cdn.jsdelivr.net/gh/panglesd/lighthigher@master/dist/lighthigher.min.js"></script>`)
- Call `lighthight(highlight_function, elem)` where:
  - `highlight_function` is a function taking a string and returning the string corresponding to the html of the highlighting. You can use any highlighter: `highlightjs`, `prismjs`, ...
  - `elem` is the element you want to highlight

Here is an example with `highlightjs`:

```javascript
// highlight all elements that have a class starting with "language-"
// WITHOUT removing the HTML hierarchy
// Assumes highlightjs is available as "hljs"
document.querySelectorAll("[class^='language-']").forEach((elem) => {
  lighthigh((s) => { return hljs.highlightAuto(s).value }, elem );
});
```
