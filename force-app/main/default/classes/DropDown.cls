public class DropDown {
 
    public String selectedValue { get; set; }

    public List<SelectOption> getOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Option 1', 'Value1'));
        options.add(new SelectOption('Option 2', 'Value2'));
        options.add(new SelectOption('Option 3', 'Value3'));
        return options;
    }

    public PageReference submitForm() {
        // Add your form submission logic here
        // You can use the selectedValue to get the user's selection
        System.debug('Selected Value: ' + selectedValue);
        return null; // Redirect to the same page or another page as needed
    }
}