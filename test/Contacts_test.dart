import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/contact.dart';
import 'dart:html';

void main() {
  Device.init()
  .then((_) {
    initEvents();
  });
}

void initEvents() {
  querySelector("#search_btn").onClick.listen(( MouseEvent evt){
    var fields = const ['displayName', 'phoneNumbers'];
    ContactsFindOptions options = new  ContactsFindOptions(filter : getSearchName(), multiple :true);
    contacts.find(fields, options)
    .then((contacts){
      setSearchName('');
      TableSectionElement tbdy = document.querySelector('#contact_body');
      String tableContent = '';
      for(var i=0; i<contacts.length; i++){
        String row = '<tr><td>' + contacts[i].displayName + '</td><td>' + contacts[i].phoneNumbers[0].value + '</td></tr>';
        tableContent += row;
      }
      tbdy.innerHtml = tableContent;
      })
      .catchError((ex){
         function() {alert('fail!\n$ex');};
      });
  });

  querySelector("#create_btn").onClick.listen(( MouseEvent evt){ 
    List<ContactField> phoneNumbers = [];
    phoneNumbers[0] = new ContactField('mobile', getInpNumbers(), false);
     
    Contact myContact =  new Contact(getInpName(), phoneNumbers: phoneNumbers);
    myContact.save()
    .then((_) {
      alert('Complete!');
      setInpName('');
      setInpNumbers('');      
    })
    .catchError((ex){
      alert('Try again!\n$ex');
    });
  });
}

String getSearchName() {
  return (querySelector("#searchName_txt") as InputElement).value;
}

String getInpName() {
  return (querySelector("#name_txt") as InputElement).value;
}

String getInpNumbers() {
  return (querySelector("#tel_txt") as InputElement).value;
}

void setSearchName(String string) {
  (querySelector("#searchName_txt") as InputElement).value = string;
}

void setInpName(String string) {
  (querySelector("#name_txt") as InputElement).value = string;
}

void setInpNumbers(String string) {
  (querySelector("#tel_txt") as InputElement).value = string;
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