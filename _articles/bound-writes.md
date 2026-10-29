---
title: "Bound writes and the write log: who asked for each change"
description: Every token that changes a passport names the one request it was made for, and the DPP Service records each change before it makes it. What the claim rqh is, what changes on 1 December 2026, what the write log holds and how an owner checks it with bin/verify_writes.
section: Concepts
order: 1.7
audience: economic operators, developers of DPP clients, DPP service providers
last_reviewed: 2026-10-28
image: /assets/img/bound-writes.svg
image_alt: "Four steps. 1 Token: the writer signs a token with the document key of its own DID – audience this service, at most 15 minutes, a jti accepted once, and the claim rqh, a hash of method, request-target and body. 2 Request: the service compares rqh with the request before anything happens; a token that names another request is refused with 401. 3 Write log: an entry 'request' is written before anything changes, an entry 'outcome' when the request ends; entries are only ever added. 4 Check: the operator exports the entries of a passport, and the owner checks them with bin/verify_writes and the public keys of the signers. Banner: from 1 December 2026 a write without rqh is refused."
image_caption: "The token names its request, the log keeps it, the owner checks it."
image_width: 960
image_height: 430
cta:
  title: Read the specification
  text: Section 11 of the integrity document of the open-source DPP Service describes the claim, the write log and the checks in full.
  buttons:
    - label: Integrity.md, section 11
      url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Integrity.md"
    - label: DPP Service API
      url: "/api-docs/index.html"
further:
  - title: Identifiers, version chain and integrity
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Integrity.md"
    what: section 11, every change bound to its author
  - title: DPP Service API
    url: "/api-docs/index.html"
    what: the bearer token, the header X-DPP-Request-Binding and WWW-Authenticate
  - title: RFC 9449 – OAuth 2.0 Demonstrating Proof of Possession (DPoP)
    url: "https://www.rfc-editor.org/rfc/rfc9449"
    what: the ath claim, after which rqh is encoded
related:
  - operator-signature
  - dpp-service
  - public-availability
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- Every token for the DPP Service is **self-issued, short-lived and accepted once**. A client signs a fresh one for every call.
- The token of every **write** also names the request it was made for, in the claim **`rqh`**: a hash over method, address and body. A token that names another request is refused.
- **From 1 December 2026, a write without `rqh` is refused.** Until then it is accepted, and the answer carries the header `X-DPP-Request-Binding`.
- Before it changes anything, the service records the request in a **write log** that is only ever added to. The owner of a passport gets an export and checks it with **`bin/verify_writes`**, using nothing but the public keys of the signers.
</div>

> **What changes on 1 December 2026.** Until 30 November 2026, the service still accepts a write whose token carries no `rqh`. It answers with the header `X-DPP-Request-Binding: missing;until="2026-12-01"` and records the write as unbound. From 1 December 2026, such a write is refused like a token that does not hold: `401` with `WWW-Authenticate: Bearer error="invalid_token"`, and nothing changes. Reads need no `rqh`. The DPP Manager sends the claim from version 0.1.11 – earlier versions can no longer write from that day.

## Why bind a token to its request

The hash in the passport identifier shows that the content was not changed, and the [signature of the economic operator]({{ '/operator-signature/' | relative_url }}) shows who stands behind a version. Neither shows **who asked for a change**: the service makes it, and it may also write the identifier's log entry. EN 18246:2026 expects every change to be attributable to the identity that made it, in a form that identity cannot later deny.

A token signed by the writer that names exactly one request is such a statement: "I, the holder of this key, asked for this change, with this body, at this time." The service keeps it.

## The token

Every request to the DPP Service that needs a token – every write, and every read with access rights – carries a JSON Web Token the caller issues itself:

| Claim | What it says |
|---|---|
| `iss` | the caller's `did:oyd`; the token is signed with the document key of that DID |
| `aud` | this service, so the token is valid nowhere else |
| `exp` | at most 15 minutes after it was issued |
| `jti` | a unique value. The service accepts each token **once** and refuses the same `iss` and `jti` again until the token has expired, so a client signs a fresh token for every call |
| `rqh` | on writes: the request the token was made for (see below) |

