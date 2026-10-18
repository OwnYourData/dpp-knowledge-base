---
title: "Research projects and initiatives around the Digital Product Passport"
description: The laws say that there will be passports, and the standards say how they are built. Around them, EU projects, standards bodies, industry alliances and national lighthouse projects test the passport in practice and publish what others can reuse – test environments, data models, ontologies and examples. Who they are, what they offer, and where to start.
section: Basics
order: 3.5
audience: product and compliance teams, DPP service providers, developers, researchers
last_reviewed: 2026-10-18
image: /assets/img/research-landscape.svg
image_alt: "Five groups. Specifications say what a passport looks like: the European standards EN 18216 and EN 18219 to 18223 from CEN/CENELEC JTC 24, the Asset Administration Shell release 26-01 of the IDTA, the GS1 Digital Link, the UN Transparency Protocol 0.8, W3C Verifiable Credentials 2.0, and OPC 30450-1, still a release candidate. EU projects try it out at scale: CIRPASS-2 with 49 partners and 13 pilots, CE-RISE, Catena-X and Eclipse Tractus-X, and Eclipse OSS4DPP, which has not launched yet. Tests and reference data: the BatteryPass-Ready test environment, the CIRPASS-2 test environment, the battery data model 2.0.1, the CIRPASS-2 ontologies and the UNTP playground. Public infrastructure: the EU DPP registry, live since 20 July 2026; registering passports and rules for DPP service providers are still pending. In Austria: the lighthouse projects PACE-DPP, where the tools of this knowledge base come from, and PASSAT, coordinated by AIT from 2025 to 2028, the Plattform Industrie 4.0 Österreich and the demonstrator of GS1 Austria."
image_caption: "Who works on what. Framed: the main reference in its group. Dashed: planned, pending or not yet open."
image_width: 960
image_height: 638
cta:
  title: Try a passport against the published standards
  text: The DPP Linter checks the passport behind any product identifier against criteria derived from EN 18219, EN 18223 and the regulations – free, without an account.
  buttons:
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
    - label: Browse the criteria
      url: "https://github.com/OwnYourData/dpp-criteria/blob/main/criteria/README.md"
further:
  - title: "CIRPASS-2: DPP Standardisation Initiatives & Projects around the World"
    url: "https://zenodo.org/records/20849016"
    what: the project's own, wider survey of initiatives worldwide
  - title: CIRPASS-2 open-source DPP catalogue
    url: "https://cirpass2.eu/open-source-dpp-catalogue/"
    what: open-source DPP software, with an open form for new entries
  - title: BatteryPass-Ready
    url: "https://thebatterypass.eu/battery-pass-ready/resources/"
    what: data model, test environment and guidance for the battery passport
  - title: Eclipse Open Source for the Digital Product Passport
    url: "https://dpp.eclipse.org/"
    what: the vendor-neutral open-source initiative being set up at Eclipse
related:
  - laws-and-standards
  - reference-architecture
  - battery-passport
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- **CIRPASS-2** is the EU's main project for passports at scale: 49 partners, 13 pilots in textiles, electronics, tyres and construction, until April 2027. It publishes a reference architecture, an open-source test environment and ontologies.
- **BatteryPass-Ready** prepares the battery passport due from 18 February 2027: a free test environment for passport systems and an openly licensed data model.
- **Standards and specifications** come from several bodies: the European standards of CEN/CENELEC JTC 24, the Asset Administration Shell of the IDTA, the GS1 Digital Link, the UN Transparency Protocol and W3C Verifiable Credentials.
- **The EU registry** has been live since 20 July 2026, but passports cannot be registered there yet.
- **In Austria,** PACE-DPP and PASSAT are the two lighthouse projects for the passport. The tools in this knowledge base come from PACE-DPP.
</div>

This article is about projects and initiatives, not about DPP services: who researches, tests and specifies the passport, and what they publish that others can use. It reflects the state of October 2026 and is a selection, not a complete list.

## At a glance

