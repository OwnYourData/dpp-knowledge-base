---
title: "CIRPASS-2 reference architecture: where our tools fit"
description: The EU project CIRPASS-2 describes what a complete DPP system consists of – roles, building blocks and 25 recommendations. This article shows which roles our tools take in it, which recommendations they follow, where they take another route and what is still missing.
section: Concepts
order: 4
audience: DPP service providers, developers, architects
last_reviewed: 2026-10-17
image: /assets/img/reference-architecture-roles.svg
image_alt: "The roles of the CIRPASS-2 reference architecture and what fills each of them here. Responsible economic operator: DPP Manager and product types in SOyA. DPP service providers: the DPP Service of OwnYourData and the custodian of DID FlexCo; a back-up provider is not appointed yet. End users and independent operators: any phone for the public part, repairers and recyclers with an access grant for more. Other actors: DPP Linter, DPP Service Validator, criteria catalogue. Credentials agencies: access grants signed by the operator or by a listed authority issuer; eIDAS role credentials not used yet. Public authorities: EU registry and web portal, not connected yet. Underneath: OYDID and SOyA as shared building blocks."
image_caption: "The roles of the CIRPASS-2 reference architecture, and what fills each of them here. Dashed: not connected or not covered yet."
image_width: 960
image_height: 640
cta:
  title: Follow one passport through the architecture
  text: The DPP Linter reads a passport the way any reader does – through the link on the product, without an account – and checks the content binding and the data model on the way.
  buttons:
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
    - label: Read the reference architecture
      url: "https://doi.org/10.5281/zenodo.15388412"
further:
  - title: CIRPASS-2, D4.1 Reference Architecture, version 1.1 (June 2026)
    url: "https://doi.org/10.5281/zenodo.15388412"
    what: roles, building blocks, 25 recommendations; CC BY 4.0
  - title: CIRPASS-2 at DIGITALEUROPE
    url: "https://www.digitaleurope.org/projects/digital-product-passports-cirpass-2/"
    what: the project and its pilots
  - title: Identifiers, version chain and integrity
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Integrity.md"
    what: content binding of the public and the controlled part in detail
  - title: Access classes – technical reference
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/AccessClasses.md"
    what: classes, policies, grants and the access log, endpoint by endpoint
related:
  - dpp-service
  - dpp-manager
  - public-availability
  - role-based-access
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- **CIRPASS-2** is the EU project that prepares the Digital Product Passport for use at scale. Its **reference architecture** describes the roles in a DPP system, the building blocks each role needs and 25 recommendations.
- Our tools fill three roles: the **responsible economic operator** (DPP Manager), the **DPP service provider** (the DPP Service of OwnYourData, with the custodian of DID FlexCo) and **other actors** that check passports and services (DPP Linter, DPP Service Validator).
- Most recommendations that concern these roles are followed as written. Two are met **by other means**: one controlled part instead of one document per role, and a hash in the passport identifier's log instead of a passport signed as a Verifiable Credential.
- **Still missing:** a back-up provider, credentials from trusted bodies, updates by third parties, a change of responsible operator and the connection to the EU registry.
</div>

## What the reference architecture is

The [law and the standards]({{ '/laws-and-standards/' | relative_url }}) say what a passport system must achieve and how single pieces work: the identifier, the data carrier, the API, the data model. Neither says how the systems of many companies fit together, so that a customs officer, a repair shop and a consumer can all use them.

That is what the CIRPASS projects work on. The first CIRPASS project proposed a DPP system architecture in March 2024. Its successor, **CIRPASS-2**, runs from May 2024 to April 2027 under the Digital Europe Programme, with almost 50 partners and pilots in textiles, electronics, tyres and construction. Its deliverable **D4.1 Reference Architecture**, version 1.1 of June 2026, describes the whole system.

When we designed our tools, the CIRPASS architecture work was one of our main references. This article holds them against the latest version.

D4.1 is guidance – not law and not a standard. Its recommendations were written before the European DPP standards were published, on the basis of their drafts, and it says so itself.

## Web links first, DIDs on top

The first CIRPASS proposal described two parallel architectures: one based on ordinary web links, one based entirely on decentralised identifiers (DIDs). CIRPASS-2 recommends the **web-based one only**, because a reader must reach a passport with nothing but a browser. DIDs may be used **in addition**.

That is the split used here:

- The data carrier holds an ordinary **web link** on the operator's own domain. Scanning it returns the passport – no app, no account, no DID resolver.
- Each passport also has a **`did:oyd`** as its passport identifier. Readers do not need it, but its signed log records where the passport is kept and a hash of its content. See [Public availability]({{ '/public-availability/' | relative_url }}).

## Roles: who does what

| Role in CIRPASS-2 | Here |
|---|---|
| **Responsible economic operator** – creates the passport and is legally responsible for it | the company that runs the **DPP Manager** on its own computer |
| **DPP service provider** – provides DPP services on the operator's behalf | **OwnYourData** runs the **DPP Service**; the data intermediary of **DID FlexCo**, a separate organisation, is the **custodian** that keeps the passport under a mandate |
| **End user, independent operator** – reads, repairs, recycles | anyone with a phone; repair shops and recyclers with an **access grant** |
| **Credentials agency** – issues credentials for identities and roles | access grants from the operator, or from authority issuers the DPP Service lists |
| **Public authority** – registry, web portal, customs, market surveillance | run by the EU and the member states |
| **Other actors** – services that use passport data | the **DPP Linter**, the **DPP Service Validator** and the **criteria catalogue** |

