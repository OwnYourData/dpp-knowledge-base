---
title: "Who keeps the passport? Custodians, data intermediaries and back-up copies"
description: A passport has to be readable for the life of the product – often longer than the company that made it, and certainly longer than any contract with a service provider. Who holds the data, on what authority, what a back-up copy is for, and what happens when a provider stops.
section: Concepts
order: 2.5
audience: economic operators, DPP service providers, compliance teams
last_reviewed: 2026-10-17
image: /assets/img/custody-roles.svg
image_alt: "Four roles. The economic operator is responsible for the passport, holds its keys and owns the domain on the product – with the DPP Manager. It submits the passport to the DPP Service of OwnYourData, which offers the EN 18222 API, the index, access classes and grants. It signs a mandate for the custodian – one passport, one collection, at most 90 days, revocable – and the DPP Service writes under that mandate. The custodian, the data intermediary of DID FlexCo, keeps the passport in the operator's collection and answers the link on the product, which readers open. Dashed: a back-up provider keeping a second copy, not appointed for these passports yet. Both providers act on the operator's behalf; the responsibility stays with the operator."
image_caption: "Who does what. Dashed: not in place yet."
image_width: 960
image_height: 400
cta:
  title: Keep your passports where you choose
  text: The DPP Manager keeps your keys on your own computer and signs a mandate for each passport. Change the custodian later without reprinting a single label.
  buttons:
    - label: Getting started
      url: "/kb/getting-started/"
    - label: Get the DPP Manager
      url: "https://github.com/OwnYourData/dpp-manager-public"
further:
  - title: Regulation (EU) 2024/1781 (ESPR)
    url: "https://eur-lex.europa.eu/eli/reg/2024/1781/oj"
    what: Articles 2, 10 and 11 – DPP service providers and the back-up copy
  - title: Regulation (EU) 2022/868 (Data Governance Act)
    url: "https://eur-lex.europa.eu/eli/reg/2022/868/oj"
    what: Articles 10 to 12 – data intermediation services and their conditions
  - title: Identifiers, version chain and integrity
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Integrity.md"
    what: how a reader checks that a custodian serves unchanged content
related:
  - public-availability
  - product-identifiers
  - reference-architecture
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- The **economic operator** is responsible for its passports. It can keep them itself or have a **DPP service provider** do it – the responsibility stays with the operator.
- Here, two providers share that role: the **DPP Service** offers the API, the **custodian** keeps the data and answers the link on the product. The custodian is a **data intermediary** – a separate organisation that does not use the data for anything else.
- The custodian acts on a **mandate**: one signed statement per passport, for one collection, for a limited time, revocable.
- A **back-up copy** at a second provider keeps a passport available if the main one fails. The ESPR asks for it; EN 18221 says how it works. For the passports served here, none is appointed yet.
- What makes a provider replaceable is decided early: **your own domain** on the product and **your own keys**.
</div>

## The roles

| Role | Who | What it does |
|---|---|---|
| **Economic operator** | the company that places the product on the market | is responsible for the passport – its content, its accuracy, its availability |
| **DPP service provider** | an independent third party authorised by the operator | processes passport data to make it available to those with a right to access it |
| **Custodian** | here: the data intermediary of DID Daten-Intermediär-Dienste FlexCo | keeps the passport and answers the link on the product |
| **Back-up provider** | a second, independent DPP service provider | keeps a copy so the passport survives the failure of the first |

"Custodian" is our word for the provider that holds the data. The ESPR speaks of DPP service providers and lets the passport be stored either by the operator itself or by such providers (Article 11). EN 18221 adds the back-up DPP service provider for the second copy. EN 18219 puts it plainly: the operator records and keeps its identifiers either directly or through a DPP service provider – the duty is the operator's either way.

## Why the data sits with a separate party

Many systems keep everything in one place: the same provider runs the API, stores the passports and serves them. Here those jobs are split on purpose:

- **OwnYourData** runs the DPP Service: the API of EN 18222, the index of passports, access classes and grants.
- **DID FlexCo**, a separate organisation, runs the custodian: it keeps the passport in a collection that belongs to the operator and answers the link on the product.

Two sets of rules apply:

- **Every DPP service provider** may not sell, reuse or process passport data beyond what the storing or processing service needs, unless the operator has agreed to it (ESPR, Article 11).
- **A data intermediary** goes further. The custodian here is registered as one under the Data Governance Act, and Article 12 of that Act sets its conditions: it may not use the data for any purpose other than making them available, it has to run the service through a separate legal person, it must have mechanisms to keep the service going and let data holders retrieve their data if it becomes insolvent, and it keeps a log of its activity.