| Initiative | Who | What you can use | Licence |
|---|---|---|---|
| **CIRPASS-2** | 49 partners, Digital Europe Programme | reference architecture, open-source test environment, ontologies, catalogue of open-source software | software Apache-2.0, reports CC BY 4.0 |
| **BatteryPass-Ready** | Fraunhofer IPK with acatech, TU Berlin and GEFEG | test environment for battery passport systems, data model 2.0.1 | test environment free with an account; data model CC BY 4.0 |
| **CE-RISE** | Horizon Europe consortium | an open digital passport solution | EUPL-1.2 |
| **Catena-X / Eclipse Tractus-X** | Catena-X association, Eclipse Foundation | semantic models for the DPP and the battery passport, with example payloads | code Apache-2.0, models CC BY 4.0 |
| **Eclipse OSS4DPP** | Eclipse Foundation | not yet – an open-source initiative in preparation | – |
| **CEN/CENELEC JTC 24** | European standardisation | the European standards for passport systems | standards for purchase |
| **IDTA** | Industrial Digital Twin Association | Asset Administration Shell with DPP annexes, submodel templates, test engines | templates CC BY 4.0, test engines Apache-2.0 |
| **GS1** | GS1 global and national organisations | Digital Link, link type `gs1:dpp`, resolver test suite | standards free, test suite Apache-2.0 |
| **UNTP** | UNECE / UN/CEFACT | a passport data model as Verifiable Credentials, samples, playground, implementer register | specification CC BY 4.0 |
| **W3C VC Working Group** | World Wide Web Consortium | Verifiable Credentials 2.0; vocabularies for passports in its charter | W3C licence |
| **OPC Foundation** | OPC Foundation | OPC 30450-1, a passport information model for OPC UA | OPC specification licence |
| **EU DPP registry** | European Commission | the registry of passports and, later, of verified DPP service providers | – |
| **PACE-DPP** and **PASSAT** | Austrian lighthouse projects | tools, pilots, training material | varies |

## EU projects

**CIRPASS-2** is funded by the Digital Europe Programme and runs from May 2024 to April 2027, coordinated by CEA-List. Its 49 partners run 13 pilots in four value chains – textiles, electronics, tyres and construction – and test passports in real use. For anyone building a passport system, four of its results matter most:

