---
title: "The economic operator's signature on a passport"
description: A hash in the passport identifier shows that the content was not changed – but not who stands behind it. The economic operator can therefore sign the passport with the key of its own identity. What is signed, how the signature is submitted and fetched, what its states mean, and where it does not reach yet.
section: Concepts
order: 1.5
audience: economic operators, DPP service providers, developers, anyone who verifies passports
last_reviewed: 2026-10-20
image: /assets/img/operator-signature.svg
image_alt: "Three steps. 1 Sign: the economic operator fetches the public part of its passport in the full representation without a token and signs it as a compact JWS with the document key of its own DID – alg EdDSA, kid DID#key-doc. 2 Submit: PUT /dpp/v1/dpps/{dppId}/signature with the owner's token; the DPP Service checks the form, that the signer is the owner, the signature against the DID as resolved now, and that the payload is the passport as delivered now. 3 Verify: a reader asks with Accept: application/jose and representation=full, gets the JWS, checks it against the operator's DID and compares it with the passport. Below, the states in the header X-DPP-Signature-State: none, signed, pending after every write, stale when the key no longer verifies."
image_caption: "Sign, submit, verify. The service keeps the signature but never signs itself."
image_width: 960
image_height: 470
cta:
  title: Check a passport from the command line
  text: bin/verify_dpp from the open-source DPP Service checks the content hash and, as its step 7, the signature of the economic operator – with nothing but public web requests.
  buttons:
    - label: Open the DPP Service source
      url: "https://github.com/OwnYourData/dpp-service-public"
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
further:
  - title: Identifiers, version chain and integrity
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/Integrity.md"
    what: section 10, the signature of the economic operator, in full
  - title: DPP Service API
    url: "/api-docs/index.html"
    what: signDPP and the header X-DPP-Signature-State
  - title: RFC 7515 – JSON Web Signature
    url: "https://www.rfc-editor.org/rfc/rfc7515"
    what: the compact serialization used here
related:
  - public-availability
  - dpp-service
  - reference-architecture
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- The hash in the passport identifier shows that the content is unchanged. It does not show **who** stands behind it: nothing links the passport's own key to the economic operator.
- The economic operator closes that gap by **signing** the passport with the key of its own identity – a JSON Web Signature over the public part, as anyone receives it.
- The DPP Service checks the signature, keeps it and hands it out on request. It **never signs itself**. Every change of the passport discards the signature, and the header `X-DPP-Signature-State` says where things stand.
- Today this works only for passports the DPP Service keeps in its **own database**, not yet for passports held by a custodian. The DPP Manager does not sign yet; `bin/sign_dpp` does.
</div>

## Why a hash is not enough

Every passport identifier carries a hash of the passport content in its signed log – see [Public availability]({{ '/public-availability/' | relative_url }}). A reader who recomputes it knows that the content is the one that was attested. But the entry is written with the key of the **passport identifier**, and nothing a reader can check ties that key to the company. The passport names its operator in `economicOperatorId` – yet that statement, too, is attested only with the passport's own key.

The standards point to the remedy. EN 18219:2026 describes the economic operator's DID as the means to sign passports, with the public key in its DID document, and EN 18246:2026 names the economic operator as the typical issuer of signed passport data. So the operator signs the passport with the key of **its own** DID, and a reader fetches that signature next to the passport.

## What is signed

The signature is a **JSON Web Signature in the compact serialization** (RFC 7515):

- **Header:** `alg` is `EdDSA`; `kid` is `<DID>#key-doc`, the document key of the economic operator's DID.
- **Payload:** the passport itself – its public part in the **full representation**, exactly as a reader without access rights receives it. Two payloads count as the same if their JSON canonicalization (RFC 8785) is the same, so the order of keys and whitespace do not matter.
- **Media type:** `application/jose`. The payload is the passport, not a Verifiable Credential.

What the signature covers, and what not:

| | Covered? |
|---|---|
| the current version of the public part, in the full representation | yes |
| the controlled part | indirectly: the public part carries `ControlledData`, a salted digest of the controlled part, and the service compares the two before it hands out anything controlled |
| the view of a reader with access rights | no – such an answer carries no signature, so a verifier never compares a signature with more than was signed |
| the compressed representation | no – it is derived from the full one |
| earlier versions | no – only the current version carries a signature |

