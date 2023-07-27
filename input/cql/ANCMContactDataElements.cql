library ANCMContactDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include WHOCommon called WC
include ANCMCommon called AC
include ANCMConcepts called Cx

parameter EncounterId id

context Patient

/*
  @dataElement: ANC.A.DE4 Contact date
  @activity: ANC.A4 Gather client details
  @description: The date and time of the client's contact
*/
define "Contact date":
  WC.Only(
    [Encounter: id = EncounterId] E
  ).period.start

/*
  @dataElement: ANC.B5.DE1 Reason for coming to facility
  @activity: ANC.A4 Gather client details
  @description: Records the reason why the woman came to the health-care facility today
*/
define "Reason for coming to facility":
  WC.Only(
    [Encounter: id = EncounterId] E
  ).reasonCode

/*
  @dataElement: ANC.A.DE12 ANC contact number
  @activity: ANC.A4 Gather client details
  @description: The ANC contact or visit number – recommended minimum is 8 contacts
*/
define "ANC contact number":
  AC.Extension(WC.Only(
    [Encounter]
  ), 'contactnumber').value as integer

/*
  @dataElement: ANC.A.DE1 Unique identification
  @activity: ANC.A4 Gather client details
  @description: Unique identifier generated for new clients or a universal ID, if used in the country
*/
define "Unique identification":
  WC.Official(Patient.identifier).value

/*
  @dataElement: ANC.A.DE2 First name
  @activity: ANC.A4 Gather client details
  @description: Client's first name
*/
define "First name":
  WC.Official(Patient.name).given.first()

/*
  @dataElement: ANC.A.DE3 Last name
  @activity: ANC.A4 Gather client details
  @description: Client's family name or last name
*/
define "Last name":
  WC.Official(Patient.name).family

/*
  @dataElement: ANC.A.DE5 Date of birth
  @activity: ANC.A4 Gather client details
  @description: The client's date of birth (DOB), if known
*/
define "Date of birth":
  Patient.birthDate

/*
  @dataElement: ANC.A.DE7 Address
  @activity: ANC.A4 Gather client details
  @description: Client's home address or address that the client is consenting to disclose
*/
define "Address":
  WC.Official(Patient.address)

/*
  @dataElement: ANC.A.DE8 Mobile phone number
  @activity: ANC.A4 Gather client details
  @description: Client's mobile phone number
*/
define "Mobile phone number":
  WC.Mobile(Patient.telecom)

/*
  @dataElement: ANC.A.DE10 Alternative contact's name
  @activity: ANC.A4 Gather client details
  @description: Name of an alternative contact, which could be next of kin (e.g. partner, mother, sibling); the alternative contact would be used in the case of an emergency situation
*/
define "Alternative contact's name":
  [Patient]

/*
  @dataElement: ANC.A.DE11 Alternative contact's phone number
  @activity: ANC.A4 Gather client details
  @description: Phone number of the alternative contact
*/
define "Alternative contact's phone number":
  [Patient]

/*
  @dataElement: ANC.A.DE9 Woman wants to receive reminders during pregnancy
  @activity: ANC.A4 Gather client details
  @description: Whether or not the woman wants to receive SMS or other messages regarding her ANC contacts and health status during pregnancy
*/
define "Woman wants to receive reminders during pregnancy":
  AC.Extension(Patient, 'reminder').value as boolean

/*
  @dataElement: ANC.A.DE13 Co-habitants
  @activity: ANC.A7 Create client record?OR?ANC.A8. Validate client details
  @description: Who does the client live with? It is important to know whether client lives with parents, other family members, a partner, friends, etc.
*/
define "Co-habitants":
  WC.Only(
    WC.Final([Observation: Cx."Co-habitants"])
  ).value as CodeableConcept

/*
  @dataElement: ANC.B4.DE1 Pregnancy confirmed
  @activity: ANC.B4 Confirm pregnancy
  @description: Pregnancy has been confirmed
*/
define "Pregnancy confirmed":
  WC.MostRecent(
    WC.Final([Observation: Cx."Pregnancy confirmed"])
  ).value as boolean

/*
  @dataElement: ANC.B5.DE48 Danger signs
  @activity: ANC.B5 Quick check
  @description: Before each contact, the health worker should check whether the woman has any of the danger signs listed here – if yes, she should refer to the hospital urgently; if no, she should continue to the normal contact
*/
define "Danger signs":
  WC.Final([Observation: Cx."Danger signs"])

/*
  @dataElement: ANC.B5.DE5 Specific health concern(s)
  @activity: ANC.B5 Quick check
  @description: If the woman came to the facility with a specific health concern, select the health concern(s) from the list
*/
define "Specific health concern(s)":
  WC.Final([Observation: Cx."Specific health concern(s)"])

/*
  @dataElement: ANC.End.1 Reason for closing ANC record
  @activity: ANC.End End
  @description: Select the reason why you are closing the woman's ANC record
*/
define "Reason for closing ANC record":
  WC.Final([Observation: Cx."Reason for closing ANC record"])

/*
  @dataElement: ANC.End.12 Delivery date
  @activity: ANC.End End
  @description: Date on which the woman delivered
*/
define "Delivery date":
  WC.Final([Observation: Cx."Delivery date"])

/*
  @dataElement: ANC.End.13 Place of delivery
  @activity: ANC.End End
  @description: Place where the woman delivered
*/
//define "Place of delivery":
//  [Encounter: Cx."Place of delivery Codes"] E
//    where E.status = 'finished'


/*
  @dataElement: ANC.End.17 Preterm Birth
  @activity: ANC.End End
  @description: The woman gave birth when the gestational age was less than 37 weeks
*/
define "Preterm Birth":
  WC.Final([Observation: Cx."Preterm Birth"])

/*
  @dataElement: ANC.End.18 Delivery mode
  @activity: ANC.End End
  @description: How the woman gave birth/delivered
*/
define "Delivery mode":
  WC.Final([Observation: Cx."Delivery mode"])

/*
  @dataElement: ANC.End.23 Birth weight
  @activity: ANC.End End
  @description: Enter the birth weight of the baby in kg
*/
define "Birth weight":
  WC.Final([Observation: Cx."Birth weight"])

