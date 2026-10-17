---
title: "Battery passport: what you need by 18 February 2027"
description: From 18 February 2027, every electric-vehicle battery, every battery for light means of transport and every industrial battery above 2 kWh placed on the EU market needs a digital passport. Which batteries are covered, who is responsible, what goes in, who may read what – and what is still undecided.
section: Basics
order: 4
audience: battery manufacturers, importers and distributors, compliance and product teams
last_reviewed: 2026-10-17
image: /assets/img/battery-scope.svg
image_alt: "A passport is required from 18 February 2027 for electric-vehicle batteries, batteries for light means of transport such as e-bikes, e-scooters and e-mopeds, and industrial batteries above 2 kWh including home storage – for every such battery placed on the EU market or put into service, including repurposed or remanufactured ones. No passport for portable batteries, starter batteries and industrial batteries up to 2 kWh. Responsible is the economic operator that places the finished battery on the market."
image_caption: "Which batteries need a passport from 18 February 2027 – and who is responsible for it."
image_width: 960
image_height: 396
cta:
  title: Build the passport on the published standards
  text: The DPP Manager classifies every attribute as public, for readers with a legitimate interest or for authorities – the same groups the Battery Regulation uses – and publishes through a DPP service. Free and open source.
  buttons:
    - label: Get the DPP Manager
      url: "https://github.com/OwnYourData/dpp-manager-public"
    - label: Role-based access explained
      url: "/kb/role-based-access/"
further:
  - title: Regulation (EU) 2023/1542 (batteries)
    url: "https://eur-lex.europa.eu/eli/reg/2023/1542/oj"
    what: Articles 77 and 78, Annex XIII
  - title: Digital Batteries Passport – data points by category
    url: "https://single-market-economy.ec.europa.eu/document/download/cd1e5e6c-4a4a-4b99-995a-49eb6916187e_en?filename=Digital+Batteries+Passport+-+data+point+by+category.pdf"
    what: the Commission's guidance, version 2.0 of 15 August 2026
  - title: Batteries – Digital Product Passport
    url: "https://single-market-economy.ec.europa.eu/single-market/digital-product-passport/batteries_en"
    what: the Commission's page on the battery passport
  - title: Battery Pass content guidance
    url: "https://thebatterypass.eu/assets/images/content-guidance/pdf/2023_Battery_Passport_Content_Guidance.pdf"
    what: industry guidance on every data attribute – not official
related:
  - role-based-access
  - dpp-roadmap
  - laws-and-standards
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- From **18 February 2027**, electric-vehicle batteries, batteries for light means of transport and industrial batteries above 2 kWh need a passport when they are placed on the EU market or put into service.
- **Responsible** is the economic operator that places the finished battery on the market. It may have someone else keep the passport, but stays accountable.
- The content is fixed in **Annex XIII** of the Battery Regulation. The Commission's guidance lists **71 data points**; some do not have to be filled yet.
- Annex XIII splits the content into a **public** part, a part for **persons with a legitimate interest**, and a part for **authorities**.
- Still missing: the rules on **who has a legitimate interest**. They were due by 18 August 2026. The date of 18 February 2027 stands regardless.
</div>

## Which batteries need a passport

The Battery Regulation, (EU) 2023/1542, is the first EU law that makes a digital product passport mandatory. Article 77 requires a passport for three kinds of batteries:

- **Electric-vehicle batteries** – traction batteries for electric and hybrid road vehicles.
- **Batteries for light means of transport** – e-bikes, e-scooters, e-mopeds.
- **Industrial batteries with a capacity above 2 kWh** – including home storage and other stationary storage.

It applies to every such battery placed on the EU market or put into service from 18 February 2027, wherever it was made. Portable batteries, starter batteries and industrial batteries up to 2 kWh need no passport.

## Who is responsible

The passport belongs to the **economic operator that places the finished battery on the market** – usually the company that assembles the battery pack, or the importer. Suppliers of cells and modules need no passport of their own.

The operator may authorise another operator in writing to keep the passport for it, for example a DPP service provider. It remains responsible for the passport being accurate, complete and up to date.

The passport follows the battery through its life:

- When a battery is **repurposed, reused or remanufactured**, the operator that puts it back on the market takes over and creates a **new passport linked to the original one**.
- When it becomes **waste**, responsibility passes to the producer, its producer responsibility organisation or the waste management operator.
- The passport **ends** once the battery has been recycled.

