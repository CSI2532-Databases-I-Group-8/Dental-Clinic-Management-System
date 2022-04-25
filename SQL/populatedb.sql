-- Patient Info
INSERT INTO Patient_info VALUES (
    164645466, 
    '123 Sesame Street', 
    'Elmo Lee', 
    'M', 
    'elmo@elmail.com', 
    '6664206969', 
    TO_DATE('2000 01 01', 'YYYY MM DD'), -- constrained checked with '2008-01-01' https://onecompiler.com/postgresql/3xyjc6nst
    NULL,
    NULL
),
(111111111,'529 Random Road','Stephie McRandom','F','random@gmail.com','1231231234',TO_DATE('2012 01 01','YYYY MM DD'),'Random Insurance Company Inc.',ROW('Pat McRandom Sr.','1231231234','randomsenior@gmail.com','Dad')),
(111111112,'529 Random Road','Paul McRandomee','M','randomee@gmail.com','5551231234',
TO_DATE('2008 01 01','YYYY MM DD'),'Random Insurance Company Inc.',ROW('Bob McRandomee Sr.','1231231234','randomsenior@gmail.com','Dad')),
--(111111112,'529 Random Road','Random McRandom','F','random@gmail.com','1231231234',
--TO_DATE('2020 01 01','YYYY MM DD'),'Random Insurance Company Inc.',
--NULL), -- this will not work because rep is NULL, yet the age < 15
(515151547, '525 Elgin Street', 'Brooke Lay', 'F', 'brooke@gamil.com','3436589636',TO_DATE('2002 06 08', 'YYYY MM DD'),NULL,NULL),
(388498874, '1225 Imaginary Street, Toronto, ON, Canada', 'John Li', 'M', 'john@gmail.com','3437826548',TO_DATE('2000 09 03', 'YYYY MM DD'),NULL,NULL);

-- Patient
INSERT INTO Patient VALUES 
(DEFAULT,164645466), -- should be 1,2,3,4,5
(DEFAULT,111111111),
(DEFAULT,111111112),
(DEFAULT,515151547),
(DEFAULT,388498874);


-- Patient records
INSERT INTO Patient_records VALUES
(DEFAULT, 'Patient is going lose their teeth in 2 years if they do not book another appointment with us.', 1),
(DEFAULT,'Stephie current has healthy teeth. Only requires annual cleaning. Her last cleaning was 1 year ago.', 2),
(DEFAULT,'Paul Sr. had an annual teeth cleaning last year.', 3),
(DEFAULT,'Brooke needs invisalign because her teeth is crooked.',4),
(DEFAULT,'John needs cleaning. Last cleaning was last year. We also did teeth whitening with him recently.',5);


