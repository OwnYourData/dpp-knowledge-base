---
title: "Getting started: your first passport"
description: From an empty computer to a published Digital Product Passport that anyone can open – with the DPP Manager, the DPP Service of OwnYourData and a custodian at a data intermediary. Eight steps, one screenshot each.
section: Tools
order: 1.5
audience: economic operators trying the tools for the first time
last_reviewed: 2026-10-28
image: /assets/img/getting-started-steps.svg
image_alt: "Eight steps. Set up once: 1 Start – install the container and choose a passphrase, on your computer. 2 DPP service – enter its address, it tells you the rest. 3 Identity – a key pair of your own, write down the keys. 4 Custodian – an agreement at a data intermediary gives you a pod and a collection. Per passport: 5 Describe – fill in the form of the product type. 6 Identifier – the passport gets an identifier of its own. 7 Submit – the DPP Service stores it, the custodian keeps it. 8 Check – open the link and run the DPP Linter, in any browser."
image_caption: "Four steps to set up, four steps for every passport."
image_width: 960
image_height: 364
cta:
  title: Try it yourself
  text: The DPP Manager is free and open source, and the public DPP Service and the DPP Linter need no account. All you need is a computer that runs containers.
  buttons:
    - label: Get the DPP Manager
      url: "https://github.com/OwnYourData/dpp-manager-public"
    - label: Open the DPP Linter
      url: "https://dpplint.ownyourdata.eu/"
further:
  - title: DPP Manager – installation guide
    url: "https://github.com/OwnYourData/dpp-manager-public/blob/main/docs/Install.md"
    what: Docker Desktop, Podman Desktop or Rancher Desktop, with and without a terminal
  - title: DPP Manager walkthrough
    url: "https://github.com/OwnYourData/dpp-service-public/blob/main/docs/DPP-Manager-Demo.md"
    what: one passport from first start to the end of its life, in more detail
related:
  - dpp-manager
  - dpp-service
  - dpp-linter
next_steps: [dpp-linter, dpp-manager-image]
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- You need the **DPP Manager** on your own computer, the address of a **DPP service**, and – if your passports are to be kept by a custodian – an **agreement with a data intermediary**.
- The setup takes four steps and is done once: start, service, identity, custodian.
- Every passport then takes four more: describe the product, create its identifier, submit it, check it.
- At the end, the link on the product opens the passport in any browser, and the **DPP Linter** checks it against the published standards.
- Everything here was done with a made-up product: an LED bulb from the fictitious *Example Lighting GmbH*.
</div>

## Before you start

The example in this article uses three free services:

| What | Who runs it | What it does here |
|---|---|---|
| **DPP Manager** | you, on your own computer | holds your keys, describes the product, signs and submits |
| **DPP Service** at `dpp-service.ownyourdata.eu` | OwnYourData | receives the passport through the API of EN 18222 and keeps the index |
| **Custodian** at `projects.go-data.at` | DID Daten-Intermediär-Dienste FlexCo, a separate organisation registered as a data intermediary | keeps the passport and serves it at the link on the product |

The custodian is optional. Without one, the DPP Service keeps the passport itself – skip step 4 if you only want to try things out.

## 1. Start the DPP Manager

The DPP Manager runs as a container. With Docker Desktop, Podman Desktop or Rancher Desktop installed, four lines start it – `docker compose pull` first, so that a computer that still holds an older image starts the current one:

```sh
mkdir -p ~/Documents/dpp-manager && cd ~/Documents/dpp-manager
curl -fsSLO https://raw.githubusercontent.com/OwnYourData/dpp-manager-public/main/docker-compose.yml
docker compose pull
docker compose up -d
```

