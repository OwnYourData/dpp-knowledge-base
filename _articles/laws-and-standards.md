---
title: "Laws and standards behind the Digital Product Passport"
description: Which EU regulations require passports, what delegated and implementing acts add, and which eight European standards say how passport systems are built – with the state of each as of October 2026.
section: Basics
order: 3
audience: compliance and product teams, DPP service providers, developers
last_reviewed: 2026-10-16
image: /assets/img/laws-layers.svg
image_alt: "Four layers. EU regulations say that there is a passport and how the system works: ESPR 2024/1781, batteries 2023/1542, construction products 2024/3110, toys 2025/2509, detergents 2026/405. Delegated acts say what goes in, who sees it and from when, per product group: iron and steel expected Q4 2026, textiles, tyres and aluminium 2027, furniture 2028, mattresses 2029, DPP service providers 2027. Implementing acts set up the EU registry (2026/1778) and cite the standards (2026/1736); battery access rules are pending. Harmonised standards say how systems are built: EN 18216, 18219, 18220, 18221, 18222, 18223 cited; EN 18239 and 18246 published, not yet cited."
image_caption: "Four layers of rules. Solid: in force, adopted or cited. Dashed: planned, pending or not yet cited."
image_width: 960
image_height: 524
cta:
  title: Check a passport against the published standards
  text: The DPP Linter checks the passport behind any product identifier against EN 18219 and EN 18223 – free, without an account.
  buttons:
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
    - label: Browse the criteria
      url: "https://github.com/OwnYourData/dpp-criteria/blob/main/criteria/README.md"
further:
  - title: Regulation (EU) 2024/1781 (ESPR)
    url: "https://eur-lex.europa.eu/eli/reg/2024/1781/oj"
    what: Chapter III, Articles 9 to 15
  - title: Regulation (EU) 2023/1542 (batteries)
    url: "https://eur-lex.europa.eu/eli/reg/2023/1542/oj"
    what: Articles 77 and 78, Annex XIII
  - title: Implementing Regulation (EU) 2026/1778
    url: "https://eur-lex.europa.eu/eli/reg_impl/2026/1778/oj"
    what: the EU DPP registry
  - title: Implementing Decision (EU) 2026/1736
    url: "https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32026D1736"
    what: the six cited standards
  - title: Regulation (EU) 2024/3110 (construction products)
    url: "https://eur-lex.europa.eu/eli/reg/2024/3110/oj"
    what: Chapter X, Articles 75 to 80
related:
  - what-is-a-digital-product-passport
  - dpp-roadmap
  - dpp-criteria
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- **Regulations** decide that a product group gets a passport and how the system works: the Ecodesign Regulation (ESPR) for most products, and own regulations for batteries, construction products, toys and detergents.
- **Delegated acts** fill in each product group: what goes into the passport, who may see it and from when. For ESPR products, none has been adopted yet.
- **Implementing acts** set up what everybody shares: the EU registry, live since 20 July 2026, and the citation of the standards.
- **Eight European standards** say how passport systems are built. Six are cited in the Official Journal and give a presumption of conformity; two were published in September 2026 and are not cited yet.
- Following the standards is voluntary. The legal obligations come from the regulations and delegated acts.
</div>

## Four layers, four questions

The rules for Digital Product Passports are not in one place. They come in four layers, each answering a different question:

1. **Regulations** answer *whether*: which kinds of products can have a passport, and the principles every passport system must follow.
2. **Delegated acts** answer *what*: for one product group, which data the passport holds, who may read which part and from which date it is required.
3. **Implementing acts** answer *where*: the shared EU infrastructure, above all the registry that records where each passport can be found.
4. **Harmonised standards** answer *how*: identifiers, data carriers, APIs, data model, storage and security, in enough technical detail to build a system.

For an economic operator, the passport becomes an obligation only when the second layer exists for its product group. The other three layers are already in place – which is why passport systems can be built today.

## The Ecodesign Regulation: the framework

The Ecodesign for Sustainable Products Regulation (ESPR), Regulation (EU) 2024/1781, in force since 18 July 2024, sets out the passport in its Chapter III:

| Article | What it settles |
|---|---|
| 9 | the passport in general: a delegated act decides whether a product group needs one, which information it contains, whether it describes a model, a batch or an item, and how long it stays available |
| 10, 11 | requirements and operation: a data carrier on the product, linked to a persistent unique product identifier; open, interoperable, machine-readable formats; free access; access rights per group of readers; a back-up copy kept by a DPP service provider; security and integrity of the data |
| 12 | unique identifiers for products, economic operators and facilities |
| 13 | the EU registry of identifiers |
| 14 | a public web portal to search and compare passport data |
| 15 | customs: products with a passport are released only once their registration in the registry is confirmed |

The ESPR names no product and no date. Those come with each delegated act, which may apply at the earliest 18 months after it enters into force. Which product group is due when is tracked in the [roadmap]({{ '/dpp-roadmap/' | relative_url }}).