The signature and the hash in the passport identifier cover the same content, and each proves something the other does not: the hash, that nothing changed since it was attested; the signature, who stands behind it.

## Submitting a signature

The passport changes with every write – at least its `lastUpdated` – so the signature has to be renewed after each one. The cycle: fetch the public part in the full representation without a token, sign it, and submit it with the owner's token:

```http
PUT /dpp/v1/dpps/{dppId}/signature
Authorization: Bearer <token of the owner>
Content-Type: application/jose

<compact JWS>
```

The service checks, in this order: that the JWS is compact and has the header above; that the token is the owner's – the DID that created the passport – and that the DID in `kid` is the same; that the signature verifies with that DID's document key as resolved now; and that the payload is the passport as it is delivered now.

| Answer | When |
|---|---|
| `200`, `X-DPP-Signature-State: signed` | accepted |
| `200` with a message of type `Warning` | accepted, but the signer is not the `economicOperatorId` the passport names – for example an authorised representative, which a verifier cannot recognise |
| `400` | not a compact JWS with that header, a signature that does not verify, a payload that is not the passport as delivered now – fetch it again and sign that – or a passport held by a custodian |
| `401` | no valid token |
| `403` | the token or `kid` names another DID than the owner, or tokens are not verified on this instance |

A refused signature leaves the passport as it was.

## The four states

The state travels in the response header `X-DPP-Signature-State` – on reads by passport or product identifier, on every write and on the signature call itself:

| State | Meaning |
|---|---|
| `none` | no signature was ever accepted |
| `pending` | the passport was written after the last accepted signature; that one is discarded and a new one is expected |
| `signed` | accepted, and it still verified at the last check |
| `stale` | the stored signature no longer verifies – the operator's key changed, or its DID is revoked or cannot be resolved. It is not handed out |

Every write discards the signature, including one that only names a new access policy. The service checks the key again on reads, at most every few minutes, and hands out a signature only if its payload is the passport as it stands. It never hands one out on the assumption that it still holds.

## Fetching and checking it

A reader asks for the signature the same way it asks for the passport, with two differences: it prefers `application/jose`, and it asks for the full representation.

```sh
curl -H 'Accept: application/jose, application/json;q=0.5' \
  'https://dpp-service.ownyourdata.eu/dpp/v1/dppsByProductId/<product identifier>?representation=full'
```

If the state is `signed`, the answer is the JWS, `Content-Type: application/jose`. Otherwise it is the ordinary JSON, with the state in the header. A reader with access rights who wants the signature fetches it without a token, because the signature covers the public part only. A verifier that compares the signature with the JSON answer to the same request therefore never finds a mismatch.

The open-source DPP Service brings two command-line tools:

- **`bin/sign_dpp`** signs a passport for an economic operator that keeps its keys outside the DPP Manager. It fetches the public part, signs it and submits the signature. The key comes from a JSON file or from the environment – never as an argument, where it would land in the shell history.
- **`bin/verify_dpp`** checks a passport the way any reader can. Its **step 7** fetches the signature at the link on the product and at the service, verifies it against the operator's DID, and compares it with the passport delivered at the same address. It also says what it does not establish: that the DID belongs to the company it stands for, which would need a Verifiable Credential at the operator's DID, and that the trust anchor is an accredited one.

In the [DPP Linter]({{ '/dpp-linter/' | relative_url }}), DPP-SEC-002 checks that the integrity of the passport version can be verified, and DPP-SEC-013 asks that the integrity proof is issued with a key of the economic operator – the gap this signature is meant to close.

## Where it does not reach yet

> - **Only passports in the service's own database.** A passport held by a custodian is read at the custodian, and the service accepts no signature for it yet; its state stays `none`. The passports of the public instance are held by a custodian.
> - **The DPP Manager does not sign yet.** Today a signature is made with `bin/sign_dpp` or with any tool that produces the JWS described above.
> - **Who the signer is.** The signature shows which DID signed. That this DID belongs to a particular company needs a credential from a trusted body, which is not attached yet.
{: .open}

This article explains how the DPP Service handles the economic operator's signature; it is not legal advice. It reflects the state of 20 October 2026.
