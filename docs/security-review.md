# Preliminary security review

Status: release blocked pending org validation.

- Apex uses sharing, bound SOQL and user-mode query/DML. Verify compilation and restricted-user tests.
- Flow runs after save and may update Account in system context. Keep Draft until authorization policy and bulk behavior are validated.
- Direct edits to discount or Amount can leave the stored discounted amount stale. Define a single authoritative calculation path before release.
- Multiple opportunities can overwrite the account discount; last synchronization wins. Confirm business rule and bulk behavior.
- Permission set assumes existing Opportunity access; verify least privilege and field access with a restricted user.
- Static workflow parses XML/JSON only; add Salesforce semantic validation and secret scanning before release.
- No org deployment, coverage result or penetration test has been performed.
- Review all repository history for secrets before release; do not reuse legacy credentials or code.
