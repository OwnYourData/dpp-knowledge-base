---
title: Role-based access to passport data
description: Not every field of a passport is for everyone. How the DPP Service classifies passport data, who may read what, how access is granted and revoked, and how every access is logged.
section: Concepts
order: 2
audience: economic operators, DPP service providers, developers
last_reviewed: 2026-10-16
image: /assets/img/access-classes.svg
image_alt: "Matrix of readers and access classes. Anyone sees the public part; a repair shop or recycler with an access grant also sees the legitimate-interest part; authorities and the owning economic operator see the whole passport."
image_caption: "Three access classes, using a battery passport as the example. Whoever may read a class also reads every class to its left."
image_width: 960
image_height: 500
cta:
  title: Set it up for your own products
  text: The DPP Manager runs on your own computer. On its pages "Access classes" and "Access rights" you classify your product types and grant or revoke access, without a single API call.
  buttons:
    - label: Get the DPP Manager
      url: "https://github.com/OwnYourData/dpp-manager-public"
    - label: Read the API reference
      url: "/api-docs/index.html"
further:
  - title: Access classes – technical reference
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/AccessClasses.md"
    what: every endpoint, header and status code
  - title: Regulation (EU) 2023/1542, Article 77 and Annex XIII
    url: "https://eur-lex.europa.eu/eli/reg/2023/1542/oj"
    what: the three access groups of the battery passport
related:
  - what-is-a-digital-product-passport
  - public-availability
  - dpp-roadmap
  - dpp-manager
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- Every attribute of a passport belongs to one of three **access classes**: public, legitimate interest, or authority.
- The economic operator decides the classes once per product type in an **access policy**.
- Readers outside the public get an **access grant**: a signed statement, valid for at most a year, revocable at once.
- The public part stays readable by anyone, without an account. Every read of the rest is **logged**, and the owner can see who read what.
</div>

## Why a passport needs more than "public"

A passport serves very different readers. A consumer should see what a battery is made of and its carbon footprint. A recycler needs the detailed composition and how to take it apart. A market surveillance authority needs test results that a competitor should never see.

The law already draws these lines. The Battery Regulation distinguishes three groups of readers for the battery passport: the general public, persons with a legitimate interest, and notified bodies, market surveillance authorities and the Commission. The draft standard on access rights, prEN 18239, asks for access rights at the level of individual attributes, defined through a controlled vocabulary.

The DPP Service implements exactly that.

## Three classes, in order

| Class | Level | Who may read it |
|---|---|---|
| `public` | 0 | anyone, without authentication |
| `legitimateInterest` | 1 | readers with a legitimate interest – repair, refurbishment, recycling – and authorities |
| `authority` | 2 | authorities only: notified bodies, market surveillance and customs, the Commission |

The classes are ordered: whoever may read a class may read every class below it. They are defined as a small SKOS vocabulary in the open-source DPP Service, so other services can use the same terms.

Classes are not roles. "Recycler" is a role; it is granted one or more classes. That separation matters, because roles change over time while the classification of an attribute should not.

## How it works

{% include figure.html src="/assets/img/access-flow.svg" alt="Diagram. 1: the economic operator registers an access policy and writes passports; the DPP Service splits each passport into a public card and a controlled card at the custodian, linked by a hash. 2: the operator signs an access grant for a reader. 3: readers ask the DPP Service and receive what their classes allow; reads of controlled data are logged." caption="Policy, grant, read: the three steps, and where each part of the passport is kept." width="960" height="520" %}

### Step 1: classify, once per product type

The economic operator writes an **access policy** for a product type. It assigns a class to the data elements of its passports:

```json
{
  "id": "https://dpp.example.org/access-policies/led-lamp/1",
  "scheme": "https://w3id.org/soya/dpp-access/v1",
  "rules": [
    { "path": "SubstancesOfConcern", "accessClass": "public" },
    { "path": "SubstancesOfConcern/MaterialComposition", "accessClass": "legitimateInterest" }
  ]
}
```

A rule on a collection covers everything below it, unless a deeper rule says otherwise. The header of the passport is always public. The policy is registered once and named in every passport of the type; it never becomes part of the passport itself.

Two rules keep mistakes cheap:

- **An attribute no rule reaches is treated as `authority`**, unless the policy names another default. A value withheld by mistake can be released later; a value published by mistake cannot be called back.
- **A registered policy never changes.** A new version gets a new identifier, so every passport stays traceable to the policy it was written under.

