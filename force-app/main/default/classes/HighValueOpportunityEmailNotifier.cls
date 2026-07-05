public with sharing class HighValueOpportunityEmailNotifier implements Queueable{

    private List<Id> oppIds;

    public HighValueOpportunityEmailNotifier(List<Id> oppIds) {

        this.oppIds = oppIds;
    }
    //notify via email on opp>100000 to acc.owner /tirggeron opp after insert
    public void execute(QueueableContext context){
        
        List<Messaging.SingleEmailMessage> sendEmails = new List<Messaging.SingleEmailMessage>();

        for(Opportunity opp : [SELECT Id,Name,Amount,Account.Owner.Email,Account.Name FROM Opportunity 
        WHERE Id IN : oppIds AND Amount> 100000]){
            if(opp.Account.Owner.Email != Null){
                Messaging.SingleEmailMessage sendEmail = new Messaging.SingleEmailMessage();
                sendEmail.setToAddresses(new List<String> {opp.Account.Owner.Email});
                sendEmail.setSubject('High Value Opportunity Created');
                sendEmail.setPlainTextBody('New High Opportunity '+ opp.Name + 'Created with Amount '
                +opp.Amount+ ' for the Account '+opp.Account.Name+ 'Kindly do a FOLLOW UP.'
                );
                sendEmails.add(sendEmail);
            }
              
        }

        if(!sendEmails.isEmpty()){
                Messaging.sendEmail(sendEmails);
            } 
    }
}