trigger HighValueOppTrigger on Opportunity (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        List<Id> oppIds = new List<Id>();

        for(Opportunity opp : Trigger.New){
            if(opp.Amount != NUll &&opp.Amount > 100000){
                oppIds.add(opp.Id);
            }
            
        }
        if(!oppIds.isEmpty()){
            System.enqueueJob(new HighValueOpportunityEmailNotifier(oppIds));
        }
    }
}