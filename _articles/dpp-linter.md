---
title: "DPP Linter: check any passport against the standards"
description: Enter the link from a product's QR code and see, criterion by criterion, whether its passport can be read, follows the EN 18223 data model, uses valid identifiers and can be checked for integrity. Free, open source, no account.
section: Tools
order: 2
audience: economic operators, DPP service providers, developers
last_reviewed: 2026-10-16
image: /assets/img/dpplint-how.svg
image_alt: "Diagram: a product identifier goes into the DPP Linter, which retrieves the passport like a phone and checks the data model, the identifiers and the integrity against the open criteria of dpp-criteria. Each criterion ends as passed, warning, failed or skipped with a reason."
image_caption: "What the DPP Linter does with a product identifier."
image_width: 960
image_height: 440
cta:
  title: Check a passport now
  text: Paste the link from any product's data carrier – yours, a supplier's or our example lamp.
  buttons:
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
    - label: Check our example passport
      url: "https://dpplint.ownyourdata.eu/?productId=https%3A%2F%2Fdpp.oydapp.eu%2F01%2F09520123456788%2F21%2F000002"
further:
  - title: dpp-criteria
    url: "https://github.com/OwnYourData/dpp-criteria"
    what: the open criteria and how to contribute
  - title: dpplint
    url: "https://github.com/OwnYourData/dpplint"
    what: source code and API description
  - title: DID Lint
    url: "https://didlint.ownyourdata.eu"
    what: the checker for decentralised identifiers it uses
related:
  - public-availability
  - what-is-a-digital-product-passport
  - dpp-manager
  - dpp-service-validator
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- The DPP Linter takes a **product identifier** – the link in a product's QR code – and checks the passport behind it.
- It reads the passport the way a phone would: plain HTTPS, no account, no token.
- It checks against **open criteria** derived from the harmonised standards and EU regulation, which anyone can review and improve.
- Every criterion ends as *passed*, *warning*, *failed* or *skipped* – with the reason.
- It is free and open source. Results are automated checks, not a certification.
</div>

## Why check a passport

A passport is read by software its issuer never sees: a consumer's phone, a recycler's scanner, a customs system. If the identifier does not resolve, the data model is off, or the integrity cannot be checked, those readers fail silently.

The DPP Linter makes these problems visible before anyone else runs into them. It works for any passport that is publicly reachable – one you published yourself, one from a supplier, or one you want to compare with.

## How to use it

Open [dpplint.ownyourdata.eu](https://dpplint.ownyourdata.eu/), paste the product identifier and press **Check**. The result appears within seconds:

{% include figure.html src="/assets/img/screens/dpplint-example.png" alt="Screenshot of the DPP Linter after checking the example passport: '5 of 5 automated checks passed (0 failed, 1 with warnings, 1 skipped)', the address that was retrieved with HTTP status and content type, and the first rows of the criteria table." caption="The summary on top, then one row per criterion." screenshot=true width="1420" height="960" %}

A check can be linked: `https://dpplint.ownyourdata.eu/?productId=<product identifier>` runs it directly, which makes it easy to share a result or put it into a ticket.

For automation there is an API:

```sh
curl https://dpplint.ownyourdata.eu/api/v1/validate/https://dpp.oydapp.eu/01/09520123456788/21/000002
```

A passport that is not published yet can be sent as JSON with `POST /api/v1/validate` – useful as a check before the first submission.

## What it checks

| Area | What the linter does |
|---|---|
| **Retrieval** | requests the product identifier like a scanning phone, without credentials, and checks that a passport comes back – as JSON for software and as HTML for people |
| **Data model** | checks the passport against the EN 18223:2026 data model, using SHACL shapes in SOyA |
| **Identifiers** | checks the product identifier against the schemes of EN 18219:2026, and has decentralised identifiers checked by [DID Lint](https://didlint.ownyourdata.eu) |
| **Integrity** | verifies proofs in the passport and compares the content with the hash in the passport's DID document |

Which checks apply is decided per criterion. A battery-specific criterion, for example, is skipped for a lamp – with the reason *not applicable*.

{% include figure.html src="/assets/img/screens/dpplint-criteria.png" alt="Screenshot of rows from the criteria table: DPP-INT-005, DPP-ROL-016, DPP-SEC-002 (integrity of the passport version is verifiable) and DPP-SEC-014 passed; DPP-BAT-002 skipped as not applicable; DPP-CRT-003 skipped as not evaluated because no shapes are available yet." caption="Passed, and skipped with a reason: the integrity check DPP-SEC-002 passes for our example passport; the battery criterion does not apply to a lamp." screenshot=true width="1476" height="642" %}

## Reading the result

- **passed** – the requirement holds.
- **warning** – only checks of the lower severity *warning* failed; the passport works, but something should be improved.
- **failed** – a mandatory check failed; the findings say what was found.
- **skipped** – not evaluated, always with a reason: *not applicable*, *not implemented*, *no evidence* and others. Skipped criteria never count.

Criteria that are still under review are marked *proposed, not counted*. They are shown so you can see what is coming, but they do not change the summary.

## Open criteria, open to contributions

The criteria are not hidden in the tool. They live in the public repository [dpp-criteria](https://github.com/OwnYourData/dpp-criteria) – one file per criterion, each with its source in the standards or the regulation, paraphrased rather than copied. New or changed criteria are proposed with a pull request and enter as *proposed*; after review they become *active*.

The same criteria are used by the [DPP Service Validator](https://ownyourdata.github.io/dpp-validator/), which checks DPP services rather than single passports every day.

## What the linter cannot tell you

> The results state how many automated checks a passport passed. They are not a certification and do not establish a presumption of conformity. Product-specific content – what a delegated act requires for a particular product group – can only be checked once machine-readable shapes for that group exist; until then such criteria are skipped as *not evaluated*.
{: .open}
