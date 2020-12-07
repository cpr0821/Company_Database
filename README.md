# Company_Database
This is the process that I went though to design and code a fully functional database in SQL for a generic marketing company.

Put assumptions/concerns/clarifications per requirement bullet in the document (dbproject.docx)
- EER diagram (Conceptual) (EER.png)
- Logical Schema (Logical with M:N and Multivalued modified) (dbproject.docx)
- Normalization (3NF) (dbproject.docx)
- Dependency Diagram for Normalization (dbproject.docx)
- Physical Schema (dbproject.docx)
- Script to create Physical Schema in Oracle (Create.sql)
- Insert data into those tables (Insert.sql)
- Answer queries (Views.sql)
- Project Questions (dbproject.docx)

The views and queries ran are in the views.sql file and they are also in the dbproject.docx with the outputs.

Requirements/Assumptions:

1)	For each department, department id and department name will be recorded.

Assumptions: N/A

2) People in the company can be divided into three types -- employees, customers, and potential employees. Each person can belong to more than one type. Each person in the company has the following attributes:  Personal_ID, Name (Last Name, First Name), Age (below 65), Gender, Address (address line 1, address line 2, city, state, zipcode), and Phone number (one individual may have more than one phone number). For customers, his/her preferred salesmen were recorded in the system. For employees, Rank and Title (e.g. CEO, Principle, Partner, etc.) will be recorded for them.

Assumptions: Rank and Title are interchangeable (only one attribute) 

3) Each employee of the company must have only one direct supervisor, while each supervisor can have several supervisees. One employee can work for one or more departments at different time. But at one time, one employee can only work for one department. The system needs to record start time and end time for each shift among different department for one employee.

Assumptions: Not all departments have a supervisor (some employees may not have a  direct supervisor) and not all supervisors have supervisees

4) Each job position’s information is recorded to hire new people. It contains the Job ID, job description, and posted date in the system.

Assumptions: Job_id same structure as personal_id

5) The job positions are posted by the departments. Both existing employees and potential employees can apply each job post by any department. The company will select some candidates from the applications and make interviews.

Assumptions: If a current employee applies for a job, they are guaranteed to have an interview

6) For each job position, several interviews will be made to select a suitable person.

Assumptions: doesn’t have to be a certain number - variable

7) For each interview, candidates (interviewees), interviewers, job position and interview time are recorded. After each round interview, the interviewers give a grade to it ranging from 0 to 100. The grade over 60 represents that the interviewee pass the interview. One person is selected when her/his average grade is over 70 and she/he passes at least 5 rounds of interviews.

Assumptions: The first person to pass all 5 interviews for a position gets the job, not everyone gets 5 interviews, each interview is conducted by one person to one other person

8) For each product in the company, the system needs to record Product ID, Product Type, Size, List Price, Weight, and Style.

Assumptions: Product id is similar to other id’s in structure, type will be the name and style will be the material it’s made of

9) There are many marketing sites for the company. For each site, Site ID, Site Name, and Site Location are recorded.

Assumptions: Site name will be marketing 

10) There are several people working for each site, and meanwhile, one person can work on different sites. It is able to track the details of each sale history --- salesmen, customers, product, sale time, and sites.

Assumptions: each individual sale is completed by a single salesman to a single customer on a single site

11) Part purchase is also a vital activity in the company. The system needs to record each vendor’s Vendor ID, Name, Address, Account Number, Credit Rating, and Purchasing Web Service URL.

Assumptions: this address will not be multivalued, these are not ‘people’ in the company

12) One vendor may supply many types of parts. The price of the same part type may vary from different vendors but the price of one part type of one vendor will keep same. It is able to track which part types used in each product and the number of each type of part used for the product.

Assumptions: no more than 9999 number of parts of one type, a product does not use the same type of part from different vendors

13) In addition, the system maintains the information of each employee’s monthly salary which includes transaction number, pay_date, and amount (Note: transaction number could be same among different employees. However, for each employee, the transaction number is unique).

Assumptions: the salaries can vary over the months, so they’re each potentially different amount values

