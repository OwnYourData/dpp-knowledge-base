---
title: "The DPP criteria catalogue: requirements you can check"
description: How the open repository dpp-criteria turns the ESPR and the harmonised standards into machine-checkable criteria – what a criterion contains, which tool checks it, where each requirement comes from, and how anyone can contribute.
section: Concepts
order: 3
audience: DPP service providers, developers, standardisation and compliance experts
last_reviewed: 2026-10-16
image: /assets/img/criterion-anatomy.svg
image_alt: "Annotated YAML file of criterion DPP-ID-001: the statement and level (what applies), the basis with sources, clauses and kinds (where it comes from), target and method (who and how), and the check of type resolve with the catalogue rows it covers (the check)."
image_caption: "One criterion, one file: what applies, where it comes from, who is checked how, and the check itself."
image_width: 960
image_height: 520
cta:
  title: Read the catalogue – or improve it
  text: Every criterion and data point is listed in readable form. New proposals are welcome as pull requests.
  buttons:
    - label: Browse the criteria
      url: "https://github.com/OwnYourData/dpp-criteria/blob/main/criteria/README.md"
    - label: The repository
      url: "https://github.com/OwnYourData/dpp-criteria"
further:
  - title: Criteria format
    url: "https://github.com/OwnYourData/dpp-criteria/blob/main/CRITERIA-FORMAT.md"
    what: every field, check type and result code
  - title: Data points
    url: "https://github.com/OwnYourData/dpp-criteria/blob/main/datapoints/README.md"
    what: what EU legal acts require or allow in a passport
  - title: Data point format
    url: "https://github.com/OwnYourData/dpp-criteria/blob/main/DATAPOINT-FORMAT.md"
    what: tiers, access classes and sources
related:
  - dpp-linter
  - dpp-service-validator
  - dpp-roadmap
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- **dpp-criteria** is an open repository that writes the requirements of EU law and the DPP standards down as machine-checkable **criteria** – one file each, with the exact clause it comes from.
- The repository checks nothing itself. The [DPP Linter]({{ '/dpp-linter/' | relative_url }}) applies the passport criteria, the [DPP Service Validator]({{ '/dpp-service-validator/' | relative_url }}) the service criteria.
- Besides the criteria it lists **data points**: what each EU legal act requires or allows in a passport, and who may see it.
- Anyone can propose a criterion by pull request. It counts in results only after review.
- Licence: Apache 2.0. Statements paraphrase their sources; no text from licensed standards is copied.
</div>

## Why a catalogue

The requirements for Digital Product Passports are spread across the Ecodesign Regulation, its delegated acts, product regulations such as the Battery Regulation and eight European standards. Each says something about identifiers, data models, APIs, security or access – in prose, and often in different words for the same thing.

A criteria catalogue turns that prose into short, testable statements: *this* must hold, *here* is where it comes from, and *this* is how to check it. Because the catalogue is open, every result of the linter and the validator can be traced back to a rule anyone can read, question and improve.

## What is in the repository

| Folder | Content |
|---|---|
| `criteria/` | the criteria, one YAML file each, grouped by area – identifiers, data model, API, data exchange, security, access and others |
| `datapoints/` | the data points EU legal acts require or allow in a passport – for reference, not checked |
| `services/` | one entry per DPP service in the daily checks |
| `soya/` | the SOyA structure with the SHACL shapes the passport is checked against |
| `schema/` | JSON Schemas for criteria, data points and service entries |
| `tests/` | test vectors for the schemas, the shapes and the path expressions |
| `scripts/` | tools that render the readable overviews and test the structures |

Every file is checked against its JSON Schema whenever something changes, so a malformed criterion never reaches the tools.

## A criterion in four parts

The picture at the top shows criterion DPP-ID-001: *the product identifier resolves to its passport*.

1. **What applies.** The `statement` says in one or two sentences what must hold, paraphrasing the source. `level` is MUST, SHOULD or MAY.
2. **Where it comes from.** `basis` names each legal act or standard, the exact clause and the kind of source.
3. **Who and how.** `target` says what is checked – a published passport, a DPP service, or the economic operator. `method` says how: automatically from the public internet, automatically with test credentials from the operator, or by self-declaration.
4. **The check.** `check` names one of nine check types and its parameters. `catalogue_ref` lists the rows of the requirements catalogue the criterion covers – several rows that lead to the same check share one criterion, so a requirement is never counted twice.

