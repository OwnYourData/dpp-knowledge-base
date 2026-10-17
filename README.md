# DPP Knowledge Base

Self-contained articles on Digital Product Passports by OwnYourData, published at
<https://dpp-service.ownyourdata.eu/kb/>.

Each article explains one topic – a regulation, a concept, one of our tools –
completely enough to be read on its own, with at least one picture, and says when
it was last reviewed.

## Preview locally

Ruby 3.3 and Bundler are all it takes:

```sh
bundle install
bundle exec jekyll serve --livereload
```

Then open <http://localhost:4000/kb/>. Search only works in a full build, because
the index is created after Jekyll has run:

```sh
bundle exec jekyll build
npx -y pagefind@1.3.0 --site _site
```

## Build the container

```sh
docker build -t dpp-knowledge-base .
docker run --rm -p 8080:8080 dpp-knowledge-base
```

The site is then at <http://localhost:8080/kb/>. The image builds the site with
Jekyll, indexes it with Pagefind and serves it with nginx under `/kb/`.

## Write an article

See [CONTRIBUTING.md](CONTRIBUTING.md): structure, front matter, pictures, and
what does not belong in an article.

## Funding

The DPP Knowledge Base is part of the project [PACE-DPP](https://dpp-austria.at/) – Promoting and Accelerating a Digital Product Passport based Data-Service Ecosystem. This Lighthouse Project has been made possible by financial contributions from the Austrian Federal Ministry of Innovation, Mobility and Infrastructure ([BMIMI](https://www.bmimi.gv.at/en.html), formerly BMK), supported by the Austrian Research Promotion Agency (FFG) under grant number [917177](https://projekte.ffg.at/projekt/5128301), as well as from the German Federal Ministry of Research, Technology and Space (BMFTR, formerly BMWK), supported by the German Research Promotion Agency (DLR-PT).

## Licence

Articles and pictures: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
Code (layouts, styles, build files): Apache 2.0, see [LICENSE](LICENSE).
