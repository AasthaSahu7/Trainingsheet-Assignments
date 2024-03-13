public class CollectionExample {
    public static void frequencyCount(){
        List<Integer> listOfIntegers = new List<Integer>{1,26,16,26,1,2,13};
            Map<Integer,Integer> frequencyMap = new Map<Integer,Integer>();
        
        for(Integer num: listOfIntegers){
            if(frequencyMap.containsKey(num)){
                frequencyMap.put(num, frequencyMap.get(num)+1);
            }
            else{
              frequencyMap.put(num,1);
            }
        }
        for(Integer key: frequencyMap.keySet())
        {
            System.debug('Element='+key +'frequency=' +frequencyMap.get(key));
        }
    }
 }