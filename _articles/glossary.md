---
title: "Glossary: Digital Product Passport terms"
description: The terms that come up again and again around Digital Product Passports – from access class to working plan – each explained in a few sentences, with a link to the article that goes deeper.
section: Basics
order: 5
audience: everyone working with Digital Product Passports
last_reviewed: 2026-10-17
image: /assets/img/glossary-map.svg
image_alt: "A product, as model, batch or item, carries a data carrier such as a QR code. It holds the unique product identifier, a web link, which leads to the passport with its DPP identifier, header and data elements, kept by a custodian. The economic operator writes through the lifecycle API of a DPP service. The EU DPP registry records the identifiers and where each passport is kept. Readers get the public part, and more according to access class and access grant."
image_caption: "How the main terms fit together."
image_width: 960
image_height: 304
cta:
  title: Missing a term?
  text: The Knowledge Base is open. Suggest a term or a better explanation as an issue or pull request.
  buttons:
    - label: Suggest a term
      url: "https://github.com/OwnYourData/dpp-knowledge-base/issues"
further:
  - title: Regulation (EU) 2024/1781 (ESPR), Article 2
    url: "https://eur-lex.europa.eu/eli/reg/2024/1781/oj"
    what: the legal definitions behind many of these terms
related:
  - what-is-a-digital-product-passport
  - laws-and-standards
  - public-availability
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- Short, plain explanations of the terms used in this Knowledge Base, in alphabetical order.
- Where a law or standard defines a term, the explanation paraphrases it; the binding wording is in the source.
- Each entry links to the article that explains the topic in full.
</div>

## A

Access class
: A label that says who may read an attribute of a passport. The DPP Service uses three ordered classes: *public*, *legitimate interest* and *authority*. See [Role-based access]({{ '/role-based-access/' | relative_url }}).

Access grant
: A signed statement that lets one reader, identified by its DID, read certain passports in certain access classes. Valid for at most a year and revocable at any time.

Access log
: The record the DPP Service keeps of every read of controlled data, every refused attempt, every grant and every revocation – never the content itself.

Annex ZA
: The annex of a harmonised standard that lists which requirements of the regulation the standard covers – and so how far the presumption of conformity reaches.

## B

Back-up copy
: A copy of a passport kept by a second, independent DPP service provider, so that the passport survives if the main one fails. The ESPR asks for it; EN 18221 describes how it works. See [Who keeps the passport?]({{ '/custodians-and-back-up/' | relative_url }}).

Battery passport
: The passport required by the Battery Regulation (EU) 2023/1542 from 18 February 2027 for electric-vehicle batteries, batteries for light means of transport and industrial batteries above 2 kWh. See [Battery passport]({{ '/battery-passport/' | relative_url }}).

## C

CIRPASS-2
: The EU project that prepares the Digital Product Passport for use at scale. Its reference architecture describes the roles and building blocks of a complete DPP system. See [CIRPASS-2 reference architecture]({{ '/reference-architecture/' | relative_url }}).

Content binding
: Recording a hash of a passport's content in the signed log of its DPP identifier, so that anyone can check that what they receive is what the operator published. See [Public availability]({{ '/public-availability/' | relative_url }}).

Controlled part
: The part of a passport with every attribute that is not public. It is handed out only to readers whose access class allows it. Its counterpart is the *public part*.

Criteria catalogue
: The open repository *dpp-criteria*, which turns legal and standard requirements into checkable criteria. See [The DPP criteria catalogue]({{ '/dpp-criteria/' | relative_url }}).

Custodian
: The party that keeps a passport and serves its public part on the link on the product, under a mandate from the economic operator – a DPP service provider, or the operator itself. See [Who keeps the passport?]({{ '/custodians-and-back-up/' | relative_url }}).

## D

Data carrier
: What sits on the product, its packaging or its documents and holds the unique product identifier: a QR code, an NFC chip or an RFID tag. Covered by EN 18220.

