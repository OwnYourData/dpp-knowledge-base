---
title: "DPP Service Validator: daily, public checks of DPP services"
description: Every listed DPP service is checked every day against open criteria – transport security, the EN 18222 API and protection against unauthorised changes – and the results are published for everyone to see.
section: Tools
order: 3
audience: DPP service providers, economic operators choosing a provider
last_reviewed: 2026-10-16
image: /assets/img/criteria-two-tools.svg
image_alt: "Diagram: the open repository dpp-criteria holds passport criteria, service criteria and the list of checked services. The DPP Linter applies the passport criteria to one passport on demand; the DPP Service Validator applies the service criteria to every listed DPP service every day. Criteria and services are added by pull request."
image_caption: "One set of open criteria, two tools: the linter checks a passport, the validator checks the service behind it."
image_width: 960
image_height: 400
cta:
  title: See the current results
  text: The results page shows every listed service, the criteria version it was checked against and each finding.
  buttons:
    - label: Open the results
      url: "https://ownyourdata.github.io/dpp-validator/"
    - label: Add your DPP service
      url: "https://github.com/OwnYourData/dpp-criteria/blob/main/services/README.md"
further:
  - title: How to add a DPP service to the daily checks
    url: "https://github.com/OwnYourData/dpp-criteria/blob/main/services/README.md"
    what: step by step, including what the run sends
  - title: dpp-validator
    url: "https://github.com/OwnYourData/dpp-validator"
    what: source code, local runs and result format
  - title: dpp-criteria
    url: "https://github.com/OwnYourData/dpp-criteria"
    what: the criteria and the list of services
related:
  - dpp-criteria
  - dpp-linter
  - public-availability
---

<div class="tldr" markdown="1">
<p class="label">In short</p>

- The DPP Service Validator checks **DPP services** – the systems that hold and serve passports – not single passports.
- Every listed service is checked **every day** against the service criteria of the open repository dpp-criteria.
- It checks transport security, the lifecycle API of EN 18222, and that nobody can create or change a passport without authorisation.
- Results are **public**, with every finding and the exact version of the criteria used.
- Any operator can add their own service with a pull request. It is free and open source.
</div>

## Why check services, not just passports

An economic operator rarely runs its own passport infrastructure. It hands its passports to a DPP service provider – and has to trust that the service speaks the standard API, uses current transport security and does not let strangers change a passport.

A single passport cannot show that. Whether unknown passports are answered correctly, whether old TLS versions are refused, whether a write without credentials is rejected – that is a property of the service. The validator checks exactly these properties, the same way for every service, and publishes the result.

## What is checked

| Area | Examples |
|---|---|
| **Transport** (EN 18216) | HTTPS with a valid certificate, TLS 1.2 or higher, HTTP/2, no older HTTP versions |
| **Lifecycle API** (EN 18222) | the read methods `ReadDPPById`, `ReadDPPByProductId` and `ReadDPPIdsByProductIds`, the `v1/` version prefix, status codes, 404 for unknown passports, the `representation` flag |
| **Protection** | creating or changing a passport without credentials is refused, and the test passport is unchanged afterwards |

{% include figure.html src="/assets/img/screens/dpp-validator-results.png" alt="Screenshot of the results page for the OwnYourData DPP Service: operator, API base, contact, listed since 8 October 2026, the run time and the dpp-criteria commit, the summary '15 of 15 automated checks passed', and the criteria with their level and result." caption="The results of the OwnYourData DPP Service – the first listed service – on 16 October 2026." screenshot=true width="1400" height="1110" %}

Each run records which commit of dpp-criteria it used, and each criterion links to its description at that commit. A result can therefore always be traced back to the exact rule it was checked against.

## How a service gets listed

A service is listed only by its operator, or with the operator's consent. The operator opens a pull request to dpp-criteria with a short entry: name, operator, API address, a contact address and a **test passport** that stays online while the service is listed.

What the daily run sends is deliberately small: about 30 requests and TLS handshakes, one after another. It reads the test passport and an identifier that does not exist, sends one plain HTTP request to check the redirect to HTTPS, and tries to create and change a passport **without credentials** – requests that must be refused. No DELETE is ever sent, and the body of the change attempt is empty.

Before opening the pull request, an operator can run the same check locally against its own service, read-only:

```sh
docker run --rm -v "$PWD/local:/app/local" oydeu/dpp-validator:latest run --service local/service.yaml --output local/result.json --read-only
```

## Reading the results

Results follow the same logic as the [DPP Linter]({{ '/dpp-linter/' | relative_url }}): every criterion ends as *passed*, *warning*, *failed* or *skipped* with a reason. Only criteria with the status *active* count in "N of M automated checks passed". A feature a service declares as not implemented is skipped as *not implemented* and never counts against it.

## What the results do not say

> The results state how many automated checks a service passed on a given day. They are not a certification and do not establish a presumption of conformity. Checks that need credentials, such as writing a passport, and ratings over several days are not part of the daily run yet.
{: .open}

So far the OwnYourData DPP Service is the only listed service. The criteria are written for any service that follows the standards – the more services take part, the more useful the comparison becomes.
