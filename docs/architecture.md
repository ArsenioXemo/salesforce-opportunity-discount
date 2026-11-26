# Architecture

The opportunity record page hosts an LWC that calls an Apex controller. The controller delegates discount arithmetic to a pure service and persists changes using user-mode DML. A record-triggered Flow synchronizes the discount to the related account. The account value represents the most recently synchronized opportunity, not an aggregate.

## Security
Enforce sharing, CRUD and FLS. Grant access explicitly through a permission set. Use synthetic records only. Never commit authentication material.

## Acceptance gates
Compile and deploy to a disposable Salesforce org; execute Apex tests, validate Flow behavior and LWC accessibility, scan for secrets, and review permissions before release.
