---
title: "QR code, GS1 Digital Link and unique identifiers"
description: The link on the product is the one part of a Digital Product Passport that can never be changed once it is printed. What it consists of, which identifier schemes the standards allow, where the data carrier goes – and how to choose so that the link outlives your service provider.
section: Concepts
order: 0.5
audience: economic operators, product and packaging teams, developers
last_reviewed: 2026-10-17
image: /assets/img/identifier-anatomy.svg
image_alt: "A unique product identifier in the GS1 Digital Link form: https://dpp.oydapp.eu/01/09520123456788/21/000002. The domain belongs to the economic operator and can be pointed at any custodian; 01 introduces the 14-digit product code (GTIN), whose last digit is a check digit; 21 introduces the serial number of one item. A data carrier – QR code, Data Matrix, NFC or RFID – holds only this link. The path also says what the passport describes: /01/ alone for a model, /01/…/10/… for a batch, /01/…/21/… for one item. Which of the three a product group needs is set by its delegated act; batteries need one passport per item."
image_caption: "One web link on the product: your domain, the product code and – for one item – the serial number."
image_width: 960
image_height: 400
cta:
  title: Check a product identifier
  text: The DPP Linter checks whether a link follows an EN 18219 scheme, whether it leads to a passport and whether the granularity in the path matches the passport – for any product, without an account.
  buttons:
    - label: Check our example lamp
      url: "https://dpplint.ownyourdata.eu/?productId=https%3A%2F%2Fdpp.oydapp.eu%2F01%2F09520123456788%2F21%2F000002"
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
further:
  - title: GS1 Digital Link
    url: "https://ref.gs1.org/standards/digital-link/"
    what: the GS1 standard behind the /01/…/21/… links
  - title: Identifiers in the DPP ecosystem
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Identifiers.md"
    what: the identifiers the DPP Service uses and how they connect
  - title: Regulation (EU) 2024/1781 (ESPR)
    url: "https://eur-lex.europa.eu/eli/reg/2024/1781/oj"
    what: Articles 2, 9 and 10 on data carriers and unique identifiers
related:
  - public-availability
  - laws-and-standards
  - getting-started
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- On the product sits a **data carrier** – usually a QR code – and in it one **unique product identifier**: a web link that leads to the passport.
- Once printed, the link cannot be changed. Its **domain** should therefore be one you own, so that you can move the passport to another provider without new labels.
- EN 18219 allows **five identifier schemes**. The most common is the **GS1 Digital Link**: `/01/` and the product code, `/21/` and a serial number for one item, `/10/` and a lot for a batch.
- EN 18220 says where the carrier goes – on or in the product rather than only on the packaging – and what it must survive.
- Opening the link must need **no app, no account and no registration**.
</div>

## Three things that are easy to mix up

| | What it is | Where it lives |
|---|---|---|
| **Data carrier** | the QR code, Data Matrix, NFC chip or RFID tag | on the product, its packaging or its documents |
| **Unique product identifier** | the string in the carrier – a web link that names the product and leads to its passport | in the carrier, and in the passport as `uniqueProductIdentifier` |
| **Passport identifier** | the identifier of the passport itself – here a `did:oyd` | inside the passport, never on the label |

The ESPR defines both terms. A **data carrier** is a barcode, a two-dimensional symbol or another medium for automatic identification that a device can read. A **unique product identifier** is a unique string that identifies a product and also enables a web link to its passport (Article 2). EN 18223 uses the same string as the attribute `uniqueProductIdentifier`. There is no second "machine link" – one string serves people and software.

The ESPR adds the essentials (Article 10): the passport is connected through a data carrier to a **persistent** identifier; the carrier is physically present on the product, its packaging or the accompanying documents; and both follow the harmonised standards – today EN 18219 for the identifier and EN 18220 for the carrier.

## Anatomy of a GS1 Digital Link

Our example lamp carries this link:

```text
https://dpp.oydapp.eu/01/09520123456788/21/000002
```

- **`https://dpp.oydapp.eu`** – a domain of the economic operator. Where it points is decided in the operator's own DNS.
- **`/01/09520123456788`** – the GS1 Application Identifier 01 and the 14-digit product code, the GTIN. The last digit is a check digit; a wrong one makes the whole link invalid. The prefix 952 is reserved by GS1 for examples – real products use a company prefix from the national GS1 organisation.
- **`/21/000002`** – Application Identifier 21 and the serial number: this one item.

The path also says what the passport describes. `/01/` alone means the **model**, `/01/…/10/…` a **batch**, `/01/…/21/…` one **item**. A passport's granularity must match its link – the DPP Linter checks exactly that. Which granularity a product group needs is set in its delegated act; for batteries it is one passport per item.