## Regulations with their own passport

Some product groups do not wait for an ESPR delegated act. Their own regulation contains the passport:

| Product group | Regulation | Passport provisions | Passport required |
|---|---|---|---|
| Batteries | (EU) 2023/1542 | Articles 77, 78 and Annex XIII | from 18 February 2027 |
| Construction products | (EU) 2024/3110 | Chapter X, Articles 75 to 80 | product family by product family, through delegated acts |
| Toys | (EU) 2025/2509 | Chapter V, Articles 19 to 24 | the regulation applies from 1 August 2030 |
| Detergents | (EU) 2026/405 | Chapter V, Articles 21 to 25 and Annex VI | the regulation applies from 23 September 2029 |

They follow the same model as the ESPR – data carrier, unique identifier, registry, customs check – so the same kind of passport system can serve all of them. The battery passport is the first to become mandatory; its content is already fixed in Annex XIII.

## The standards: how systems are built

With standardisation request M/604, the Commission asked CEN and CENELEC for European standards for the passport system. Their joint technical committee JTC 24 delivered eight:

| Standard | Covers | Status |
|---|---|---|
| EN&nbsp;18216:2026 | data exchange protocols | cited |
| EN&nbsp;18219:2026 | unique identifiers | cited |
| EN&nbsp;18220:2026 | data carriers | cited |
| EN&nbsp;18221:2026 | data storage, archiving and data persistence | cited |
| EN&nbsp;18222:2026 | APIs for lifecycle management and searchability | cited |
| EN&nbsp;18223:2026 | system interoperability – the data model | cited |
| EN&nbsp;18239:2026 | access rights management, information system security and business confidentiality | published, not yet cited |
| EN&nbsp;18246:2026 | data authentication, reliability and integrity | published, not yet cited |

{% include figure.html src="/assets/img/standards-path.svg" alt="Five steps from the product to its data, each with its standard: data carrier – EN 18220; unique identifier – EN 18219; exchange protocols and lifecycle API – EN 18216 and EN 18222; passport data – EN 18223; storage, versions and back-up – EN 18221. Below, spanning all steps: EN 18239 for access rights and security, EN 18246 for authentication and integrity, both dashed as not yet cited." caption="Each standard covers one step on the way from the product to its data; two apply across all of them." width="960" height="356" %}

The first six were published on 27 May 2026 and cited in the Official Journal by Implementing Decision (EU) 2026/1736 in July 2026. EN 18239 and EN 18246 followed on 16 September 2026.

**What "cited" means.** A standard cited in the Official Journal is a *harmonised standard*. A system that follows it is presumed to meet the requirements of the regulation that the standard covers. Which requirements those are is listed in Annex ZA of each standard – and the list is precise. EN 18221, for example, covers how a back-up copy works, but states that following it does not by itself establish that a back-up exists.

**What "not yet cited" means.** EN 18239 and EN 18246 are complete, published standards and can be applied today. Until they are cited, following them gives no presumption of conformity for access rights, security or integrity.

Using the standards is voluntary. A system can meet the regulation in another way – but then has to show that it does.

## Implementing acts: the shared infrastructure

**The EU registry.** Implementing Regulation (EU) 2026/1778 sets up the EU DPP registry, which has been live since 20 July 2026. It records unique identifiers, the commodity code and a reference to the DPP service provider – not the content of the passport. Economic operators enrol with a qualified electronic seal or signature under the eIDAS Regulation. Customs check the registration before a product is released.

**The citation of standards.** Implementing Decision (EU) 2026/1736 is the act that turned the first six standards into harmonised standards for the ESPR.

## Still open

> - **Delegated acts for ESPR product groups.** Iron and steel is expected in Q4 2026, the next groups from 2027. None has been adopted yet.
> - **Access rules for the battery passport.** The rules on who has a legitimate interest, and what such readers may see, were due by 18 August 2026 and have not been adopted.
> - **Rules for DPP service providers.** The ESPR allows the Commission to set requirements for DPP service providers, including certification. The Commission plans this delegated act for 2027. Until then, no provider can be certified.
> - **Citation of EN 18239 and EN 18246** in the Official Journal.
{: .open}

## How our tools follow the rules

The OwnYourData tools are built on the published standards, and each of them states which ones:

- The [DPP Service]({{ '/dpp-service/' | relative_url }}) implements the lifecycle API of EN 18222 and serves passports in the data model of EN 18223.
- The [DPP Linter]({{ '/dpp-linter/' | relative_url }}) checks a passport's identifier and data model against EN 18219 and EN 18223.
- The [criteria catalogue]({{ '/dpp-criteria/' | relative_url }}) names, for every check, the regulation or standard and the exact clause it comes from.

This article explains the rules; it is not legal advice. It reflects the state of 16 October 2026 – for binding text, use the acts on EUR-Lex linked below.