A criterion keeps its ID for good; a deleted ID is never reused. When its meaning changes, its `version` goes up.

## The criteria in numbers

{% include figure.html src="/assets/img/criteria-numbers.svg" alt="Bar charts: 47 criteria, 23 with target passport for the DPP Linter, 23 with target service for the DPP Service Validator, 1 with target operator by self-declaration; 21 active and 26 proposed; check types http 17, shacl 13, resolve 5, tls 4, declaration 3, proof 2, did 1, links 1, html 1." caption="State of 16 October 2026. The target decides which tool runs a criterion." width="960" height="330" %}

| Check type | What it does |
|---|---|
| `http` | calls the API, checks status codes and the JSON returned |
| `shacl` | validates the passport against SOyA shapes – the data model of EN 18223 and the identifiers of EN 18219 |
| `resolve` | requests the product identifier like a phone that scanned the code |
| `tls` | checks the certificate, the TLS versions and the HTTP versions |
| `proof`, `did` | verifies integrity proofs and the passport's hash; resolves and checks DIDs |
| `links`, `html` | follows linked resources; checks that the readable view loads nothing from elsewhere |
| `declaration` | records a self-declaration with a link to evidence – never shown as *passed* |

Each check type is implemented exactly once in the tools. A proposal that needs a new kind of check adds it to the tool in the same pull request.

## Every requirement names its source

| Kind of source | Meaning |
|---|---|
| `regulation` | an EU regulation, such as the ESPR or the Battery Regulation |
| `harmonised-standard` | a standard cited in the Official Journal, which gives a presumption of conformity |
| `standard` | any other published standard – including EN 18239 and EN 18246 until they are cited |
| `draft-standard` | a standard not yet published |
| `guidance` | official guidance, such as Commission guidance documents |
| `derived` | an engineering conclusion from the other sources – never the only basis of a MUST |

Clauses refer to the published 2026 editions of the standards. When a standard is cited in the Official Journal, its entries change from `standard` to `harmonised-standard`.

## From proposal to result

New criteria arrive as pull requests with the status **proposed**. A maintainer reviews them and sets them to **active**. Only active criteria count in the "N of M automated checks passed" that the tools report; proposed ones are shown separately so everybody can see what is coming.

Each check ends as *passed*, *warning*, *failed* or *skipped*. A skipped criterion always carries a reason – *not applicable*, *not implemented*, *no evidence*, *needs credentials*, *not sent*, *unreachable* or *not evaluated* – and never counts.

The results are automated checks. They are not a certification and do not establish a presumption of conformity.

## Data points: what goes into a passport

Criteria ask whether a service or a passport **works** as the standards require. Data points ask a different question: what **content** does an EU legal act require or allow in a passport? They are not checked; they are the reference from which product-specific criteria can be derived.

Each data point names the term used in the legal act, a paraphrased description, the attribute of EN 18223 where one exists, who provides it, how binding it is (`tier`, from *fixed* in every passport to *voluntary*), who may see it (`access`) and its source with clause.

{% include figure.html src="/assets/img/datapoints-numbers.svg" alt="Bar charts: 229 data points – 79 construction products, 71 batteries, 56 ecodesign, 21 toys, 2 deforestation; access: 130 public, 61 left to the delegated act, 29 restricted to named actors, 9 where the act is silent." caption="State of 16 October 2026. The battery data points follow the Commission's guidance document on the battery passport, version 2.0 of 15 August 2026." width="960" height="330" %}

One number stands out: for **61 of the 229 data points**, only a future delegated act will decide whether they are public or restricted to certain readers. Anyone building passport systems today has to keep access levels flexible – which is why the DPP Service classifies data per attribute instead of hard-coding who sees what. See [Role-based access to passport data]({{ '/role-based-access/' | relative_url }}).

## How to contribute

- **Propose a criterion** – as a pull request; it enters as *proposed*.
- **Add data points** – for legal acts or product groups not yet covered.
- **List your DPP service** – so it is checked every day like any other; see the [DPP Service Validator]({{ '/dpp-service-validator/' | relative_url }}).

> The numbers in this article reflect the repository on 16 October 2026. The catalogue grows with every merged pull request; the readable overviews in the repository always show the current state.
{: .open}
