USE blood_bank_management_system;

CREATE TABLE BLOOD(
Blood_ID varchar(40) not null ,
Blood_Group varchar(3) not null,
Expiry_Date date not null,
Blood_Quantity int default 0,   -- is it appropriate ?
Blood_Description longtext,
PRIMARY KEY(Blood_ID),
Test_Done_For_Blood_Samples longtext
);

CREATE TABLE Blood_BloodTestSamples_Relation (
  Blood_ID varchar(40),
  Test_Done_For_Blood_Samples varchar(250),
  PRIMARY KEY (Blood_ID, Test_Done_For_Blood_Samples),
  CONSTRAINT fk_blood FOREIGN KEY (Blood_ID) REFERENCES BLOOD(Blood_ID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE BLOOD_BANK(
	Branch_ID varchar(40) not null,
	Branch_Name varchar(50) not null,
	Available_Blood_Quantity int default null,
	Street varchar(50) not null,
	City varchar(50) not null,
	Province varchar(50) not null,
	PRIMARY KEY(Branch_ID)
);


CREATE TABLE Branch_AvailableBloodGroups_Relation(
	Branch_ID varchar(50),
	Available_Blood_Groups varchar(3),
	Available_Blood_Quantity int default 0,
	primary key(Branch_ID,Available_Blood_Groups),
	constraint fk_bloodbank foreign key(Branch_ID) references BLOOD_BANK(Branch_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Branch_Phonenumbers_Relation(
	Branch_ID varchar(50) ,
	Contact_No varchar(10),
	primary key(Branch_ID,Contact_No),
		constraint fk_bloodbank1 foreign key(Branch_ID) references BLOOD_BANK(Branch_ID)
		ON DELETE CASCADE ON UPDATE CASCADE  
);


CREATE TABLE EQUIPMENT (
	Equip_ID varchar(50) not null,
	Eqip_Name varchar(50) not null,
	Cost integer default 0 ,
	Quantity integer default 0,
	Equip_Description varchar(250),
	Branch_ID varchar(50),
	PRIMARY KEY(Equip_ID),
    constraint fk_bloodbank2 foreign key(Branch_ID) references BLOOD_BANK(Branch_ID)
		ON DELETE CASCADE ON UPDATE CASCADE 
);


CREATE TABLE HOSPITAL(
	Hospital_ID varchar(50)not null,
	Hospital_Name varchar(100) not null,
	Street varchar(50) not null,
	City varchar(50) not null,
	Province varchar(50) not null,
	PRIMARY KEY (Hospital_ID)
);

CREATE TABLE Hospital_PhoneNumbers_Relation(
	Hospital_ID varchar(50) ,
	Contact_No varchar(10),
    primary key(Hospital_ID,Contact_No),
	constraint fk_hospital foreign key(Hospital_ID) references HOSPITAL(Hospital_ID)		  
);

CREATE TABLE Branch_AvailableBloodGroups(
	Hospital_ID varchar(50) ,
	Available_Blood_Groups varchar(3),
	Available_Blood_Quantity integer default 0,
	primary key(Hospital_ID,Available_Blood_Groups),
    constraint fk_hospital1 foreign key(Hospital_ID) references HOSPITAL(Hospital_ID)
		ON DELETE CASCADE ON UPDATE CASCADE     
);


-- REFERENCE -- https://www.analyticsvidhya.com/blog/2020/11/guide-data-types-mysql-data-science-beginners/
CREATE TABLE DONOR(
	Donor_ID varchar(50) not null,
	
    Donor_Name varchar(50) not null,
	Date_of_Birth date ,
	Nationality varchar(40),
	Eligibility_Status bool default 0,
	Age int default 0,   -- Derived Attribute
	Blood_Quantity integer default 0,
	Last_Donated_Date date ,
	Blood_Group varchar(3) not null,
	Health_problems longtext , 
	Street varchar(100) not null,
	City varchar(50) not null,
	Province varchar(50) not null,
	Blood_ID varchar(40),
	PRIMARY KEY(Donor_ID),
	constraint fk_blood1 foreign key(Blood_ID) references BLOOD(Blood_ID)
	ON DELETE CASCADE ON UPDATE CASCADE      
);

CREATE TABLE Donor_Email_Relation(
	Donor_ID varchar(50) ,
	Email varchar(50),
	primary key(Donor_ID,Email),
	constraint fk_donor foreign key(Donor_ID) references DONOR(Donor_ID)
		ON DELETE CASCADE ON UPDATE CASCADE  
);

CREATE TABLE Donor_DonatedDates_Relation(
	Donor_ID varchar(50) ,
	DonatedDate varchar(50),
	primary key(Donor_ID,DonatedDate),
	constraint fk_donor5 foreign key(Donor_ID) references DONOR(Donor_ID)
		ON DELETE CASCADE ON UPDATE CASCADE  
);

CREATE TABLE Donor_Phonenumbers_Relation(
	Donor_ID varchar(50) ,
	Contact_No varchar(10),
	primary key(Donor_ID,Contact_No),
	constraint fk_donor1 foreign key(Donor_ID) references DONOR(Donor_ID)
				ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE BLOOD_DONATION_CAMP(
	Branch_ID varchar(40) ,
	Camp_Name varchar(50) not null,
	Held_Date date ,
	Street varchar(100) not null,
	City varchar(50) not null,
	Province varchar(50) not null,
	PRIMARY KEY(Branch_ID,Camp_Name,Held_Date),
    constraint fk_branch foreign key(Branch_ID) references Blood_Bank(Branch_ID) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE Donor_HealthProblems_Relation(
	Donor_ID varchar(50),
	Health_Problems varchar(250),
    primary key(Donor_ID,Health_Problems),
	constraint fk_donor2 foreign key(Donor_ID) references DONOR(Donor_ID)
		ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE EMPLOYEE(
	Employee_ID varchar(40) not null,
    Employee_Name varchar(40) not null,
    Gender varchar(10) not null,
    Nationality varchar(40) not null,
    Employee_Type varchar(40) not null,
    Date_of_Birth date not null,
	Age int default 0, -- Derived Attribute
	Salary int default 0, -- Derived Attribute
    Street varchar(40) not null,
    City varchar(40) not null,
    Province varchar(40) not null,
    primary key(Employee_ID),
    Supevisor_ID varchar(40),
    Branch_ID varchar(40) not null,
	constraint fk_emply foreign key(Supevisor_ID) references EMPLOYEE(Employee_ID)
	ON DELETE CASCADE ON UPDATE CASCADE,
    constraint fk_bloodbank3 foreign key(Branch_ID) references BLOOD_BANK(Branch_ID)
	ON DELETE CASCADE ON UPDATE CASCADE     
);

create table Employee_PhoneNumbers_Relation(
	Employee_ID varchar(40) not null,
    Contact_No int default 0,
    primary key(Employee_ID,Contact_No),
    constraint fk_empl foreign key(Employee_ID) references EMPLOYEE(Employee_ID)
			ON DELETE CASCADE ON UPDATE CASCADE  
);

create table Employee_Email_Relation(
	Employee_ID varchar(40) not null,
    Email varchar(40) not null,
    primary key(Employee_ID,Email),
    constraint fk_empl1 foreign key(Employee_ID) references EMPLOYEE(Employee_ID)
		ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE PATIENT(
	Patient_ID varchar(40) not null,
    Patient_Name varchar(40) not null,
    Gender varchar(10) not null,
    Nationality varchar(40) not null,
    Employer_Type varchar(40) not null,
    Date_of_Birth date not null,
	Age int default 0, -- Derived Attribute
    Street varchar(40) not null,
    City varchar(40) not null,
    Province varchar(40) not null,
    primary key(Patient_ID)
);

create table Patient_PhoneNumbers_Relation(
	Patient_ID varchar(40) not null,
    Contact_No varchar(10),
    primary key(Patient_ID,Contact_No),
    constraint fk_patient foreign key(Patient_ID) references PATIENT(Patient_ID)
		ON DELETE CASCADE ON UPDATE CASCADE 
);

create table Patient_Email_Relation(
	Patient_ID varchar(40) not null,
    Email varchar(40) not null,
    primary key(Patient_ID,Email),
    constraint fk_patient1 foreign key(Patient_ID) references PATIENT(Patient_ID)
			ON DELETE CASCADE ON UPDATE CASCADE
);

create table Patient_HealthProblems_Relation(
	Patient_ID varchar(40) not null,
    Health_Problems varchar(250),
    primary key(Patient_ID,Health_Problems),
    constraint fk_patient2 foreign key(Patient_ID) references PATIENT(Patient_ID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

create table PAYMENT(
 	Payment_ID varchar(50) not null,
    Amount decimal(3,1) not null,
    Paid_Date date not null,
    primary key (Payment_ID),
    Patient_ID varchar(50) not null,
	constraint fk_patient3 foreign key(Patient_ID) references PATIENT(Patient_ID)
	ON DELETE CASCADE ON UPDATE CASCADE  
);

-- Many to many
CREATE TABLE Blood_Equipment_Relation(
	blood_id varchar(40) not null,
	equipment_id varchar(50) not null,
    PRIMARY KEY(blood_id,equipment_id),
	constraint fk_blood2 foreign key(blood_id) references BLOOD(Blood_ID)ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_equipment foreign key(equipment_id) references EQUIPMENT(Equip_ID) ON DELETE CASCADE ON UPDATE CASCADE 		
);

CREATE TABLE Blood_Branch_Relation(
	blood_id varchar(40) not null,
	branch_id varchar(50) not null,
    PRIMARY KEY(blood_id,branch_id),
	constraint fk_blood3 foreign key(blood_id) references BLOOD(Blood_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_branch1 foreign key(branch_id) references BLOOD_BANK(Branch_ID) ON DELETE CASCADE ON UPDATE CASCADE 		
);

CREATE TABLE Bloodbank_Hospital_Relation(
	hospital_id varchar(40) not null,
	branch_id varchar(50) not null,
    PRIMARY KEY(hospital_id,branch_id),
	constraint fk_hospital2 foreign key(hospital_id) references HOSPITAL(Hospital_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_equipment1 foreign key(branch_id) references BLOOD_BANK(Branch_ID) ON DELETE CASCADE ON UPDATE CASCADE		
);

CREATE TABLE Blood_Employee_Relation(
	blood_id varchar(40) not null,
	employee_id varchar(50) not null,
    PRIMARY KEY(blood_id,employee_id),
	constraint fk_blood4 foreign key(blood_id) references BLOOD(Blood_ID)ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_empl2 foreign key(employee_id) references EMPLOYEE(Employee_ID) ON DELETE CASCADE ON UPDATE CASCADE 		
);

CREATE TABLE Employee_Donor_Relation(
	donor_id varchar(40) not null,
	employee_id varchar(50) not null,
    PRIMARY KEY(donor_id,employee_id),
	constraint fk_donor3 foreign key(donor_id) references DONOR(Donor_ID) ON DELETE CASCADE ON UPDATE CASCADE ,
	constraint fk_empl3 foreign key(employee_id) references EMPLOYEE(Employee_ID) ON DELETE CASCADE ON UPDATE CASCADE  		
);

CREATE TABLE Donor_BloodDonationCamp_Relation(
	donor_id varchar(40) not null,
	branch_id varchar(50) not null,
    camp_name varchar(50) not null,
	held_date date ,
    PRIMARY KEY(donor_id,branch_id,camp_name,held_date),
	constraint fk_donor4 foreign key(donor_id) references DONOR(Donor_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_branch2 foreign key(branch_id,camp_name,held_date) references BLOOD_DONATION_CAMP(Branch_ID,Camp_Name,Held_Date) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Blood_Patient_Relation(
	blood_id varchar(40) not null,
	patient_id varchar(50) not null,
    PRIMARY KEY(blood_id,patient_id),
	constraint fk_blood5 foreign key(blood_id) references BLOOD(Blood_ID)ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_patient4 foreign key(patient_id) references PATIENT(Patient_ID) ON DELETE CASCADE ON UPDATE CASCADE 		
);






