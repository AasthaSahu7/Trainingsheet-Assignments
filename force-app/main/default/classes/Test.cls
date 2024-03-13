public class Test {
    public String selectedValue { get; set; }

    public List<SelectOption> getOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('option 1', 'Institute 1'));
        options.add(new SelectOption('option 2', 'Institute 2'));
        options.add(new SelectOption('option 3', 'Institute 3'));
        return options;
    }

    public PageReference submitForm() {
        
        System.debug('Selected Value: ' + selectedValue);
        return null; 
    }
}