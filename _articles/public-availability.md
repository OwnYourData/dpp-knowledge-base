---
title: "Public availability: from QR code to passport"
description: How anyone gets from the code on a product to its passport – without an account or an app – why the link on the product never has to change, and how a reader can check that the data is genuine.
section: Concepts
order: 1
audience: economic operators, DPP service providers, developers
last_reviewed: 2026-10-16
image: /assets/img/public-access-paths.svg
image_alt: "Diagram: three ways to the same passport – scanning the product, asking a DPP service, or resolving the passport identifier – all lead to the custodian, which returns a readable page to a browser and JSON to software. The passport's DID document carries a hash of the JSON for checking."
image_caption: "Three ways in, one passport. Which form comes back depends only on what the client asks for."
image_width: 960
image_height: 520
cta:
  title: Try it with a real passport
  text: Scan or open the link of our example lamp, then let the DPP Linter check what comes back – including whether the content matches the hash in its DID document.
  buttons:
    - label: Check it with the DPP Linter
      url: "https://dpplint.ownyourdata.eu/?productId=https%3A%2F%2Fdpp.oydapp.eu%2F01%2F09520123456788%2F21%2F000002"
    - label: Open the passport
      url: "https://dpp.oydapp.eu/01/09520123456788/21/000002"
further:
  - title: Identifiers in the DPP ecosystem
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Identifiers.md"
    what: the six identifiers and how they connect
  - title: Identifiers, version chain and integrity
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Integrity.md"
    what: how the payload hash is computed and checked
  - title: DPP Service API
    url: "/api-docs/index.html"
    what: ReadDPPByProductId and the other EN 18222 methods
related:
  - what-is-a-digital-product-passport
  - role-based-access
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- The code on the product carries one web link. Opening it shows the passport – in a browser as a readable page, to software as JSON.
- Reading the public part needs no account, no app and no token.
- The link points to a domain of the economic operator. The passport can move to another custodian without reprinting a single label.
- The passport's own identifier carries a hash of its content, so anyone can check that what they received is what the operator published.
</div>

## Why "public" is a design requirement

A passport is only useful if the people who hold the product can read it: the buyer in the shop, the repair shop years later, the recycler at the end. None of them will install an app or create an account for each brand they come across.

The standard on identifiers, EN 18219:2026, says so explicitly. Reaching a passport from the product must not require registration, a software download or credentials (cl. 4.6.2), it must not lock the operator into one vendor, and the identifier has to stay usable even if the operator becomes insolvent or stops trading.

## One address for people and for software

The string in the QR code is the **unique product identifier**. For our example lamp it is:

```text
https://dpp.oydapp.eu/01/09520123456788/21/000002
```

It follows the GS1 Digital Link pattern: `01` is followed by the product code, `21` by the serial number. A phone camera opens it like any other link, and the custodian answers with a page a person can read.

{% include figure.html src="/assets/img/screens/passport-on-phone.png" alt="Screenshot of the passport page on a phone: the heading LUM-A60-827-806, the section 'About this passport' with product identifier, passport identifier, granularity, status, last updated, economic operator and schema version, followed by the product identification." caption="The same link, opened on a phone. No app, no login." screenshot=true maxwidth="360" width="585" height="1335" %}

Software asks the same address for JSON and receives the passport as defined in EN 18223:2026:

```sh
curl -H "Accept: application/json" https://dpp.oydapp.eu/01/09520123456788/21/000002
```

There is no second "machine link" and no redirect. One string on the product serves both audiences.

## Three ways in

| Way in | Who uses it | What it needs |
|---|---|---|
| **Scan the product** | people, with any phone | nothing but the code on the product |
| **Ask a DPP service** – `ReadDPPByProductId` | software, through the EN 18222 API | the product identifier |
| **Resolve the passport identifier** | software that starts from a `did:oyd` | a DID resolver |

All three arrive at the same public part of the passport. The DPP Service of OwnYourData answers the second way at

```text
https://dpp-service.ownyourdata.eu/dpp/v1/dppsByProductId/{product identifier, URL-encoded}
```

## Who answers the link

The host in the product identifier belongs to the **economic operator**. In its own DNS zone, the operator points that name at the **custodian** that currently holds the passport – a DPP service provider, or the operator itself. Nothing is redirected: the custodian answers directly under the operator's name.

That one detail decides what happens when the operator changes provider.

{% include figure.html src="/assets/img/custodian-change.svg" alt="Diagram: the link on the product stays the same. The operator changes one DNS record in its own zone from the previous custodian to the new one, and a signed log entry of the passport identifier names the new service endpoint." caption="Changing custodian: one DNS record and one signed log entry. The label on the product stays as it is." width="960" height="340" %}

- The **link on the product never changes.** It was printed once and stays valid for the life of the product.
- The **DNS record** moves to the new custodian. It is the operator's own record, so no provider can hold the link hostage.
- The **passport identifier**, a `did:oyd`, records the move as an entry in its log, signed with the passport's own key: its `serviceEndpoint` now names the new custodian. Who holds the passport is therefore on record.

The new custodian needs a TLS certificate for the operator's name before the record is switched, and the previous one keeps serving until DNS caches have expired.

## Check what you received

Public does not mean unverifiable. The DID document of the passport identifier names where the passport is served – and a hash of the JSON served there:

```json
{
  "id": "did:oyd:zQmZh7YHUtLVoptfC2N7g8uBhsABGJAErJNDmDdtUqGpM1S#payload",
  "type": "DigitalProductPassport",
  "serviceEndpoint": "https://dpp.go-data.at/dpp/v1/dppsByProductId/https%3A%2F%2Fdpp.oydapp.eu%2F01%2F09520123456788%2F21%2F000002",
  "payloadHash": "zQmRdgMsgR8RRaQEadHFSJ2Zw4cReM6MpeZWJJTEjRzbSfw"
}
```

The DID document can only be changed with the passport's own key – held by the economic operator, or by its DPP service on its behalf – and every change is a signed entry in its log. A reader who fetches the passport, hashes it and finds the same value knows that the content is what the operator committed – without having to trust the custodian, the DPP service or the network in between.

Three ways to do the check:

- the **DPP Linter** does it for any product identifier you enter;
- `bin/verify_dpp <product identifier>` from the open-source DPP Service does it on the command line, using nothing but public web requests;
- the DPP Service reports the hash and whether it is committed in the response headers `X-DPP-Payload-Hash` and `X-DPP-Commit-State`.

## Public means the public part

What is public is decided per attribute. A passport whose operator has marked some attributes for readers with a legitimate interest or for authorities is served in two parts: the public part on the link on the product, the rest only through the DPP Service to readers who hold a grant. How that works is described in [Role-based access to passport data]({{ '/role-based-access/' | relative_url }}).

## What is still open

> EN 18221:2026 describes a back-up copy of each passport, kept by a second, independent service provider, so that a passport survives the failure of its main custodian. The standard defines how such a back-up works but does not itself oblige anyone to have one. For the passports served here, no back-up provider is appointed yet.
{: .open}