Whether keeping passports alone already counts as data intermediation under the Act is an open legal question. The custodian applies the conditions of Article 12 anyway, as a matter of design.

The result: the party that holds the data has no business interest in it, and the party that offers the API holds no data of its own beyond the index.

## The mandate: authority for one passport

The custodian does not get a password or a general account. It gets a **mandate** – a statement signed with the operator's identity key:

- **one passport** – the mandate names it, and only it;
- **one collection** – the place at the custodian that belongs to the operator;
- **a limited time** – the DPP Manager signs mandates for 90 days and renews them with one signature;
- **create, update, delete** – what the DPP Service may do with that passport there.

The DPP Service presents the mandate when it writes. The custodian checks the signature against the operator's identity before it stores anything.

Withdrawing the agreement at the custodian **stops all writing**. Reading does not stop: the public part stays available on the link on the product, because a passport has to outlive the contracts around it.

{% include figure.html src="/assets/img/screens/getting-started-custody.png" alt="Screenshot of the DPP Manager sections 'Who holds this passport' – custodian, collection 198, mandate signed and valid for 90 days, covering create, update and delete, with buttons 'Sign a fresh mandate' and 'Compare with the service' – and 'Content binding' with the attested hash." caption="A passport's custodian and mandate in the DPP Manager." screenshot=true width="960" height="450" %}

## The back-up copy

A passport may have to be available for many years after the product was sold – longer than the company that made it, and longer than any service contract. That is what the back-up copy is for.

- **The law asks for it.** When placing a product on the market, the economic operator has to make a back-up copy of the passport available through a DPP service provider (ESPR, Article 10(4)) – according to the recitals, an independent third party. Manufacturers have to make sure it holds the most up-to-date version (Article 27), and the passport itself names the provider that hosts the back-up (Annex III).
- **EN 18221 says how it works.** Archived versions are stored both by the back-up provider and by the main provider or the operator. The copy is kept in step through the lifecycle API of EN 18222 or another agreed, secure replication. The back-up provider is also responsible for keeping mandatory documentation accessible.
- **The standard does not create the duty.** Its Annex ZA is precise: following EN 18221 gives a presumption of conformity for the technical side of the back-up – not for the existence of a back-up as such. Who must appoint one, and when, comes from the law and the delegated acts.
- **The registry already expects it.** When a passport is registered, the Commission checks – where relevant – the link to the back-up hosted by a DPP service provider (Implementing Regulation (EU) 2026/1778).

## When a provider stops

Both laws expect this case. The ESPR requires the passport to stay available after the insolvency, liquidation or end of activity of the operator that created it (Article 11). The Data Governance Act requires a data intermediary that stores data to have mechanisms that let data holders access, transfer or retrieve their data if the intermediary becomes insolvent (Article 12). In practice, three things decide whether a passport survives:

1. **The domain on the product.** If the link uses your own domain, a new custodian can take over under the same address – one DNS record changes, no label does. See [Public availability]({{ '/public-availability/' | relative_url }}) and [QR code, GS1 Digital Link and unique identifiers]({{ '/product-identifiers/' | relative_url }}).
2. **The keys.** The passport identifier is controlled with keys kept by the operator – in the DPP Manager, on its own computer. With them, the operator records where the passport now lives. Without them, nobody can.
3. **A copy elsewhere.** The back-up copy at a second provider, and the operator's own data file, mean the content does not have to be rebuilt.

## Questions to ask a DPP service provider

1. Does the link on my products use **my domain**, or yours?
2. Who holds the **keys** of my passports' identifiers?
3. Where is the **back-up copy**, and with whom?
4. Can I **leave** – and how do my passports and their versions move to the next provider?
5. Is every **version** kept and readable by date, as EN 18221 and EN 18222 expect?
6. On what **authority** do you write – one account for everything, or a mandate per passport?
7. Do you use the data for **anything else**?

## Still open

> - **A back-up provider** for the passports served here is not appointed yet. The replication between two custodians is possible with the EN 18222 API, but not set up.
> - **Rules for DPP service providers.** The ESPR lets the Commission set requirements that DPP service providers have to meet, and where appropriate a certification scheme. The Commission plans that delegated act for 2027. The EU registry already foresees a list of verified providers, but no procedure behind it yet.
{: .open}

This article explains the rules and how the tools here apply them; it is not legal advice. It reflects the state of 17 October 2026.
