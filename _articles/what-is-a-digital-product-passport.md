---
title: What is a Digital Product Passport?
description: A digital record that travels with a product, reachable by scanning the product itself. What the EU requires, what a passport contains, who reads it and when it becomes mandatory.
section: Basics
order: 1
audience: everyone new to the topic
last_reviewed: 2026-10-16
image: /assets/img/dpp-overview.svg
image_alt: "A product carries a QR code. Scanning it yields the unique product identifier, a web link; resolving that link returns the digital product passport. The EU registry stores identifiers, not passport content."
image_caption: "From product to passport: one scan, one web link, one passport."
image_width: 960
image_height: 480
cta:
  title: Look at a real passport
  text: Our reference passport for an LED lamp is public. Open it as raw data, or let the DPP Linter check it against the published standards. No account needed.
  buttons:
    - label: Check it with the DPP Linter
      url: "https://dpplint.ownyourdata.eu/?productId=https%3A%2F%2Fdpp.oydapp.eu%2F01%2F09520123456788%2F21%2F000001"
    - label: Open the passport (JSON)
      url: "https://dpp.oydapp.eu/01/09520123456788/21/000001"
further:
  - title: Regulation (EU) 2024/1781 (ESPR)
    url: "https://eur-lex.europa.eu/eli/reg/2024/1781/oj"
    what: the legal basis, on EUR-Lex
  - title: Implementing Regulation (EU) 2026/1778
    url: "https://eur-lex.europa.eu/eli/reg_impl/2026/1778/oj"
    what: how the EU DPP registry works
  - title: DPP Service API
    url: "/api-docs/index.html"
    what: the EN 18222 lifecycle API of our public instance
related:
  - role-based-access
  - public-availability
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- A Digital Product Passport (DPP) is a set of data about one product, reachable through a data carrier on the product, usually a QR code.
- The EU introduces passports product group by product group. Batteries come first, from **18 February 2027**.
- The passport is not stored in a central EU database. The economic operator, or a service provider on its behalf, keeps it available; the EU registry only records where to find it.
- Much of a passport is public. Some parts are only for repairers, recyclers or authorities.
</div>

## A product that can answer questions

Today, the facts about a product are scattered: some on the packaging, some in a manual, most in the manufacturer's systems. A repair shop rarely finds the spare-part list; a recycler rarely knows which materials are inside.

A Digital Product Passport changes where that information lives. The product carries a **data carrier** – a QR code, an NFC chip or an RFID tag. Scanning it gives a **unique product identifier**, which is at the same time a web link. Following the link returns the **passport**: structured, machine-readable data about exactly this product, or this batch, or this model.

The EU defines the passport in the Ecodesign for Sustainable Products Regulation (ESPR, Regulation (EU) 2024/1781): a set of data specific to a product, with the content a delegated act prescribes for its product group, accessible electronically through a data carrier.

## What a passport contains

Every passport has the same **header**. The published standard for the data model, EN 18223:2026, fixes its attributes: the passport identifier, the product identifier, whether the passport describes a model, a batch or a single item, its status, the economic operator responsible and when it was last updated.

Below the header come the **data elements**. Which ones a passport needs is decided per product group: materials and substances of concern, carbon footprint, durability, repair and recycling information, and so on.

This is the header of our reference passport for an LED lamp, exactly as it is served:

```json
{
  "digitalProductPassportId": "did:oyd:zQmTMPiMZ6mUg5bVXQxkuZ1JCgmtKE9QNu514EdMUydq9zL",
  "uniqueProductIdentifier": "https://dpp.oydapp.eu/01/09520123456788/21/000001",
  "granularity": "item",
  "dppStatus": "Active",
  "dppSchemaVersion": "EN 18223:2026",
  "economicOperatorId": "did:oyd:zQmX493GLVxE8Wasc8ANTdZmq4YUsvdk5j6Daf7iQaPECt6",
  "lastUpdated": "2026-09-08T15:45:24Z",
  "elements": [ "… ProductIdentification, EnergyPerformance …" ]
}
```

The product identifier in the middle is the one printed on the lamp. It follows the GS1 Digital Link pattern – `01` is the product code, `21` the serial number – and it is also the address you can open in a browser.

## Who reads it

A passport is written for several readers at once:

| Reader | Typical question |
|---|---|
| Consumer | What is it made of, how long will it last, can it be repaired? |
| Repair shop, refurbisher | Which spare parts fit, how is it taken apart? |
| Recycler | Which materials are inside, and where? |
| Customs, market surveillance | Does this product meet the rules for the EU market? |

Not everything is for everyone. The Battery Regulation, for example, distinguishes three groups: the public, persons with a legitimate interest, and authorities. How that works in practice is the subject of [Role-based access to passport data]({{ '/role-based-access/' | relative_url }}).

## Where the data lives

There is no single EU database holding every passport. The **economic operator** that places the product on the market is responsible for its passport. It can keep the passport itself or have a **DPP service provider** do so on its behalf, with a back-up copy kept elsewhere so the passport outlives the company that issued it.

The **EU DPP registry**, live since 20 July 2026, records unique identifiers and where the passport is provided, so that customs and market surveillance can find it. It does not hold the passport content.

How systems exchange passports is set by harmonised standards from CEN and CENELEC. Six of them were cited in the Official Journal in July 2026; following them gives a presumption of conformity with the requirements they cover:

| Standard | Topic |
|---|---|
| EN 18216:2026 | data exchange protocols |
| EN 18219:2026 | unique identifiers |
| EN 18220:2026 | data carriers |
| EN 18221:2026 | data storage, archiving and persistence |
| EN 18222:2026 | APIs for lifecycle management and search |
| EN 18223:2026 | system interoperability and data model |

Two further standards, on access rights and security (prEN 18239) and on authentication and integrity (prEN 18246), were not among those cited.

## When it becomes mandatory

{% include figure.html src="/assets/img/dpp-timeline.svg" alt="Timeline: July 2024 ESPR in force; April 2025 working plan; July 2026 six standards cited and EU DPP registry live; 18 February 2027 battery passport mandatory; next, one delegated act per product group, iron and steel first." caption="Milestones so far, and what comes next." width="960" height="330" %}

The ESPR itself sets no product-specific deadline. Each product group gets its own **delegated act**, which says what the passport must contain and from when. The Commission's working plan for 2025–2030 lists the first groups, among them iron and steel, aluminium, textiles, furniture, tyres and mattresses. A delegated act applies at the earliest 18 months after it enters into force, so every group has a lead time.

**Batteries** follow their own regulation, (EU) 2023/1542. From 18 February 2027, electric-vehicle batteries, batteries for light means of transport such as e-bikes and e-scooters, and industrial batteries above 2 kWh need a passport.

Passports are also foreseen for construction products, toys and detergents, each under its own regulation and timetable.

> Dates and the state of delegated acts change. This article was last reviewed on the date shown at the top; check EUR-Lex for the current legal text.
{: .open}

## How OwnYourData helps

We build free, open-source tools around the published standards, so that a passport does not depend on a single vendor:

- the **DPP Service**, a public instance of the EN 18222 lifecycle API;
- the **DPP Manager**, an application economic operators run on their own computer to describe products and issue passports;
- the **DPP Linter**, which checks the passport behind any product identifier;
- the **DPP Service Validator**, which checks DPP services against open criteria every day.

{% include figure.html src="/assets/img/screens/dpplint-example.png" alt="Screenshot of the DPP Linter: the reference passport passes all automated checks, with one warning." caption="The DPP Linter checking our reference passport. Try it with any product identifier." screenshot=true width="1420" height="960" %}
