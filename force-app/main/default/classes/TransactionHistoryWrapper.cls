global class TransactionHistoryWrapper {
    
    global String abid;
    global Integer accountNumber;
    global Decimal amount;
    global String transactionCurrency;
    global Date transactiondate;
    global Integer merchantABN;
    global Integer merchantBSB;
    global String merchantName;
    global Time transactiontime;
    global String transactionType;
    
    /*
     global TransactionHistoryWrapper() {
        this.abid = '';
        this.accountNumber = 0;
        this.amount = 0.0;
        this.transactionCurrency = '';
        this.transactiondate = Date.newInstance(1900, 1, 1);
        this.merchantABN = 0;
        this.merchantBSB = 0; 
        this.merchantName = '';
        this.transactiontime = Time.newInstance(1, 1, 1, 111);
        this.transactionType = '';
    }
*/

}