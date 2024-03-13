public class Showstudentdetail {
    public String selectedInstitute { get; set; }
    public String selectedMentorId { get; set; }
    public String selectedStudentId { get; set; } // Add this line
    public List<SelectOption> dropdownOptions { get; set; }
    public List<Mentor2__c> mentors { get; set; }
    public List<Student__c> students { get; set; }
    public List<SelectOption> studentDropdownOptions { get; set; }

    public Showstudentdetail() {
        dropdownOptions = new List<SelectOption>();
        for(Institute2__c inst : [SELECT Id, Name FROM Institute2__c]) {
            dropdownOptions.add(new SelectOption(inst.Id, inst.Name));
        }
    }
    
    public void fetchMentors() {
        // Fetch mentors for the selected institute
        System.debug('selectedValue ' +selectedInstitute);
        mentors = [SELECT Id, Name, Designation__c FROM Mentor2__c WHERE Institute2__r.Id =:selectedInstitute];
        System.debug('mentors ' + mentors);
        // Reset student options when fetching new mentors
        studentDropdownOptions = null;
    }
    
    public void fetchStudentsForMentor() {
        // Fetch students associated with the selected mentor
         System.debug('selectedMentorId ' +selectedMentorId);
        students = [SELECT Id, Name, Class__c, City__c, State__c FROM Student__c WHERE Mentor2__c = :selectedMentorId];
         System.debug('students ' +students);
        // Populate student dropdown options
        studentDropdownOptions = new List<SelectOption>();
        for (Student__c student : students) {
            studentDropdownOptions.add(new SelectOption(student.Id, student.Name));
        }
    }
    
    public List<SelectOption> getStudentDropdownOptions() {
        return studentDropdownOptions;
    }
}