public class TransactionHistoryWrapper {
    
    public String abid;
    public Integer accountNumber;
    public Decimal amount;
    public String transactionCurrency;
    public Date transactiondate;
    public Integer merchantABN;
    public Integer merchantBSB;
    public String merchantName;
    public Time transactiontime;
    public String transactionType;
    
    public TransactionHistoryWrapper() {
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
}