The service also tells the operator, on every write, how many attributes fell to the default and which rules matched nothing – a gap in a policy is visible, not silent.

In the DPP Manager, nobody writes this JSON by hand. Each product type has a page *Access classes* that lists every field, the element it ends up in, and a choice of class. The data model of the product type can suggest a starting point:

{% include figure.html src="/assets/img/screens/dpp-manager-access-classes.png" alt="Screenshot of the DPP Manager page 'Access classes: LED lamp'. A table lists fields such as Model, Manufacturer and Serial number, the passport element each ends up in, and a drop-down for who may read it. Serial number is set to Legitimate interest, as suggested by the structure; the others are Public." caption="Access classes for the LED lamp in the DPP Manager. The serial number is limited to readers with a legitimate interest, as the product's data model suggests." screenshot=true width="1456" height="839" %}

### Where the two parts are kept

A passport with a policy is held as **two cards** at its custodian:

- the **public card** with the header and the public attributes, served to anyone – including through the link on the product itself;
- the **controlled card** with everything else, which only the DPP Service reads, under its own read grant.

The public card carries a salted hash of the controlled part. Before the service hands out anything controlled, it checks the hash. If the two do not match, it hands out nothing controlled at all.

### Step 2: grant access

An **access grant** says: this reader, identified by its DID, may read these passports in these classes. It is signed by whoever issues it:

| Class | Granted by | Covers |
|---|---|---|
| `legitimateInterest` | the economic operator that owns the passports | its own passports, all or a selection |
| `authority` | an issuer on the service's published list of authority issuers | every passport the service holds |

Whether a DID belongs to a market surveillance authority is not something the economic operator decides, and not something a service can tell from the DID alone. The service therefore relies on a published list of issuers it trusts to vouch for authorities.

A grant lasts at most 365 days. Its issuer can revoke it at any time, and the revocation takes effect with the next read: the service works out each reader's classes from the registered grants on every request and keeps nothing in between.

In the DPP Manager, granting access is a form: the reader's DID, an optional purpose, the passports it covers and how long it is valid. The page also shows which issuers the service trusts for authorities – rights the economic operator can neither give nor revoke.

{% include figure.html src="/assets/img/screens/dpp-manager-access-rights.png" alt="Screenshot of the DPP Manager page 'Access rights', section 'Grant a legitimate interest': fields for the reader DID, a name, a purpose, the choice between selected passports and all passports, and a validity of 365 days, followed by the button 'Issue the access right'. Below, the section 'Authorities' lists the issuer the DPP Service trusts." caption="Granting a legitimate interest in the DPP Manager. Rights for authorities come from issuers the service trusts, not from the operator." screenshot=true width="1456" height="1507" %}

### Step 3: read

Readers ask the DPP Service with the same kind of short-lived, self-signed token that writers use. The grant itself is not sent; the service finds it by the reader's DID.

| Reader | Gets |
|---|---|
| no token | the public part |
| token, no grant for this passport | the public part |
| grant for `legitimateInterest` | public and legitimate-interest attributes |
| grant for `authority` | the whole passport |
| the economic operator that owns it | the whole passport |

The answer is always an ordinary EN 18223 passport – with more or fewer data elements. Attributes a reader may not see are simply absent. A response header names the classes that were applied, and answers with access rights are never stored by a cache.

Earlier versions of a passport, read through the DPP Service, are filtered by today's policy: an attribute that is controlled now is not handed out from a version in which it was still public.

## Every access leaves a trace

The service keeps an **access log**. It records every read of controlled data, every refused attempt by a reader with a valid token but no valid grant, every grant registered and every revocation. It never records content or tokens.

- The **owner** of a passport sees every entry for its passports.
- A **reader** sees its own reads and refusals.
- An **issuer** of grants sees the reads made under them.

Entries are only ever added; the database itself refuses changes. They are kept for five years. And an answer containing controlled data is sent only once its log entry has been written.

## What is still open

> The legal side is not finished. The Battery Regulation required the Commission to adopt rules on who counts as a person with a legitimate interest by 18 August 2026; that deadline passed without them. The access-rights standard prEN 18239 is still a draft. Until both are settled, the economic operator decides who receives a legitimate-interest grant. The classes and the grant mechanism do not depend on how that question is answered.
{: .open}

Passports without a policy stay as they are: public as a whole, to every reader.