- the **reference architecture**, with roles, building blocks and recommendations – how our tools fit into it is shown in [CIRPASS-2 reference architecture]({{ '/reference-architecture/' | relative_url }});
- an **open-source test environment** under Apache-2.0, with a mock of the EU registry, a validator and a renderer ([Zenodo](https://doi.org/10.5281/zenodo.20749604));
- **ontologies** for passport data, with SHACL views per access level, so that a check can tell what each group of readers may see ([documentation](https://cirpass-2.github.io/ontologies-docs/));
- a **catalogue of open-source DPP software** – 51 entries in October 2026, with an open form for new ones – and a **Community of Practice**, mostly providers of DPP software and services.

CIRPASS-2 has also surveyed the field itself. Its report [DPP Standardisation Initiatives & Projects around the World](https://zenodo.org/records/20849016) is wider than this article and covers initiatives outside Europe.

**CE-RISE**, a Horizon Europe project, publishes an [open digital passport solution](https://solution.ce-rise.eu/) under the EU Public Licence (EUPL-1.2), with its code on Codeberg.

Earlier projects have ended or gone offline: CircThread, TRICK and DigiPrime. The Digital Product Pass app of Eclipse Tractus-X was archived in October 2025.

## Batteries: the first passport due

The battery passport is the first one with a fixed date: 18 February 2027, for light means of transport, industrial batteries above 2 kWh and electric vehicle batteries. That is why the most concrete test tools exist here. What the regulation requires is in [Battery passport]({{ '/battery-passport/' | relative_url }}).

**BatteryPass-Ready** is led by Fraunhofer IPK together with acatech, TU Berlin and GEFEG, with more than 100 associated partners. It offers:

- a **[test environment](https://batterypass-ready.gefeg.com/)**, live since June 2026 and free with an account. It runs eleven test scenarios in three use cases against a passport system – the lifecycle API of EN 18222 in the roles of economic operator, main and back-up DPP service provider – and validates the data. Since 16 October 2026, a confirmation run produces a PDF report. The code of the test environment is not open.
- a **[data model](https://thebatterypass.eu/battery-pass-ready/resources/)**, version 2.0.1 under CC BY 4.0: JSON schemas per battery category with the passport header of the European standards, and a variant for the obligations from 18 February 2027.

The Commission has added a guide of its own: [Digital Batteries Passport – data points by category](https://single-market-economy.ec.europa.eu/document/download/cd1e5e6c-4a4a-4b99-995a-49eb6916187e_en?filename=Digital%20Batteries%20Passport%20-%20data%20point%20by%20category.pdf), with 71 data points, published on 15 August 2026.

**Catena-X**, the data ecosystem of the automotive industry, works on passports inside its data space. Eclipse Tractus-X publishes its [semantic models](https://github.com/eclipse-tractusx/sldt-semantic-models) – among them the Digital Product Passport 7.0.0 and the Battery Pass 6.1.0, with example payloads – and the [Industry Core Hub](https://github.com/eclipse-tractusx/industry-core-hub). Passports exchanged there are not public. Applications can be certified for Catena-X through its marketplace – the only certification of DPP applications we found in the German-speaking countries, and a private one.

## Open source: Eclipse OSS4DPP

At the Eclipse Foundation, an initiative called **[Open Source for the Digital Product Passport](https://dpp.eclipse.org/)** is being prepared. It is vendor-neutral and has not launched yet: there is no working group and no project so far, and no deliverables have been agreed. The ideas under discussion include a reusable API building block with an OpenAPI definition, a modular test engine with shared test data and sample passports, and test profiles for the rules of individual product groups. Community meetings took place in September 2026.

## Standards and specifications

**CEN/CENELEC JTC 24** wrote the European standards for passport systems. Six of them – EN 18216 and EN 18219 to EN 18223 – are cited in the Official Journal; EN 18239 and EN 18246 are published, but not yet cited. The committee publishes the standards, not OpenAPI files or schemas. What each standard covers is in [Laws and standards]({{ '/laws-and-standards/' | relative_url }}).

Several other bodies specify how passports are modelled, linked and signed:

- **IDTA** – the Industrial Digital Twin Association maintains the Asset Administration Shell. Its release 26-01 has [annexes for the DPP](https://industrialdigitaltwin.io/aas-specifications/IDTA-01002/v3.2/annex/dpp.html) that map it to EN 18222 and EN 18223, and submodel templates for a DPP and a digital battery passport. The [aas-test-engines](https://github.com/admin-shell-io/aas-test-engines) check a server against a profile.
- **GS1** – the Digital Link (ISO/IEC 18975) puts the product code into a web link, and the link type `gs1:dpp` marks the passport among the links of a product. GS1 has a provisional application standard for the DPP, a [resolver test suite](https://github.com/gs1/GS1DL-resolver-testsuite) and demonstrators such as [dpp.gs1.at](https://dpp.gs1.at/); it does not host passports. More in [QR code, GS1 Digital Link and unique identifiers]({{ '/product-identifiers/' | relative_url }}).
- **UNTP** – the [UN Transparency Protocol](https://untp.unece.org/) of UN/CEFACT models the passport as a set of Verifiable Credentials. Version 0.8.0 comes with sample credentials, a playground and a register of implementers, 26 in October 2026, with conformance observations planned.
- **W3C** – the Verifiable Credentials Working Group maintains the [VC Data Model 2.0](https://www.w3.org/TR/vc-data-model-2.0/); its charter for 2026 to 2028 includes vocabularies for Digital Product Passports.
- **OPC Foundation** – OPC 30450-1 is an information model for passports in OPC UA, a release candidate since 8 July 2026.

These specifications do not always agree with each other, and implementations read the same standard differently. That is one reason why our [DPP criteria catalogue]({{ '/dpp-criteria/' | relative_url }}) names the clause behind every requirement.

## Public infrastructure: the EU registry

The **EU DPP registry** has been live since 20 July 2026, under Implementing Regulation (EU) 2026/1778. It will record the unique identifiers of products, and customs check them at the border. Using it needs an EU Login and a qualified electronic seal. According to its user guide of September 2026, passports cannot be registered yet, because the semantic catalogue they are checked against does not exist for any product group, and batteries cannot be registered at all yet.

The same Implementing Regulation foresees a **list of verified DPP service providers** in the registry. "Verified" means a check of identity under eIDAS, valid for at most three years – not a check of the service. Requirements for DPP service providers, possibly with certification, are to follow in a delegated act; it has not been adopted.

## In Austria

Austria funds two lighthouse projects for the passport:

- **PACE-DPP** – the project behind the DPP Manager, the DPP Service, the DPP Linter and this knowledge base. It is funded by the Austrian Federal Ministry of Innovation, Mobility and Infrastructure (BMIMI) through the Austrian Research Promotion Agency (FFG), and by the German Federal Ministry of Research, Technology and Space (BMFTR) through the DLR Projektträger.
- **PASSAT** – [Digital Product Passport Austria and Beyond](https://www.ait.ac.at/en/research-topics/cooperative-digital-technologies/projects/passat), coordinated by the AIT Austrian Institute of Technology from February 2025 to January 2028. AIT and 19 partners, among them GS1 Austria, Salzburg Research, Fraunhofer Austria and the Verein Industrie 4.0 Österreich, pilot the passport in textiles, electronics and the ski industry.

The **[Plattform Industrie 4.0 Österreich](https://plattformindustrie40.at/digitaler-produktpass-2/)** connects them. It is a partner in CIRPASS-2 and holds regular "DPP Check-Ins", where projects and providers present their work.

## Still open

> - **No open test suite for the passport API.** Several open implementations of EN 18222 exist, but no openly published test suite against which any of them can be checked. BatteryPass-Ready tests systems but does not publish its code; Eclipse OSS4DPP plans a test engine.
> - **No quality mark for DPP service providers.** The delegated act with requirements for providers has not been adopted. Until then, every claim of conformity is the provider's own.
> - **The EU registry** is live, but not yet open for the registration of passports.
{: .open}

This article gives an overview; it is not legal advice. It reflects the state of 18 October 2026. Numbers such as partners, entries and members are those published by each initiative at that time.
