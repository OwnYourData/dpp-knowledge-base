---
title: "The economic operator's signature on a passport"
description: A hash in the passport identifier shows that the content was not changed – but not who stands behind it. The economic operator therefore signs the passport with the key of its own identity. What is signed, how the DPP Manager and other tools submit the signature, how every version keeps its own, what the states mean, and where it does not reach yet.
section: Concepts
order: 1.5
audience: economic operators, DPP service providers, developers, anyone who verifies passports
last_reviewed: 2026-10-31
image: /assets/img/operator-signature.svg
image_alt: "Three steps. 1 Sign: the economic operator fetches the public part of its passport in the full representation without a token and signs it as a compact JWS with the document key of its own DID – alg EdDSA, kid DID#key-doc. 2 Submit: PUT /dpp/v1/dpps/{dppId}/signature with a fresh token of the owner; the DPP Service checks the form, that the signer is the owner, the signature against the DID as resolved now, and that the payload is the passport as delivered now. 3 Verify: a reader asks with Accept: application/jose and representation=full, gets the JWS, checks it against the operator's DID and compares it with the passport. Below, the states in the header X-DPP-Signature-State: none, signed, pending after every write, stale when the key no longer verifies; every version keeps the signature it had."
image_caption: "Sign, submit, verify. The service keeps the signature but never signs itself."
image_width: 960
image_height: 470
cta:
  title: Check a passport from the command line
  text: bin/verify_dpp from the open-source DPP Service checks the content hash, the signature of the economic operator in its step 7 and the signature of every recorded version – with nothing but public web requests.
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
- The DPP Service checks the signature, keeps it and hands it out on request. It **never signs itself**. Every change asks for a new signature, and the header `X-DPP-Signature-State` says where things stand.
- **Every version keeps its signature.** A reader fetches the signature of an earlier version with the dated read, `dppsByIdAndDate`.
- The **DPP Manager signs by itself** from version 0.1.11; `bin/sign_dpp` does the same for operators who keep their keys elsewhere.
- This works for passports the DPP Service keeps in its **own database**. For passports held by a custodian there is no signature of the economic operator yet.
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
| earlier versions | yes – each version keeps the signature it carried when it was replaced, together with the public part it covers |

The signature and the hash in the passport identifier cover the same content, and each proves something the other does not: the hash, that nothing changed since it was attested; the signature, who stands behind it.

## Submitting a signature

The passport changes with every write – at least its `lastUpdated` – so the signature has to be renewed after each one. The cycle: fetch the public part in the full representation without a token, sign it, and submit it with a **fresh token** of the owner:

```http
PUT /dpp/v1/dpps/{dppId}/signature
Authorization: Bearer <fresh token of the owner, with rqh>
Content-Type: application/jose

<compact JWS>
```

Like every token for the service, this one is accepted once. Submitting a signature is a write, so the token also names this request in the claim `rqh`, and from 1 December 2026 a token without it is refused – see [Bound writes and the write log]({{ '/bound-writes/' | relative_url }}).

The service checks, in this order: that the JWS is compact and has the header above; that the token is the owner's – the DID that created the passport – and that the DID in `kid` is the same; that the signature verifies with that DID's document key as resolved now; and that the payload is the passport as it is delivered now.

| Answer | When |
|---|---|
| `200`, `X-DPP-Signature-State: signed` | accepted |
| `200` with a message of type `Warning` | accepted, but the signer is not the `economicOperatorId` the passport names – for example an authorised representative, which a verifier cannot recognise |
| `400` | not a compact JWS with that header, a signature that does not verify, a payload that is not the passport as delivered now – fetch it again and sign that – or a passport held by a custodian |
| `401` | no valid token – none, an expired one, or one that was already used – with `WWW-Authenticate` |
| `403` | the token or `kid` names another DID than the owner, or tokens are not verified on this instance |

A refused signature leaves the passport as it was.

## Who signs

- **The DPP Manager**, from version 0.1.11. After every submission, correction and change of access policy of a passport the DPP Service keeps in its own database, it reads the passport as any reader receives it, signs it with the key of your identity and hands the signature to the service. The passport page shows the state the service reports and names the reason when a signature did not go through, with a button to sign again; *Sign all passports that wait for it* on the list of passports catches up on those without a signature. A passport held by a custodian is not signed, and its page says why.
- **`bin/sign_dpp`**, part of the open-source DPP Service, for an economic operator that keeps its keys outside the DPP Manager. It fetches the public part, signs it and submits the signature with a fresh token. The key comes from a JSON file or from the environment – never as an argument, where it would land in the shell history.
- **Any other tool** that produces the JWS described above.

## The four states