Data element
: One piece of passport content below the header, such as the carbon footprint or a spare-part list. Which data elements a passport needs is decided per product group.

Delegated act
: An act of the Commission that supplements a regulation. Under the ESPR, one delegated act per product group decides what its passport contains, who may see it and from when – at the earliest 18 months after the act enters into force. See the [roadmap]({{ '/dpp-roadmap/' | relative_url }}).

DID (decentralised identifier)
: An identifier, standardised by the W3C, that resolves to a document controlled by its holder. Here, `did:oyd` is used for passport identifiers and for the identities of operators and readers.

Digital Product Passport (DPP)
: A set of data about one product – model, batch or item – that can be reached electronically through a data carrier on the product. See [What is a Digital Product Passport?]({{ '/what-is-a-digital-product-passport/' | relative_url }})

DPP identifier
: The identifier of the passport itself, as opposed to the identifier of the product. Here it is a `did:oyd`, whose signed log records where the passport is kept and a hash of its content.

DPP service
: A system that offers the lifecycle API for passports. The [DPP Service]({{ '/dpp-service/' | relative_url }}) of OwnYourData is one open implementation.

DPP service provider
: A company that keeps or serves passports on behalf of an economic operator. The Commission plans rules for such providers, including certification, for 2027.

## E

Economic operator
: The company that places a product on the EU market and is responsible for its passport. It can keep the passport itself or have a DPP service provider do it.

EN 18216 to EN 18246
: The eight European standards for the passport system, written by CEN and CENELEC in their joint technical committee JTC 24. See [Laws and standards]({{ '/laws-and-standards/' | relative_url }}).

ESPR
: The Ecodesign for Sustainable Products Regulation, (EU) 2024/1781. It sets the framework for passports for most product groups.

EU DPP registry
: The Commission's registry, live since 20 July 2026. It records unique identifiers and where each passport is kept – not the passport content.

## G

Granularity
: Whether a passport describes a product **model**, a **batch** or a single **item**. The delegated act for a product group decides which.

GS1 Digital Link
: A web address that carries GS1 keys, such as the product code after `/01/` and the serial number after `/21/`. Often used as the unique product identifier. See [QR code, GS1 Digital Link and unique identifiers]({{ '/product-identifiers/' | relative_url }}).

## H

Harmonised standard
: A European standard cited in the Official Journal under a regulation. Following it gives a presumption of conformity for the requirements it covers.

## I

Implementing act
: An act of the Commission that sets uniform conditions for applying a regulation – for example the rules for the EU registry, or the citation of the standards.

## L

Legitimate interest
: Under the Battery Regulation, the group of readers – such as repairers, second-life operators and recyclers – who may see more of a passport than the public. An implementing act is to define it.

Lifecycle API
: The interface defined in EN 18222 to create, read, update and end passports, and to read earlier versions.

## M

Mandate
: A signed statement by which an economic operator lets a custodian keep one passport at one storage place for a set time.

Market surveillance authority
: The national authority that checks whether products on the market comply with EU law. It gets access to the parts of a passport reserved for authorities.

## P

Presumption of conformity
: The legal effect of following a harmonised standard: the product or system is presumed to meet the requirements the standard covers, unless shown otherwise.

Public part
: The part of a passport that anyone can read through the link on the product, without an account. It carries a salted digest of the controlled part.

## S

SOyA
: The Semantic Overlay Architecture: a way to describe data models with a base structure and overlays for labels, validation and transformation. The DPP Manager uses it for product types.

## U

Unique product identifier (UPI)
: A string that identifies a product and at the same time works as a web link to its passport. Covered by EN 18219. See [QR code, GS1 Digital Link and unique identifiers]({{ '/product-identifiers/' | relative_url }}).

## W

Working plan
: The Commission's ESPR and Energy Labelling Working Plan 2025–2030, which sets the order in which product groups get delegated acts.