-- Employee Info 
INSERT INTO Employee_info VALUES (
  123456789,
  'r', -- constraint checked with 'f' (https://onecompiler.com/postgresql/3xxy77n5g)
  'Bob Marley',
  '123 Postgres Street, Ottawa, ON, Canada',
  60000.25123 -- tested - only shows 60000.25
), -- branch id has 1 receptionist
(141286236,'d','Tisham Islam', '123 Postgres Street, Ottawa, ON, Canada', 75000.50), -- dentist at branch id 1
(158453648,'d','Céline Wan', '123 Postgres Street, Ottawa, ON, Canada', 75000.50), -- dentist at branch id 1
(198523644,'h','Amy Kkiti', '123 Postgres Street, Ottawa, ON, Canada', 65000.50), -- hygenist at branch id 1
(165984846,'b','Kien Do', '523 Sesame Street, Ottawa, ON, Canada', 83000.50), -- manager at branch id 1

(388498874,'d','John Li', '1225 Imaginary Street, Toronto, ON, Canada', 70000.50), -- dentist at branch id 2, ALSO A PATIENT
(432364646,'d','Samy Touabi', '5346 Postgres Avenue, Toronto, ON, Canada', 70000.50), -- dentist at branch id 2
(665946369,'r','Oliva Mars', '355 MySQL Road, Toronto, ON, Canada', 55000.50), -- receptionist at branch id 2
(135941655,'r','Christopher Castillo', '885 NoSQL Drive, Toronto, ON, Canada', 55000.50), -- receptionist at branch id 2
(256356565,'h','Nakul Lover', '5243 MariaDB Crossing, Toronto, ON, Canada', 60000.50), -- hygienist at branch id 2
(956233565,'b','Bruno Bale', '420 Oracle Street, Toronto, ON, Canada', 83000.50); -- manager at branch id 2

-- Branch
INSERT INTO Branch VALUES 
(DEFAULT,'Ottawa', NULL, NULL, NULL),
(DEFAULT,'Toronto', NULL, NULL, NULL);

-- Employee
INSERT INTO Employee VALUES 
 -- Employees in branch id 1; 
(DEFAULT,123456789, 1), -- this is a receptionist at branch 1
(DEFAULT,141286236, 1),
(DEFAULT,158453648, 1),
(DEFAULT,198523644, 1),
(DEFAULT,165984846, 1), -- this is a manager at branch 1
 -- Employees in branch id 2
(DEFAULT,388498874, 2),
(DEFAULT,432364646, 2),
(DEFAULT,665946369, 2), -- receptionist 1 at branch 2
(DEFAULT,135941655, 2), -- receptionist 2 at branch 2
(DEFAULT,256356565, 2),
(DEFAULT,956233565, 2); -- this is a manager at branch 2
-- don't modify the insertions above to DEFAULT, just make the next insertions DEFAULT

-- Add managers and receptionists to the existing branches
UPDATE Branch
SET manager_id = 5,
receptionist1_id = 1
WHERE (city = 'Ottawa');

UPDATE Branch
SET manager_id = 11,
receptionist1_id = 8,
receptionist2_id = 9
WHERE (city = 'Toronto');

-- Procedure codes
INSERT INTO Procedure_codes VALUES
  (1, 'Teeth Cleanings'),
  (2, 'Teeth Whitening'),
  (3, 'Extractions'),
  (4, 'Veneers'),
  (5, 'Fillings'),
  (6, 'Crowns'),
  (7, 'Root Canal'),
  (8, 'Braces/invisalign'),
  (9, 'Bonding'),
  (10,'Dentures')
;

-- First the patient books an appointment (into a future date)
-- The patient is diagnosed in Treatment
-- Once the Treatment is prescribed, we then create a Appointment_procedure

-- Appointment
-- We could make a list/drop menu of dentists where the person who's doing 
-- the appt booking can choose a dentist
INSERT INTO Appointment VALUES
(DEFAULT,3,3,TO_DATE('2022 04 14', 'YYYY MM DD'),'10:00:00','11:00:00',3,'Completed',5), -- Make sure the 'Extractions' and 'Teeth Cleanings' match up with the procedure code in the Appointment_procedure table
 -- Stephie McRandom's appointments START
(DEFAULT,2,3,TO_DATE('2022 04 02', 'YYYY MM DD'),'08:30:00','09:00:00',2,'Cancelled',1),
(DEFAULT,2,3,TO_DATE('2022 04 03', 'YYYY MM DD'),'08:30:00','09:00:00',3,'No Show',2),
(DEFAULT,2,2,TO_DATE('2022 04 04', 'YYYY MM DD'),'10:00:00','11:00:00',3,'Completed',23),
(DEFAULT,2,2,TO_DATE('2022 04 05', 'YYYY MM DD'),'11:00:00','12:00:00',4,'Completed',21),
(DEFAULT,2,3,TO_DATE('2022 04 06', 'YYYY MM DD'),'09:00:00','10:00:00',1,'Completed',13),
(DEFAULT,2,6,TO_DATE('2022 05 20', 'YYYY MM DD'),'14:00:00','14:30:00',2,'Booked',11),
(DEFAULT,2,3,TO_DATE('2022 09 15', 'YYYY MM DD'),'10:00:00','11:00:00',8,'Booked',15),
 -- Stephie McRandom's appointments END
 -- Elmo appointment
(DEFAULT,1,6,TO_DATE('2022 10 1', 'YYYY MM DD'),'11:00:00','13:00:00',10,'Completed',8),
-- Paul's appointment
(DEFAULT,3,3,TO_DATE('2022 11 10', 'YYYY MM DD'),'15:00:00','16:00:00',6,'Booked',10),
-- Brooke's appointment
(DEFAULT,4,4,TO_DATE('2022 06 10', 'YYYY MM DD'),'14:00:00','15:00:00',8,'Booked',8),
-- John's appointment
(DEFAULT,5,4,TO_DATE('2022 04 15', 'YYYY MM DD'),'10:00:00','11:00:00',2,'Completed',3),
(DEFAULT,5,4,TO_DATE('2022 07 21', 'YYYY MM DD'),'10:00:00','11:00:00',1,'Booked',2);

-- Treatment
INSERT INTO Treatment VALUES
(DEFAULT, 'Extractions', 'Midazolam', 'Tooth ache', 23, 'Do not eat food 24 hours before the procedure.', 1, 1),
-- Stephie McRandom's treatments START
(DEFAULT, 'Teeth Whitening', 'No medications administered', 'No symptoms', 999, 'No comments', 2, 2),
(DEFAULT, 'Root Canal', 'Anesthesia', 'Dysarthria (Temporary speech impairment)', 33, 'Do not eat food 24 hours before the procedure. Cannot drive after the treatment.', 2, 3),
(DEFAULT, 'Bonding', 'No medications administered', 'No symptoms', 21, 'No comments', 2, 5),
(DEFAULT, 'Braces/invisalign', 'No medications administered', 'No symptoms', 999, 'Await further instructions from the orthodonist.', 2, 7),
-- Stephie McRandom's treatments END
-- John Li's treatment
(DEFAULT, 'Teeth Whitening', 'No medication administered', 'No symptoms',999,'Use the toothpaste recommended by the hygienist.', 5,12)
;

-- Appointment Procedure
INSERT INTO Appointment_procedure VALUES (
  DEFAULT,
  1,
  3,
  TO_DATE('2022 04 14', 'YYYY MM DD'),
  NULL,
  3,
  'We need to remove the wisdom tooth of the patient',
  8, -- this means quadrant 2, tooth #3 https://www.summerleadental.com/all-about-the-tooth-numbers/
  1, -- this means, remove 1 tooth
  NULL,
  NULL,
  500.00,
  NULL
),
-- Stephie McRandom's procedures START
(
  DEFAULT,2,2,TO_DATE('2022 04 02', 'YYYY MM DD'),NULL,2,'Annual patient dental cleaning',
  999, -- code for operation that involves every tooth
  1, --  means doctor does 1 cleaning
  NULL,NULL,00.00,NULL -- cancelled so price is 0
),
(
  DEFAULT,3,2,TO_DATE('2022 04 03', 'YYYY MM DD'),NULL,2,'Annual patient dental cleaning',
  999, -- code for operation that involves every tooth
  1, -- means doctor does 1 cleaning
  NULL,NULL,14.00,NULL -- no show - a charge of $14 is added to the patient's account
),
(
  DEFAULT,4,2,TO_DATE('2022 04 04', 'YYYY MM DD'),NULL,2,'Annual patient dental cleaning',
  999, -- code for operation that involves every tooth
  1, -- means doctor does 1 cleaning
  NULL,NULL,100,NULL -- teeth cleaning completed
),
(
  DEFAULT,5,2,TO_DATE('2022 04 05', 'YYYY MM DD'),NULL,2,'Teeth Whitening appointment',
  999, -- all teeth
  1, -- has to do 1 whitening
  NULL,NULL,1000,NULL -- root canal - cost is $1000
),
(
  DEFAULT,6,2,TO_DATE('2022 04 06', 'YYYY MM DD'),NULL,9,'Bonding appointment',
  21,
  1, -- 1 bonding to do
  NULL,NULL,500,NULL -- bonding Completed - cost is $500
),
(
  DEFAULT,7,2,TO_DATE('2022 09 15', 'YYYY MM DD'),NULL,8,'Invisalign appointment',
  999, -- code for operation that involves every tooth
  1, -- 1 Invisalign to do
  NULL,NULL,7200,NULL -- invisalign Booked
),
-- Stephie McRandom's procedures END
-- John Li's appointment procedure
(
  DEFAULT, 12, 5,TO_DATE('2022 04 15', 'YYYY MM DD'),NULL,2,'Teeth whitening appointment',
  999, -- means all teeth
  1, -- 1 whitening to do
  NULL,NULL,200,NULL -- cost of whitening
)
;


-- Fee charge
INSERT INTO Fee_charge VALUES
(DEFAULT, 1, 123,400), -- 123 is a random fee code for extractions
(DEFAULT, 1, 124,100), -- 124 is a random fee code for medications
-- Stephie McRandom's appointment procedure fee charges START
(DEFAULT, 2, -100,0), -- -100 is a random fee code for cancelled appointments
(DEFAULT, 3, 94303,14), -- 94303 is a code for no shows; automatic $14 charge
(DEFAULT, 4, 100,100), -- dental cleaning code 100 charge 100
(DEFAULT, 5, 107,800), -- root canal cost
(DEFAULT, 5, 125,200), -- root canal anesthesia cost
(DEFAULT, 6, 109,500), -- bonding cost
-- (DEFAULT, 7, 108,7200) -- invisalign cost
-- Stephie McRandom's appointment procedure fee charges END
-- John's fee charge
(DEFAULT, 8, 3423, 200) -- 3223 is code for whitening
;


-- Invoice (update Appointment_procedure depending on the values of Invoice)
INSERT INTO Invoice VALUES
(
  -- Elmo's invoice
  DEFAULT,
  TO_DATE('2022 04 05', 'YYYY MM DD'),
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  500,0,0,0,1 -- Elmo does not have insurance
),
  -- Stephie's invoices START
(
  DEFAULT,TO_DATE('2022 04 02', 'YYYY MM DD'), -- cancelled
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  0,0,0,0,2
),
(
  DEFAULT,TO_DATE('2022 04 03', 'YYYY MM DD'), -- no show
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  0,0,0,14,2
),
(
  DEFAULT,TO_DATE('2022 04 04', 'YYYY MM DD'), -- dental cleaning completed
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  20,80,0,0,2
),
(
  DEFAULT,TO_DATE('2022 04 05', 'YYYY MM DD'), -- root canal Completed
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  100,900,0,0,2
),
(
  DEFAULT,TO_DATE('2022 04 06', 'YYYY MM DD'), -- bonding Completed
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  300,200,0,0,2
),
-- (
--   DEFAULT,TO_DATE('2022 04 07', 'YYYY MM DD'), -- invisalign Completed
--   'The Downtown Dental Clinic
--   Ottawa ON K1P 6L7
--   (613) 234-0792
--   ',
--   7200,0,0,0,2
-- )
  -- Stephie's invoices END
  -- John's invoice
(
  DEFAULT,TO_DATE('2022 04 15', 'YYYY MM DD'), -- extractions Completed
  'Regional Dental Clinic
  Ottawa ON K1N 3M7
  (613) 985-1853
  ',
  200,000,0,0,5
)
;

-- Insurance_claim
INSERT INTO Insurance_claim VALUES
(DEFAULT,164645466,'SunLife Insurance','91833',200,1),
-- Random's Insurance claims START
(DEFAULT,111111111,'Random Insurance Company Inc.','11111',80,4),
(DEFAULT,111111111,'Random Insurance Company Inc.','11111',900,5),
(DEFAULT,111111111,'Random Insurance Company Inc.','11111',200,6)
-- Random's Insurance claims END
;


-- Appointment procedure
UPDATE Appointment_procedure -- Elmo does not have insurance
SET 
invoice_id = 1,
patient_charge = 500
WHERE (procedure_id = 1);

UPDATE Appointment_procedure -- Stephie has insurance; Cancelled
SET 
invoice_id = 2,
patient_charge = 0
WHERE (procedure_id = 2);

UPDATE Appointment_procedure -- Stephie has insurance; No show
SET 
invoice_id = 3,
patient_charge = 14
WHERE (procedure_id = 3);

UPDATE Appointment_procedure -- Stephie has insurance; Completed
SET 
invoice_id = 4,
insurance_charge = 80,
patient_charge = 20,
insurance_claim_id = 2
WHERE (procedure_id = 4);

UPDATE Appointment_procedure -- Stephie has insurance; Completed Root Canal
SET 
invoice_id = 5,
insurance_charge = 900,
patient_charge = 100,
insurance_claim_id = 3
WHERE (procedure_id = 5);

UPDATE Appointment_procedure -- Stephie has insurance; Completed Bonding
SET 
invoice_id = 6,
insurance_charge = 200,
patient_charge = 300,
insurance_claim_id = 4
WHERE (procedure_id = 6);

-- UPDATE Appointment_procedure -- Stephie has insurance; Completed invisalign
-- SET 
-- invoice_id = 7,
-- patient_charge = 7200
-- WHERE (procedure_id = 7);

UPDATE Appointment_procedure -- John has no insurance; Extractions completed
SET 
invoice_id = 7,
patient_charge = 200
WHERE (procedure_id = 8); 



-- Patient Billing
INSERT INTO Patient_billing VALUES
-- Stephie's bill
(DEFAULT,1,300,200,500,'Visa'),
(DEFAULT,2,14,0,14,'Cash/Debit'),
(DEFAULT,2,20,80,100,'Visa'),
(DEFAULT,2,100,900,1000,'Mastercard'),
(DEFAULT,2,300,200,500,'Mastercard'),
-- (DEFAULT,2,7200,0,7200,'Visa')
-- John's Bill
(DEFAULT, 5, 200,0,200,'Amex')
;


-- User Accounts
-- password is 'ASDFGHJKL:123456', entered value are hashed values
INSERT INTO user_account VALUES ('elmurder666', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 0, 1, NULL);
INSERT INTO user_account VALUES ('randommd5', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 0, 2, NULL);
INSERT INTO user_account VALUES ('randomeemd6', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 0, 3, NULL);
INSERT INTO user_account VALUES ('xXx_blayde_xXx', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 0, 4, NULL);
INSERT INTO user_account VALUES ('tisla2714', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 2);
INSERT INTO user_account VALUES ('cwmk3565', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 3);
INSERT INTO user_account VALUES ('akiti7935', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 4);
INSERT INTO user_account VALUES ('stoua0809', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 7);
INSERT INTO user_account VALUES ('kdo2342', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 5);
INSERT INTO user_account VALUES ('johnli255', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 2, 5, 6);
INSERT INTO user_account VALUES ('bobmley1', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 1); --receptionist
INSERT INTO user_account VALUES ('olvMar8', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 8); --receptionist
INSERT INTO user_account VALUES ('CrsClo9', '$2y$10$1q472H5E5tmeYWmKnSeuWOic2ooLuTLbU6gjSBrrwJEsp/Tq8uvpu', 1, NULL, 9); --receptionist

-- Review
INSERT INTO Review VALUES (
  DEFAULT,
  'Tisham Islam',
  'The dentist was very professional and clean, but he did not communicate with me very well',
  5, -- constraint is checked with values -1 and 6 (https://onecompiler.com/postgresql/3xxy4xntj)
  2,
  4,
  TO_DATE('2022 04 09', 'YYYY MM DD'),
  1
),
(
  DEFAULT,
  'Céline Wan',
  'I could not believe the service I received for this appointment. Absolutely horrible. You will be hearing about me on Yelp!!!',
  1,
  1,
  2,
  TO_DATE('2022 04 10', 'YYYY MM DD'),
  2
),
(
DEFAULT,
  'Amy Kkiti',
  'Amy is a very gentle and kind hygienist. The best out there! I definitely recommend taking an appointment with her!',
  5,
  5,
  4,
  TO_DATE('2022 04 24', 'YYYY MM DD'),
  1
);