## Five schemes the standard allows

EN 18219:2026 lists five identifier schemes for products. All of them produce something a phone can open, directly or through a resolver:

| Scheme | Built on | Who issues it |
|---|---|---|
| **Structured path and query** – the GS1 Digital Link is the best-known form | ISO/IEC 15459, ISO/IEC 15418, ISO/IEC 18975 | an issuing agency such as GS1; you need a company prefix |
| **Identification Link** | EN IEC 61406 | you, on your own domain – no membership needed |
| **Decentralised identifiers (DIDs)** | W3C DID Core | you, with a DID method of your choice |
| **Product and group identification** for RFID and compact codes | ISO/IEC 15459, ISO/IEC 15434, ISO/IEC 15961 | an issuing agency |
| **Digital Object Identifiers (DOI)** | ISO 26324 | a DOI registration agency |

The standard sets the same rules for all of them. The identifier has to be **unique** and **persistent** – also if the operator becomes insolvent or stops trading. It has to be usable on the web, either as a URL or by a defined conversion into one. Reaching the passport must not need a registration, a software download or credentials, and the scheme must not lock the operator into one vendor.

**What the DPP Service supports.** The open-source DPP Service and the custodian that serves its passports answer GS1 Digital Links and Identification Links directly under the operator's domain. A DOI or a DID on the label would put a third-party resolver between the product and its passport – we leave those out of the link on the product. The DID is used where it fits: as the passport identifier inside the passport.

## Choose the domain once, and choose your own

Everything in the link can be planned except one thing: once the label is printed, the link is fixed for the life of the product. The domain in it decides who can serve the passport.

- **Your own domain** – for example `dpp.your-company.com`. You point it at whichever provider keeps your passports. Changing provider means changing one DNS record; the labels stay as they are. How that works is shown in [Public availability]({{ '/public-availability/' | relative_url }}).
- **A provider's domain** – for example `passports.some-provider.com/…`. Quick to start, but every passport now depends on that provider. If you leave, or the provider stops, the printed links stop working.

EN 18219 makes the same point: in its comparison of schemes, a link-based identifier avoids lock-in precisely because the domain is registered by the operator and can be transferred.

Avoid anything that adds a party to the path: URL shorteners, redirect services, tracking parameters. Each of them is one more place where the link can break.

## Where the data carrier goes

EN 18220:2026 deals with the carrier. In short:

- There has to be **at least one carrier** – on the product, embedded in it, on the packaging or in the accompanying documents. On or in the product is preferred: packaging is usually gone when a product is resold, repaired or recycled, and the link goes with it.
- The carrier has to **last as long as the product** – including repair, reuse and refurbishment. That decides between a printed label, laser marking or an embedded chip.
- **QR code and Data Matrix** can be read by phone cameras; their **error correction** keeps them readable when partly damaged. NFC is read by tapping, UHF RFID from several metres in logistics.
- **Size** depends on the amount of data, the module size and the printing process. A short link makes a smaller code – one more reason to keep domain and path short.
- The carrier should be **easy to find and identify** as the passport's carrier, may be marked with a graphic symbol, and should take the accessibility needs of readers into account.

Which carrier a product group must use, how it is laid out and where it sits is set by its delegated act (ESPR, Article 9). For batteries, a QR code is required on every battery from 18 February 2027, and for batteries with a passport it leads there.

**Selling online.** Where customers cannot hold the product, the ESPR requires the operator to give dealers and online marketplaces a digital copy of the data carrier or the identifier – on request, free of charge and within five working days (Article 10(3)).

## A checklist before you print

1. **Product code:** a GTIN from your GS1 organisation – or an Identification Link on your own domain.
2. **Granularity:** model, batch or item, as the delegated act for your product group requires.
3. **Domain:** your own, short, and kept for the life of the products.
4. **No extras:** no shortener, no redirect, no tracking parameters in the link.
5. **Carrier:** on or in the product, durable, readable by phone cameras – and a digital copy ready for online shops.
6. **Test:** print one, scan it with an ordinary phone, then put the link into the [DPP Linter](https://dpplint.ownyourdata.eu/).

## Still open

> - **The EU registry** records unique product identifiers and asks for `https` links that resolve at all times. According to its user guide of August 2026, passports could not yet be registered, because the semantic catalogue the registry checks against was not defined for any product group.
> - **Delegated acts** decide carrier, placement and granularity for each product group. Apart from batteries, none has been adopted yet.
{: .open}

This article explains the rules; it is not legal advice. It reflects the state of 17 October 2026.