D4.1 allows one party to take several roles and one role to be split among several parties. Here the service provider role is split on purpose: the party that offers the API is not the party that holds the data.

## Building blocks

D4.1 lists, for each role, the functions it has to cover and the building blocks that do the work. For the responsible economic operator and the service provider, the picture here is:

| Function in D4.1 | Here | Status |
|---|---|---|
| Identify and collect the data | product types from any SOyA repository, filled in the DPP Manager's form or from a JSON file | yes |
| Link the passport to the product | the passport identifier is minted on the operator's machine; the product identifier is a GS1 Digital Link; the DPP Manager records which data carriers the legal act permits, the code itself comes from the operator's labelling | partly |
| Publish | the DPP Manager submits through the DPP Service; the custodian serves the result – JSON to software, a readable page to a browser | yes |
| Provide access | access policies, classes and grants in the DPP Service, which joins the public and the controlled part for each reader | yes |
| Update, including deactivation | the lifecycle API of EN 18222:2026; every version kept | yes |
| Redirection *(optional in D4.1)* | not needed – the operator's DNS points the name in the link at the custodian | differently |
| Portability | change of custodian; passport identifier and printed link stay the same | yes |
| Notifications *(optional)*, back-up, switch of responsible operator | – | not yet |

For the other roles: any phone camera is the data carrier scanner, the DPP Linter does a full check, and access grants take the place of credentials until eIDAS role credentials are available. The registry, the web portal and compliance checking belong to the EU. The DPP Service offers the registry method of EN 18222, but it is not connected to the EU registry yet and says so in its answer instead of inventing a registration number.

## The recommendations

The 25 recommendations are where D4.1 becomes concrete. Those that concern our tools:

| Recommendation | Here | Status |
|---|---|---|
| 3.1 JSON-LD as the default exchange format | passports in the JSON of EN 18223, with a dictionary reference per data element; the data models in SOyA are JSON-LD | partly |
| 3.2 Modular DPP templates | product types in SOyA: one base structure, overlays for labels, validation and transformation, SHACL shapes for checking | yes |
| 3.3 Extend the standard lifecycle API | all methods of EN 18222:2026, plus custodian change, access policies, grants and the access log | yes |
| 3.7 Generic roles, role-based access | three ordered classes – public, legitimate interest, authority – and signed grants valid for at most a year, the interim path D4.1 itself describes until eIDAS credentials are common | yes |
| 3.8 Structure passports for role-based access | public and controlled part, bound by a hash – see below | differently |
| 3.10 Passport as a Verifiable Credential | a hash of the content in the identifier's signed log instead of a signature on the document | differently |
| 3.11 Immutable records | every version kept and readable by date; the identifier's log only grows | yes |
| 3.16 Resolution by the responsible operator | the link is on the operator's own domain; its DNS decides which custodian answers | yes |
| 3.20 Item-level identifiers where updates are expected | serial number in the Digital Link | yes |
| 3.25 Display for people | a readable page for browsers; EU display templates do not exist yet | partly |

Two things go further than D4.1 asks: every read of controlled data is **logged** and visible to the operator, and the DPP Service Validator **checks DPP services every day** against an open criteria catalogue and publishes the results.

## Public and protected data, bound together

Recommendation 3.8 is the closest match – and the clearest difference. CIRPASS-2 suggests publishing the public data as one signed document and each role's protected data as a separate signed document that carries the hash of the public one.

{% include figure.html src="/assets/img/reference-architecture-binding.svg" alt="Left, the CIRPASS-2 recommendation: a public passport names the endpoints of data sets per role; each data set carries the hash of the public passport. Right, the implementation here: the DID document of the passport carries the hash of the public card; the public card carries a salted digest of one controlled card with every attribute that is not public; the DPP Service gives each reader only the classes it may read." caption="Same goal, other direction: here the public part names the protected part, and the passport identifier names the public part." width="960" height="400" %}

Here there is **one controlled part** with every attribute that is not public, and the DPP Service hands each reader only the classes it may read. The binding runs the other way:

- The **public card** – what the link on the product returns – carries a salted digest of the controlled part. Any change to protected data changes the public card.
- The **passport identifier** carries the hash of the public card in its signed log. A reader who hashes what it received and compares knows the content is what the operator committed – for the public part directly, for the protected part through the digest.

The result is one entry point, no copies per role, and an integrity check that needs nothing but public web requests. What it does not give is a signature on the passport document itself, as recommendation 3.10 asks.

## What is still open

> - **Back-up.** The law requires a back-up copy kept by a DPP service provider. None is appointed yet for the passports served here (recommendation 3.15).
> - **Credentials from trusted bodies.** Operators are identified by a self-issued `did:oyd`, and roles by access grants. Credentials from trusted bodies, eventually under eIDAS, are not used yet (3.6, 3.9). The identifier's log is self-managed rather than anchored with a trusted third party (3.13).
> - **Updates by third parties.** Repair shops and recyclers can read with a grant but cannot add to a passport, so update receipts do not arise yet (3.12).
> - **Change of responsible operator.** Handing a passport to a new responsible operator is not supported.
> - **EU registry.** The registry method is in place; the connection to the EU registry is not.
{: .open}

This comparison reflects the state of 17 October 2026. D4.1 is published under CC BY 4.0; the pictures here are our own drawings after its role model.
