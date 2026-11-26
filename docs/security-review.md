# Preliminary security review

Status: release blocked pending org validation.

- Apex uses sharing, bound SOQL and user-mode query/DML. Verify compilation and restricted-user tests.
- Flow runs after save and may update Account in system context. Keep Draft until authorization policy and bulk behavior are validated.
- Discounted amount is now a read-only currency formula; validation rule enforces percentage bounds. Regression test added for Amount changes. Org compilation and formula behavior remain unverified.
- Multiple opportunities can overwrite the account discount; last synchronization wins. Confirm business rule and bulk behavior.
- Permission set assumes existing Opportunity access; verify least privilege and field access with a restricted user.
- Static workflow parses XML/JSON only; add Salesforce semantic validation and secret scanning before release.
- No org deployment, coverage result or penetration test has been performed.
- Review all repository history for secrets before release; do not reuse legacy credentials or code.

## Flow authorization gate
Keep Flow Draft. Before activation, confirm whether users who can edit Opportunity may indirectly modify Account even without Account edit access. If not, replace synchronization with an explicitly authorized user-mode operation. Test bulk updates, missing accounts, reassignment and competing opportunities. No implicit approval of system-context writes.