Open `http://localhost:3000` and choose a passphrase. It encrypts the one file in which the DPP Manager keeps everything. Nobody can reset it – write it down. The [installation guide](https://github.com/OwnYourData/dpp-manager-public/blob/main/docs/Install.md) also covers the route without a terminal.

**Keep it up to date.** In the same folder, one line fetches the latest version and recreates the container. Your data file stays where it is, in the folder `data`:

```sh
docker compose pull && docker compose up -d --force-recreate
```

Use version 0.1.13 or later; the version is shown at the bottom of every page. **From 1 December 2026, the DPP Service accepts writes only from version 0.1.11 on**, because every write has to name its request – see [Bound writes and the write log]({{ '/bound-writes/' | relative_url }}). Up to version 0.1.6, the DPP Manager wrote the passphrase in plain text into the container's log; recreating the container removes that old log. If you have passed a log of the container on to anyone, change the passphrase under *Data file* – see the [changelog](https://github.com/OwnYourData/dpp-manager-public/blob/main/CHANGELOG.md#017). Since 0.1.8, a form is no longer lost when the data file locks itself (see step 5).

**A second DPP Manager** on the same computer goes into a folder of its own, with its own port and container name. Put both into a file `.env` next to `docker-compose.yml`, for example `DPP_MANAGER_PORT=3001` and `DPP_MANAGER_CONTAINER=dpp-manager-2`; the container name can be set this way from version 0.1.9 of `docker-compose.yml`.

## 2. Choose the DPP service

The setup starts with the service your passports are written to. Enter its address – here `https://dpp-service.ownyourdata.eu` – and press **Check and continue**.

{% include figure.html src="/assets/img/screens/getting-started-service.png" alt="Screenshot of the DPP Manager setup, step 1 of 4, 'DPP Service': the bar with the link DPP Service on the right, the question 'Which DPP Service do you write to?', the address field filled with https://dpp-service.ownyourdata.eu and the button 'Check and continue'; in the footer 'Developed by OwnYourData', links to the DPP Service and the source code, and Version 0.1.10." caption="Only the address is typed in. Everything else – the service's identity, where tokens go – is asked of the service." screenshot=true width="946" height="800" %}

The DPP Manager only asks the service whether it is there and under which identity it answers. Nothing about you is sent yet.

## 3. Create your identity

Next comes your identity as an economic operator: a key pair, created on your computer. The name you give it is only for your own overview.

{% include figure.html src="/assets/img/screens/getting-started-identity.png" alt="Screenshot of setup step 2, 'Your identity', with the link DPP Service in the bar: an explanation that the private half of the key pair stays on this machine and that the keys stay visible until you confirm that they are stored, a warning 'This is the one thing that cannot be replaced', and the field 'Name for this identity' filled with Example Lighting GmbH." caption="The private key stays on your computer; only the public half is published, so that others can check your signatures." screenshot=true width="946" height="866" %}

**Create an identity** publishes the public half as a `did:oyd` identifier. The next screen shows two keys – a document key and a revocation key. They stay visible until you confirm that you have stored them, and after that they are not shown again, not even when you open that step once more. Press **Write the key file** and keep a copy somewhere safe: whoever holds these keys speaks for your company, and without them your passports can no longer be changed.

## 4. Get a custodian

A custodian keeps your passports and serves them at the link on the product. The DPP Service then only points at them. To use the data intermediary of DID FlexCo, sign in at [projects.go-data.at](https://projects.go-data.at) with ID Austria or an EU Digital Identity Wallet – there is no separate sign-up. Then add a **New Data Offering** with the use case **DPP Hosting**:

- **Data Models:** the product types you want to keep there, for example `DppLedLamp` and `DppBattery` from soya.ownyourdata.eu.
- **Policies:** the purposes, the storage location and how long the data is kept.
- **Access:** the identity from step 3 as the controller of the storage, and whether third parties get contractual read access. The access the law provides for under the ESPR is not affected either way.

{% include figure.html src="/assets/img/screens/getting-started-intermediary-access.png" alt="Screenshot of the data intermediary's portal, New Data Offering for the use case DPP Hosting, tab Access: 'Storage of Digital Product Passports' with the identifier (DID) of the economic operator, and the choice 'No access for third parties' selected over 'Third parties may read the entire storage, including controlled parts'." caption="At the intermediary: your identity from step 3 becomes the controller of the storage." screenshot=true width="1412" height="470" %}

Press **Save**, then **Sign**. Under **My Contracts**, the details of the new agreement show the two values the DPP Manager needs: the address of the storage service and the number of your collection. Neither is secret.

{% include figure.html src="/assets/img/screens/getting-started-contract-values.png" alt="Screenshot of the contract details at the intermediary: base address of the storage service https://dpp-staging.go-data.at, storage identifier 201, access for third parties: no access for third parties, and the note to enter these two values in the DPP Manager." caption="The two values from the agreement. This example used the intermediary's test environment, hence 'dpp-staging'." screenshot=true width="1100" height="196" %}

Back in the DPP Manager, enter both values in the last setup step. If the address differs from the one shown next to DID FlexCo, choose **A different custodian** and type it in. Then **Save and finish**.

{% include figure.html src="/assets/img/screens/getting-started-custodian.png" alt="Screenshot of setup step 4, 'Where the passport lives', section 'Which one?': the preset DID Daten-Intermediär-Dienste FlexCo with https://dpp.go-data.at, and 'A different custodian' selected with the address of the pod https://dpp-staging.go-data.at; below, the collection 201 and the button 'Save and finish'." caption="Address and collection from the agreement – the setup is complete." screenshot=true width="932" height="474" %}

## 5. Describe the product

Under **Passports**, start a new passport of a product type – here *LED lamp*. The top of the form is the same for every product:

- **Product identifier** – the link printed on the product, usually a GS1 Digital Link. Our example uses `https://dpp-staging.go-data.at/01/09520123000028/21/KB-0002`: GTIN `09520123000028` from GS1's range for examples, serial number `KB-0002`. A real product would carry a link on your own domain, pointed at the custodian.
- **This passport describes** – a model, a batch or one item. For a Digital Link it is read from the path: `/21/` means one item.

Below follows the form of the product type, in tabs. Required fields are marked; a draft is saved even when it is incomplete.

{% include figure.html src="/assets/img/screens/getting-started-form.png" alt="Screenshot of the LED lamp form with the tabs Product, Light and power, Lifetime, Conformity and substances, and Environment. The Product tab shows manufacturer Example Lighting GmbH, product designation LED bulb E27 806 lm, model EL-E27-806, serial number KB-0002, date of manufacture 2026-10-01 and country of origin AT. Above: '21 fields filled in' and the button 'Load file'." caption="The form comes from the product type. If the data already exists elsewhere, Load file reads it from a JSON file – in the browser, without uploading it." screenshot=true width="954" height="450" %}

**Locked in between?** When the DPP Manager sits unused for longer than the time set under *Settings* – 15 minutes unless you change it – the data file locks itself. What you send after that is not carried out, and the unlock screen says so. Once you have entered your passphrase, you are back on the form with what you had typed, except passphrases, keys and files; press **Save** again. The event log records the lock together with the action that was not carried out.

{% include figure.html src="/assets/img/screens/getting-started-lock.png" alt="Screenshot of the DPP Manager unlock screen with the message 'Locked because the application sat unused. What you sent was not carried out.' and below it: 'What you sent last was not carried out. Once the file is open, you are taken back to that page, with what you had typed — except passphrases and keys.'" caption="After an automatic lock, nothing is lost silently: the DPP Manager says what was not carried out and leads back to the form." screenshot=true width="472" height="392" maxwidth="472" %}

## 6. Create the passport identifier

Each passport gets an identifier of its own, separate from your identity. It records where the passport can be read – so the product identifier and the custodian have to be right before you press the button.

{% include figure.html src="/assets/img/screens/getting-started-identifier.png" alt="Screenshot of the warning 'This step cannot be undone': a document is published to the registry saying the passport can be read at https://dpp-staging.go-data.at; from then on the product identifier and the passport identifier are fixed, and where it points can be changed later only by handing the passport to another custodian. In front of it, the DPP Manager's own dialog 'Please confirm': 'Create the identifier now? It will point at https://dpp-staging.go-data.at, and the product identifier cannot be changed afterwards.' with the buttons Cancel and 'Yes, go ahead'." caption="The one step that cannot be undone. The DPP Manager says so before, and asks once more in a dialog of its own." screenshot=true width="956" height="288" %}

**Create the passport identifier** opens a confirmation in the DPP Manager itself – **Yes, go ahead** or **Cancel**; Escape cancels, too. From then on, the product identifier and the passport identifier are fixed. Where the identifier points can still change: handing the passport to another custodian moves it, with the passport's keys, and both identifiers stay the same.

The next screen shows the passport's two keys, just like your identity's. Write the key file again and confirm that you have stored them; after that, they are not shown again. Without these keys the passport can still be read, but never handed to another custodian or retired.

## 7. Submit

**Submit to the DPP Service** assembles the passport in the data model of EN 18223, signs it with your identity and sends it, after one more confirmation. The service checks the passport identifier before it stores anything: it has to point at the host where the passport will be read – the custodian's, when one holds it.

All times in the DPP Manager are shown in UTC and labelled so – the same time base as the event log, the DPP Service and the custodian.

{% include figure.html src="/assets/img/screens/getting-started-submitted.png" alt="Screenshot of the passport page after submission: the section 'The passport identifier' with the identifier did:oyd:zQmNnP7…, created 2026-10-18 09:54 UTC, and where it points; then the section Submitting: submitted 2026-10-18 09:55 UTC to https://dpp-service.ownyourdata.eu, no period set, and the note 'The service holds this version'." caption="Submitted. The DPP Manager keeps what the service accepted, so you can look it up even when the service is not reachable. Every time is in UTC." screenshot=true width="954" height="350" %}

With a custodian set, the DPP Manager signs a **mandate** at the same time: this service may keep this one passport in this one collection, for 90 days. A fresh mandate is one click. A hash of the content is also recorded in the passport identifier's log – the [content binding]({{ '/public-availability/' | relative_url }}) that lets any reader check that nothing was changed.

{% include figure.html src="/assets/img/screens/getting-started-custody.png" alt="Screenshot of the sections 'Who holds this passport' – custodian https://dpp-staging.go-data.at, collection 201, mandate signed on 2026-10-18 09:55 UTC and valid until 2027-01-16 09:55 UTC, covering create, update and delete, with buttons 'Sign a fresh mandate' and 'Compare with the service' – and 'Content binding' with the attested hash and the note 'The payload is attested'." caption="Who keeps the passport, under which mandate – and the hash that binds its content." screenshot=true width="954" height="438" %}

## 8. Open and check it

The passport is now live. Open the product identifier in any browser – a phone camera scanning a QR code with that link does the same:

{% include figure.html src="/assets/img/screens/getting-started-public.png" alt="Screenshot of the public passport page for EL-E27-806: About this passport with the product identifier, the passport identifier, granularity item, status Active, last updated, economic operator and schema version EN 18223:2026; then Product identification with model, brand name, product designation, serial number, date of manufacture and country of origin; then Energy performance." caption="What a reader sees: a readable page for people, JSON for software – at the same link, without an account." screenshot=true width="940" height="840" %}

Then paste the same link into the [DPP Linter](https://dpplint.ownyourdata.eu/). It fetches the passport the way any reader does and checks it against the criteria derived from EN 18219, EN 18223 and the regulations.

{% include figure.html src="/assets/img/screens/getting-started-linter.png" alt="Screenshot of the DPP Linter for https://dpp-staging.go-data.at/01/09520123000028/21/KB-0002: '6 of 6 automated checks passed (0 failed, 1 with warnings, 0 skipped)', proposed criteria 10 of 10 passed, retrieved with HTTP 200 as JSON. Warnings for DPP-ID-016, no linked verifiable credentials for the operator's identity, and DPP-SEC-013, content attested with the key of the passport identifier rather than the operator's; DPP-CAR-002 and DPP-CFG-005 passed." caption="All automated checks passed. Both warnings concern the operator's identity, not the content of the passport." screenshot=true width="940" height="723" %}

The warnings are expected for now. **DPP-ID-016:** the operator's identity is self-issued and carries no credentials from a trusted body yet – one of the points [still open]({{ '/reference-architecture/' | relative_url }}) in the CIRPASS-2 comparison. **DPP-SEC-013**, a proposed criterion: the content is attested with the key of the passport identifier, which is not yet linked to the operator's identity. A signature of the economic operator closes this gap for passports the DPP Service keeps itself, not yet for passports held by a custodian like this one – see [The economic operator's signature on a passport]({{ '/operator-signature/' | relative_url }}).

## What comes next

- **Decide who reads what.** Switch on access classes for the product type, and the parts that are not public go only to readers with the right access. See [Role-based access]({{ '/role-based-access/' | relative_url }}).
- **Correct the passport.** Change the answers and send a correction; every version stays readable by date.
- **End it.** At the end of the product's life, *End the passport* stops serving it and revokes its identifier.
- **Batteries.** The DPP Manager ships a second product type, the traction battery – see [Battery passport]({{ '/battery-passport/' | relative_url }}).

The example passport describes a product that does not exist. It was created in the intermediary's test environment, which is reset regularly – so its link may no longer work when you read this. Your own passport, with your own link, works the same way.