Without a valid token, the service answers `401` and says which scheme it expects in `WWW-Authenticate`: `Bearer` when no token was sent, `Bearer error="invalid_token"` when a token was sent and refused – also when it was already used. A token that holds but does not allow the request – a passport of another owner, or a data element beyond the reader's access classes – is answered with `403`.

## The claim `rqh`

`rqh` is computed from three parts of the request:

```text
rqh = base64url( SHA-256( METHOD "\n" TARGET "\n" base64url( SHA-256( BODY ) ) ) )
```

- **METHOD** – the request method in capitals, for example `PATCH`.
- **TARGET** – the request-target exactly as in the request line: the path, with the query if there is one, percent-encoding left as it is. Scheme and host are not part of it; `aud` already names the service.
- **BODY** – the bytes of the body as sent, without any canonicalization. An empty body is the empty string.
- **base64url** without padding, as for the claim `ath` in DPoP (RFC 9449).

Because it works on bytes, every client can compute it with standard tools. For a body in `body.json`, in zsh or bash:

```sh
b64url() { openssl base64 -A | tr '+/' '-_' | tr -d '='; }
BODY=$(openssl dgst -sha256 -binary body.json | b64url)
printf 'PATCH\n%s\n%s' '/dpp/v1/dpps/did%3Aoyd%3AzQmExample' "$BODY" \
  | openssl dgst -sha256 -binary | b64url
```

The value goes into the token as `rqh`. The service compares it with the request before anything happens.

**Which requests are writes.** Creating, updating, the fine-granular writes and deleting a passport, the change of custodian, the renewal of the mandate, the signature of the economic operator, and the registration of access policies and of access grants and their revocation.

## The write log

For every write, the service adds two entries to its write log:

| Entry | When | What it holds |
|---|---|---|
| `request` | after the token is verified and bound, **before** anything changes | time, request id, operation, the passport named in the path, issuer, `jti`, the token itself, `rqh` and whether the write was bound, method, request-target, digest of the body |
| `outcome` | when the request ends | request id, HTTP status, the passport (for a new one only known now), the version the write produced – for a deletion the archived final version |

- **No change without its evidence.** If the `request` entry cannot be written, the write is refused with `500` and nothing changes.
- **Only ever added to.** The database refuses to change or delete entries.
- **Nothing of the content.** The body is bound by its digest; the content of each version is the archived version. A token in the log is already spent, and it is valid at no other service.
- **Kept for ten years** by default, and for as long as the passport or one of its archived versions exists.

Writes on passports held by a custodian are bound and logged the same way; their versions are kept by the custodian.

## Checking the log

The log is not handed out over the API. The operator of the service exports the entries of a passport for its owner, and the owner checks them with nothing but the file and the public web:

```sh
bundle exec ruby bin/verify_writes writes.jsonl
```

`bin/verify_writes`, part of the open-source DPP Service, checks for every write:

- that the token verifies with the key of its issuer, and names the issuer, `jti` and `rqh` the entry records;
- that `rqh` is the hash of the recorded method, target and body digest;
- that the write happened within the lifetime of its token.

Across all writes it checks that no `jti` appears twice, that every write has an outcome, and that no version exists without a write. Unbound writes – those from before binding was required – are listed as such. Whoever kept the bodies they sent can compare their digests as well.

## What this establishes – and what not

A bound entry shows that the holder of the issuer's key asked for this request, with this body, at this time. Together with the archived version the request produced and the economic operator's signature over its public part, every change of a passport is bound to the one who asked for it, and every signed version to the one who stands behind it.

> - **The log is kept by the service.** A removed entry shows up as a version without a write. A log rewritten as a whole cannot be told apart from inside it; the identifier's own log and the signatures of the economic operator are the records outside the service's database.
> - **The export comes from the operator.** The owner asks the operator of the service for it; the API does not hand out the log.
{: .open}

This article explains how the DPP Service binds and records writes; it is not legal advice. It reflects the state of 28 October 2026.
