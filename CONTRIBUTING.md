# Writing an article

An article is one Markdown file in `_articles/`. Its file name becomes its
address: `_articles/role-based-access.md` is published at `/kb/role-based-access/`.
Choose the name once; changing it later breaks every link to the article.

## Front matter

```yaml
---
title: Role-based access to passport data          # the question or topic, as a reader would search for it
description: One or two sentences: what the reader learns.   # also the search-result snippet
section: Concepts                                   # Basics, Concepts or Tools
order: 1                                            # position within the section
audience: economic operators, developers            # "For …" line under the title
last_reviewed: 2026-10-16                           # set whenever the content is checked again
image: /assets/img/access-classes.svg               # the picture at the top, also used on the card
image_alt: What the picture shows, in words.
image_caption: One sentence under the picture.
image_width: 960
image_height: 500
cta:                                                # one next step for the reader
  title: Set it up for your own products
  text: One sentence.
  buttons:
    - label: Get the DPP Manager
      url: "https://github.com/OwnYourData/dpp-manager-public"
further:                                            # sources and references
  - title: Regulation (EU) 2023/1542
    url: "https://eur-lex.europa.eu/eli/reg/2023/1542/oj"
    what: what the reader finds there
related:                                            # file names of other articles
  - what-is-a-digital-product-passport
---
```

## Structure

1. An **"In short"** box with three or four points – the article for readers in a hurry.
2. Why the topic matters, in plain words.
3. How it works, with at least one picture.
4. What is still open, if anything.
5. A next step (`cta`) the reader can take at once: a tool to try, a passport to open.

Keep paragraphs short. Prefer a table or a picture to a long list, and a list to a
long paragraph. No wall of text.

## Pictures

Every article has a picture at the top and at least one more further down.

- **Diagrams** are hand-written SVG in `assets/img/`, 960 pixels wide, with their
  own `<title>` and `<desc>`. They define their colours for light and dark mode
  in an embedded `<style>` with `@media (prefers-color-scheme: dark)`, using the
  palette of `assets/css/kb.css`. Text at least 14 px.
- **Screenshots** go to `assets/img/screens/` as PNG, cropped to what matters.
- In the text: `{% include figure.html src="/assets/img/…" alt="…" caption="…" %}`,
  with `screenshot=true` for screenshots.

## What does not belong in an article

- Descriptions of earlier versions, migration paths or "previously …" – an
  article describes what exists now.
- Internal hostnames, secret names, cluster details.
- Claims about law or standards without a source in `further`. Dates change: set
  `last_reviewed` when you check them.
- Promises about features that are not live.
