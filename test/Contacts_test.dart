import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/contacts.dart';
import 'dart:html';

Element createBtn;
Element searchBtn;
Element searchInp;
Element createInpName;
Element createInpNumber;
void main() {
  enableDeviceAccess().then((dev) {
    if (dev == null) {
      print("Time out! Fail to enable device.");
    } else {
      initElements();
      initEvents();
    }
  });
}

void initElements() {
  createBtn = querySelector("#create_btn");
  searchBtn = querySelector("#search_btn");
  searchInp = querySelector("#searchName_txt");
  createInpName = querySelector("#name_txt");
  createInpNumber = querySelector("#tel_txt");
}

void initEvents() {
  searchBtn.onClick.listen(( MouseEvent evt){
    var fields = ['displayName', 'phoneNumbers'];
    ContactsFindOptions options = new  ContactsFindOptions(filter : getSearchName(), multiple :true);
    contacts.find(fields, options)
    .then((contacts){
      TableSectionElement tbdy = document.getElementById('contact_body');
       int length = tbdy.rows.length;
       for(var i=0; i<length;i++){
         tbdy.deleteRow(0);
       }
       for(var i=0; i<contacts.length; i++){
         TableRowElement newRow = tbdy.insertRow(-1);// add at the end
         newRow.insertCell(0).text = contacts[i].displayName;
         newRow.insertCell(1).text = contacts[i].phoneNumbers[0].value;
       }
      })
      .catchError((_){
         function() {alert('fail!');};
      });
  });

  createBtn.onClick.listen(( MouseEvent evt){ 
    List<ContactField> phoneNumbers = [];
    phoneNumbers[0] = new ContactField('mobile', getInpNumbers(), false);
     
    Contact myContact =  new Contact(new ContactName(getInpName(), "", getInpName(), "", "", ""), phoneNumbers: phoneNumbers);
    myContact.save()
    .then((_) {
      alert('Complete!');
      createInpName.setAttribute('value', '');
      createInpNumber.setAttribute('value', '');      
    })
    .catchError((_){
      alert('Try again!');
    });
  });
}

String getSearchName() {
  return (searchInp as InputElement).value;
}

String getInpName() {
  return createInpName.getAttribute('value');
}

String getInpNumbers() {
  return createInpNumber.getAttribute('value');
}

void onError(ContactError contactError) {
  alert('Not Found!');  
}

void alert(String display) {
  DivElement alertBox = new DivElement();
  alertBox.style.height = '100%';
  alertBox.style.width = '100%';
  alertBox.style.backgroundColor = '#ffcfff';
  alertBox.text = display;
  document.body.nodes.add(alertBox);
  alertBox.onClick.listen(( MouseEvent evt){ 
    alertBox.remove();
  });
}