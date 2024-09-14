# LightHigher

A little helper that takes a "highlighting function", and an element, and use that function to syntax highlight the element, but **without losing the internal HTML structure**! (Element nodes are never removed from the DOM).

## Usage:

- Include the Javascript file currently at location `bin/lighthigher.js` (you can use a CDN, see the examples below)
- Call `lighthight(highlight_function, elem)` where:
  - `highlight_function` is a function taking a string and returning the string corresponding to the html of the highlighting,
  - `elem` is the element you want to highlight

Here is an example with `highlightjs`:

```javascript
// highlight all elements that have a class starting with "language-"
// WITHOUT removing the HTML hierarchy
// Assumes highlightjs is available as "hljs"
document.querySelectorAll("[class^='language-']").forAll((elem) => {
  lighthight((s) => { return hljs.highlightAuto(s).value }, elem );
});
```