The state travels in the response header `X-DPP-Signature-State` – on reads by passport or product identifier, on every write and on the signature call itself. The dated read says `signed` where a signature covers exactly its answer, and `none` otherwise:

| State | Meaning |
|---|---|
| `none` | no signature was ever accepted |
| `pending` | the passport was written after the last accepted signature; that one is discarded and a new one is expected |
| `signed` | accepted, and it still verified at the last check |
| `stale` | the stored signature no longer verifies – the operator's key changed, or its DID is revoked or cannot be resolved. It is not handed out |

Every write asks for a new signature, including one that only names a new access policy: the passport is `pending` until the operator signs the new version. That also applies to a passport whose signature went `stale` – after a correction it is `pending`, and the operator signs the new version with its current key. The service checks the key again on reads, at most every few minutes, and hands out a signature only if its payload is the passport as it stands. It never hands one out on the assumption that it still holds.

## Fetching and checking it

A reader asks for the signature the same way it asks for the passport, with two differences: it prefers `application/jose`, and – on the API – it asks for the full representation. The public test passport TEST-SIG-0002 is kept by the DPP Service itself and answers on its printed identifier:

```sh
curl -H 'Accept: application/jose, application/json;q=0.5' \
  https://id.ownyourdata.eu/01/09520123456788/21/TEST-SIG-0002
```

If the state is `signed`, the answer is the JWS, `Content-Type: application/jose`. Otherwise it is the ordinary JSON, with the state in the header. No token is needed: the signature covers the public part, and a reader with access rights who wants it fetches it without a token. A verifier that compares the signature with the JSON answer to the same request therefore never finds a mismatch.

**Earlier versions.** The dated read answers the same way with the signature kept for the version it returns:

```sh
curl -H 'Accept: application/jose, application/json;q=0.5' \
  'https://dpp-service.ownyourdata.eu/dpp/v1/dppsByIdAndDate/did%3Aoyd%3AzQmYnNKx1hRRXfz1zd1u68o7pzPQrJZxjepg1ixrj2VXP8x?date=2026-10-28T16:00:00Z&representation=full'
```

For TEST-SIG-0002, this date falls on its first version, of 28 October 2026; the version of 29 October carries a signature of its own.

A signature of an earlier version is handed out only while the passport's access policy is the one that version had; under a later policy the version reads differently from what was signed, and the answer is the JSON. The key of an earlier version is not checked again: a later change of key does not undo a signature that held when it was given.

**From the command line.** `bin/verify_dpp` from the open-source DPP Service checks a passport the way any reader can. Its **step 7** fetches the signature at the link on the product and at the service, verifies it against the operator's DID and compares it with the passport delivered at the same address; its **step 8** checks the signature of every version the identifier's log records:

```sh
bundle exec ruby bin/verify_dpp https://id.ownyourdata.eu/01/09520123456788/21/TEST-SIG-0002
```

An excerpt of its output on 31 October 2026 – the test passport gets further versions, so the list grows:

```text
7    check the signature of the economic operator
  delivered at https://id.ownyourdata.eu/01/09520123456788/21/TEST-SIG-0002
  [ ok ] signed by did:oyd:zQmZmMvq…, and the signed content is the passport delivered there
  [ ok ] the signer is the economic operator the passport names

8    check the changes the DID log records
  [ ok ] version of 2026-10-28T15:52:39Z: signed by did:oyd:zQmZmMvq…
  [ ok ] version of 2026-10-29T11:53:05Z: signed by did:oyd:zQmZmMvq…
  2 version(s), 2 signed by the economic operator

VERDICT  content attested and unchanged
         signed by its economic operator
         2 of 2 recorded version(s) signed by its economic operator
```

It also says what it does not establish: that the DID belongs to the company it stands for, which would need a Verifiable Credential at the operator's DID, that the trust anchor is an accredited one, and who asked for each change – that is the job of the [write log]({{ '/bound-writes/' | relative_url }}).

In the [DPP Linter]({{ '/dpp-linter/' | relative_url }}), DPP-SEC-002 checks that the integrity of the passport version can be verified, and DPP-SEC-013 asks that the integrity proof is issued with a key of the economic operator – the gap this signature is meant to close.

## Where it does not reach yet

> - **Only passports in the service's own database.** A passport held by a custodian is read at the custodian, and there is no signature of the economic operator for it there yet; the service accepts none for it, and its state stays `none`.
> - **DPP Manager before 0.1.11** does not sign. Update it – see [Getting started]({{ '/getting-started/' | relative_url }}).
> - **Who the signer is.** The signature shows which DID signed. That this DID belongs to a particular company needs a credential from a trusted body, which is not attached yet.
{: .open}

This article explains how the DPP Service handles the economic operator's signature; it is not legal advice. It reflects the state of 31 October 2026.