## What goes into it

Annex XIII lists the content. Some of it describes the **battery model** and is the same for every battery of that model; some is **specific to the individual battery** and changes over its life, such as the state of health.

To help operators prepare, the Commission published a guidance document with **71 data points**, version 2.0 of 15 August 2026. For each data point, it gives the legal source and whether it is mandatory, optional or conditional for electric-vehicle, light-transport and industrial batteries. It is guidance, not law.

Several data points **do not have to be filled as of February 2027**, because the act that defines them is not ready or the obligation starts later:

| Data points | Why not yet |
|---|---|
| carbon footprint declaration and label | the format still depends on an implementing act |
| responsible sourcing | the due diligence obligation applies from August 2027 |
| shares of recovered cobalt, lithium, nickel and lead | depend on a delegated act on recycled content |
| instructions for use | on hold while the simplification package is negotiated |
| material composition, rated capacity in Ah | already covered by other data points |

## Who may read what

{% include figure.html src="/assets/img/battery-access.svg" alt="Annex XIII in four points. Point 1, battery model, public: manufacturer, model, chemistry, capacity, hazardous substances, carbon footprint, declaration of conformity – anyone who scans the QR code; DPP Service class public. Point 2, battery model, restricted: detailed composition, part numbers, dismantling information, safety measures – persons with a legitimate interest, and notified bodies, market surveillance authorities and the Commission; class legitimate interest. Point 3, compliance: test reports – notified bodies, market surveillance authorities and the Commission; class authority. Point 4, individual battery over time: state of health, status, charge cycles, negative events – persons with a legitimate interest; class legitimate interest." caption="The four parts of Annex XIII, who may read each – and the matching access class in the DPP Service." width="960" height="435" %}

The passport is not all public. Repairers, second-life operators and recyclers get more than a consumer; authorities get the test reports. Article 77(2) also gives notified bodies, market surveillance authorities and the Commission access to point 2 – in the DPP Service the classes are ordered, so readers of the authority class see everything the legitimate-interest class sees. Building a passport therefore means deciding, attribute by attribute, who may see it – and keeping that decision adjustable, because the group with a legitimate interest is not defined yet. How that works is explained in [Role-based access to passport data]({{ '/role-based-access/' | relative_url }}).

## How the passport is found

- **QR code.** From 18 February 2027, batteries carry a QR code. For batteries with a passport, it leads to the passport.
- **Unique identifier.** Each passport has a unique identifier following ISO/IEC 15459 or an equivalent standard – for example a GS1 Digital Link with the serial number of the battery.
- **EU registry.** The identifier is recorded in the EU DPP registry set up under the Ecodesign Regulation, live since 20 July 2026. The registry records where the passport is; it does not hold its content.
- **Technical rules.** Article 78 asks for passports that are interoperable with the other EU product passports, built on open standards, machine-readable and searchable, free to access within each reader's rights, and available even after the operator has ceased to exist. The [published European standards]({{ '/laws-and-standards/' | relative_url }}) describe how such a system is built.

## What to do now

1. **Check which of your batteries are in scope** – category, capacity, and whether you are the one placing the finished battery on the market.
2. **Collect the data** with your suppliers, using the Commission's list of 71 data points per category.
3. **Decide on identifiers and data carriers**: a unique identifier per battery and a QR code that leads to the passport.
4. **Choose where the passports are kept** – yourself or a DPP service provider – and make sure they stay available if either of you stops operating.
5. **Classify each attribute** as public, for persons with a legitimate interest or for authorities, along Annex XIII, and keep the legitimate-interest group configurable.
6. **Plan the updates** for the data that changes over the battery's life, such as state of health.

## Still open

> - **Persons with a legitimate interest.** The implementing act that defines who they are, and what they may download, share and re-use, was due by 18 August 2026 and has not been adopted. The Commission lists it for the fourth quarter of 2026.
> - **Carbon footprint and recycled content.** The acts that set the format of the carbon footprint declaration and the rules for recycled content are not all in place, so those data points stay empty for now.
> - **Simplification.** Proposals to simplify the Battery Regulation are under negotiation. As of October 2026, none of them moves the passport date.
{: .open}

This article explains the rules; it is not legal advice. It reflects the state of 17 October 2026 – check the Regulation and the Commission's guidance before relying on a detail.
