import { LightningElement, api } from 'lwc';
import applyDiscount from '@salesforce/apex/OpportunityDiscountController.applyDiscount';
import { notifyRecordUpdateAvailable } from 'lightning/uiRecordApi';
export default class OpportunityDiscount extends LightningElement {
    @api recordId;
    percent;
    busy = false;
    message = '';
    handleChange(event) { this.percent = event.target.value; this.message = ''; }
    async apply() {
        const input = this.template.querySelector('lightning-input');
        if (this.busy || !input.reportValidity()) return;
        this.busy = true;
        this.message = '';
        try {
            await applyDiscount({ recordId: this.recordId, percent: Number(this.percent) });
            this.message = 'Discount saved.';
            try { await notifyRecordUpdateAvailable([{ recordId: this.recordId }]); }
            catch { this.message = 'Discount saved. Refresh the record to see updated values.'; }
        } catch { this.message = 'Unable to apply discount. Check the amount, percentage and your access.'; }
        finally { this.busy = false; }
    }
}
