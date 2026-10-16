---
title: "DPP Service: an open implementation of the EN 18222 passport API"
description: The open-source service that stores, versions and serves Digital Product Passports through the standard lifecycle API – with signed writes, content binding, role-based access and an access log. Use our public instance or run your own.
section: Tools
order: 0
audience: DPP service providers, developers, economic operators
last_reviewed: 2026-10-16
image: /assets/img/dpp-service-overview.svg
image_alt: "Diagram: economic operators write to the DPP Service with requests signed by their own did:oyd; readers read the public part without an account, or more with a grant. The service checks signature and owner, binds content, applies access policies and grants, keeps an access log and versions, and stores passports in its own database or at a custodian under a mandate."
image_caption: "What the DPP Service does between the operator who writes and the readers who read."
image_width: 960
image_height: 460
cta:
  title: Try the API
  text: The public instance is open for reading – no account. The interactive API description lists every method with its parameters.
  buttons:
    - label: Explore the API
      url: "/api-docs/index.html"
    - label: Source code
      url: "https://github.com/OwnYourData/dpp-service-public"
further:
  - title: Running the service stand-alone
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Standalone.md"
    what: setup with your own PostgreSQL database
  - title: The DPP Service on the command line
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/DPP-Service-Demo.md"
    what: one passport created, corrected, moved and ended, as curl calls
  - title: Identifiers in the DPP ecosystem
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Identifiers.md"
    what: which identifier is which
  - title: OYD DID method
    url: "https://ownyourdata.github.io/oydid/"
    what: the self-certifying identifiers the service uses
related:
  - public-availability
  - role-based-access
  - dpp-service-validator
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- The DPP Service implements the passport **lifecycle API of EN 18222:2026**, with passports in the data model of **EN 18223:2026**.
- **Reading is public**; writing needs a short-lived token signed with the writer's own `did:oyd` – no client secrets, no accounts.
- It binds each passport's content to its identifier, delivers **controlled data per role** and logs every read of it.
- Passports live in the service's own database or at a **custodian** chosen by the operator.
- OwnYourData runs a public instance at `dpp-service.ownyourdata.eu`. The code is open source under Apache 2.0 – anyone can run their own.
</div>

## What a DPP service does

A Digital Product Passport has to be created, corrected, kept available for years, read by anyone who scans the product, and ended when the product reaches the end of its life. EN 18222:2026 defines the API for this lifecycle: which methods exist, how they are called and what they answer. A **DPP service** is the system that offers this API.

The DPP Service of OwnYourData is one complete, open implementation of it. It is the service the [DPP Manager]({{ '/dpp-manager/' | relative_url }}) talks to – but any client that speaks the standard API can use it, and any organisation can run its own copy.

## The API

{% include figure.html src="/assets/img/screens/dpp-service-api.png" alt="Screenshot of the interactive API description: the groups Life Cycle API with CreateDPP, ReadDPPById, UpdateDPPById, DeleteDPPById, ReadDPPByProductId, ReadDPPVersionByIdAndDate and ReadDPPIdsByProductIds; Registry API with RegisterProductDPP; and Fine Granular Life Cycle API for collections and single data elements." caption="The methods of EN 18222 in the interactive API description of the public instance." screenshot=true width="1400" height="1020" %}

| Group | Methods |
|---|---|
| **Lifecycle** | create, read by passport or product identifier, update (as a JSON merge patch), delete, read the version valid at a given date, look up passport identifiers for a list of products |
| **Fine-granular** | read or update a single data element or collection |
| **Registry** | register a passport with the EU registry |
| **Beyond the standard** | change of custodian, the mandate for the custodian, access policies, access grants, the access log, and a discovery document at `/.well-known/dpp-service` |

The whole contract is published as an OpenAPI description and rendered at [/api-docs](/api-docs/index.html).

## Writing: signed, not shared secrets

The public instance accepts a write only with a **bearer token the writer issues itself**: a JSON Web Token, valid for at most 15 minutes, signed with the document key of the writer's `did:oyd`. There is no account to create and no client secret that could leak.

The service resolves the DID, checks the signature, and remembers who created each passport. **Only the DID that created a passport may change it.** Reading needs no token at all.

## What the service adds to a passport

**Content binding.** After a write, the hash of the published content is recorded in the passport's own DID document. Anyone can check later that what they receive is what the operator published – see [Public availability]({{ '/public-availability/' | relative_url }}).

**Role-based access.** The operator can classify each attribute as public, for readers with a legitimate interest, or for authorities only. The service then gives each reader exactly the parts it may read, and logs every read of controlled data – see [Role-based access to passport data]({{ '/role-based-access/' | relative_url }}).

**Versions and end of life.** Every change is kept: the version valid at any past date can be read back. When a passport is ended, the service stops serving it and keeps the final state as history.

## Where the passports are kept

The service can work in two ways:

- **Stand-alone**, with passports in its own PostgreSQL database. Nothing else is needed; the [stand-alone guide](https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Standalone.md) sets it up, also as a container.
- **With a custodian.** The passport is kept by a separate hosting service, under a **mandate** the operator signs: one statement naming one passport, one storage place and a lifetime. The custodian also serves the public part on the link printed on the product. Moving to another custodian changes neither the passport identifier nor the printed link.

The public instance uses the second way. Its custodian is the data intermediary of **DID FlexCo**, an organisation separate from OwnYourData, so that the party serving the API and the party holding the data are not the same.

## The public instance

| What | Where |
|---|---|
| Base address | `https://dpp-service.ownyourdata.eu/dpp/v1` |
| API description | [/api-docs](/api-docs/index.html) |
| Discovery | [/.well-known/dpp-service](/.well-known/dpp-service) – the service's DID, the token audience and the issuers it trusts for authorities |
| Daily checks | [DPP Service Validator results](https://ownyourdata.github.io/dpp-validator/) |

The instance is checked every day by the [DPP Service Validator]({{ '/dpp-service-validator/' | relative_url }}) – the same checks any other listed service goes through.

## Run your own

The code is published at [github.com/OwnYourData/dpp-service-public](https://github.com/OwnYourData/dpp-service-public) under the Apache 2.0 licence. A stand-alone instance needs Ruby or Docker and a PostgreSQL server:

```sh
bundle install
bin/rails db:create db:migrate db:seed
bin/rails server
```

A fresh stand-alone instance starts in a permissive mode for trying things out, in which token signatures are not checked. For production, switch on signature checking as the public instance does.

> The public repository is a snapshot of the development repository, refreshed from time to time. Questions and suggestions are welcome as issues.
{: .open}
