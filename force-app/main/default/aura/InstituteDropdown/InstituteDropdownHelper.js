({
    // method for dropDown
    dropDown: function(component) {
        var action = component.get("c.getInstitutes");
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log(state);
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                component.set("v.instituteList", allValues);
                
                console.log(allValues);
                console.log("institutes found");
          
                //this.mentorTable(component);
            }
        });
        
        $A.enqueueAction(action);
    }, 

    // method for mentor table
    mentorTable: function(component){
        var recordId = component.find("select1");
        var value = recordId.get("v.value");
        component.set("v.recordId", value);
        
        
        component.set("v.columns", [
            {label: "Name", fieldName: "Name__c", type: "text"},
            {label: "Designation", fieldName: "Designation__c", type: "text"},
            {label: "StudentsNumber", fieldName: "StudentsNumber__c", type: "Number"}
        ]);
        

        var action = component.get("c.getMentors");
        action.setParams({
            instituteId: component.get("v.recordId")
          
        });

        action.setCallback(this, function(data){
            component.set("v.Mentors", data.getReturnValue());
        });

        $A.enqueueAction(action);
    },

    // method for student table
    getStudentTable: function(component, selectedRows){
        const selectedMentor = event.detail.selectedRows;
        if (selectedMentor.length > 0) {
            for(let i =0;i<selectedMentor.length;i++){
                component.set("v.studentsColumns", [
                    {label: "Name", fieldName: "Name", type: "text"},
            {label: "Class", fieldName: "Class__c", type: "text"},
            {label: "City", fieldName: "City__c", type: "text"}
                ]);
                 var mentorId = selectedRows[i].Id;
                component.set("v.selectedMentorId",mentorId);
                 var action = component.get("c.studentTable");
            action.setParams({"selectedMentor": mentorId});

            action.setCallback(this, function(data){
                component.set("v.students", data.getReturnValue());
            });

            $A.enqueueAction(action);
            } 
        }else{
           component.set("v.studentsColumns",[]);
        }
    }
})