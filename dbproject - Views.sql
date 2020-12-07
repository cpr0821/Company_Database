CREATE VIEW VIEW_ONE AS 
        SELECT Person_id, AVG(amount) as average
        FROM monthly_salary
        GROUP BY person_id; 
        
CREATE VIEW VIEW_TWO AS
        SELECT person_id, job_id, COUNT (*) as Number_passed_interviews
        FROM INTERVIEW
        WHERE interview_grade > 70
        GROUP BY person_id, job_id;

CREATE VIEW VIEW_THREE AS
        SELECT PRODUCT.product_type, COUNT (*) as Num_sold
        FROM PRODUCT, SELLS
        WHERE PRODUCT.product_id = SELLS.product_id
        GROUP BY PRODUCT.product_type;
        
CREATE VIEW VIEW_FOUR AS
        SELECT PRODUCT.product_type, PARTS.part_type, PARTS.part_cost
        FROM  PARTS, PROD_PARTS, PRODUCT
        WHERE PRODUCT.product_id = PROD_PARTS.product_id AND PROD_PARTS.part_type = PARTS.part_type AND PROD_PARTS.vendor_id = PARTS.vendor_id;
        
# Queries

# 1: Return the the ID and Name of interviewers who participate in interviews where the applicant's name is "Hellen Cole" arrandged for job "11111"

SELECT INTERVIEW.interviewer_id, PERSON.Fname, PERSON.Lname 
FROM INTERVIEW, PERSON
WHERE INTERVIEW.job_id in ( SELECT job_id
        FROM PERSON, INTERVIEW
        WHERE PERSON.Fname = 'Hellen' AND PERSON.Lname = 'Cole' AND PERSON.person_id = INTERVIEW.person_id AND INTERVIEW.job_id = 11111) AND interview.interviewer_id = person.person_id;
        
        
# 2: Return the ID of all jobs which are posted by department "Marketing" in January, 2011

SELECT JOB.job_id
FROM JOB, DEPARTMENT
WHERE JOB.dept_id = department.department_id AND department.department_name = 'Marketing' AND EXTRACT(MONTH FROM job.posted_date) = 1 AND EXTRACT(YEAR FROM job.posted_date) = 2011;

# 3: Returnt the ID and name of the salesmen with no supervisees
SELECT person.person_id, person.fname, person.lname
FROM person, supervisor
WHERE person.person_id = supervisor.person_id AND supervisor.dept_id NOT IN (SELECT supervisor.dept_id
                                FROM CURR_DEPT, SUPERVISOR
                                WHERE curr_dept.dept_id = supervisor.dept_id AND CURR_DEPT.person_id != supervisor.person_id AND curr_dept.curr_dept = 'Y');
                                
# 4 : Return the ID and Location of the Marketing sites which have no sale records during March 2011
SELECT DISTINCT SITE.site_id, SITE.location
FROM JOB, DEPARTMENT, SITE
WHERE SITE.site_name = 'Marketing' AND NOT EXISTS(
                                                    SELECT *
                                                    FROM JOB, DEPARTMENT
                                                    WHERE job.dept_id = department.department_id AND department.department_name = 'Marketing' AND EXTRACT(MONTH FROM job.posted_date) = 3 AND EXTRACT(YEAR FROM job.posted_date) = 2011);

# 5 : Return the job's id and description which does not hire a suitable person one month after it is posted
SELECT job.job_id, job.description
FROM job JOIN interview ON job.job_id = interview.job_id
GROUP BY interview.person_id, job.job_id, job.description
HAVING COUNT(*) != 5 OR AVG(interview_grade) < 70;


# 6 : Return the ID and name of the salesmen who have sold all products that cost over $200
SELECT DISTINCT product.product_id
FROM product JOIN sells ON product.product_id = sells.product_id
WHERE product_price > 200.00;

SELECT sells.product_id, sells.salesman_id, person.fname, person.lname
FROM sells, person
WHERE person.person_id = sells.salesman_id
GROUP BY salesman_id, product_id, person.fname, person.lname;

# 7 : Return the department ID and name which has no job posting during 1/1/2011 and 2/1/2011
SELECT DISTINCT department.department_id, department.department_name
FROM JOB, DEPARTMENT
WHERE JOB.dept_id = department.department_id AND job.posted_date != TO_DATE('2011-01-01','YYYY-MM-DD') AND job.posted_date != TO_DATE('2011-02-01','YYYY-MM-DD');

# 8 : Return the ID, name, and dept ID of existing employees who apply to job '12345'
SELECT person.person_id, person.fname, person.lname, curr_dept.dept_id
FROM person, curr_dept, employee, applicant, interview 
WHERE person.person_id = employee.person_id AND employee.person_id = applicant.person_id AND person.person_id = curr_dept.person_id AND curr_dept = 'Y' AND person.person_id = interview.person_id AND interview.job_id = 12345;

# 9 : Return the best seller's type in the company (sold the most items)
SELECT product_type
FROM(SELECT product_type, COUNT(product_type)
    FROM product
    GROUP BY product_type
    ORDER BY COUNT(product_type) DESC)
WHERE ROWNUM = 1

# 10: Return the product type whose net profit is highest
SELECT product_type
FROM    (SELECT product.product_type, product.product_price,  sum(num_parts * part_cost) , (product.product_price - sum(num_parts * part_cost))
        FROM product JOIN prod_parts ON product.product_id=prod_parts.product_id JOIN parts ON prod_parts.vendor_id=parts.vendor_id AND prod_parts.part_type=parts.part_type
        GROUP BY product.product_type,product.product_price, product.product_id
        ORDER BY product.product_price - sum(num_parts * part_cost) DESC)
WHERE ROWNUM = 1;

# 11: Return the name and id of the employees who has worked in all departments
SELECT person_id, fname, lname
FROM person
WHERE person_id IN (SELECT curr_dept.person_id
FROM curr_dept JOIN department ON curr_dept.dept_id = department.department_id
GROUP BY curr_dept.person_id
HAVING COUNT(*) = (SELECT COUNT(*)FROM department));

# 12: Return the name and email addresses of the interviewee who is selected
SELECT person.fname, person.lname, applicant.email
FROM person, applicant
WHERE person.person_id IN (
SELECT interview.person_id
FROM interview
GROUP BY interview.person_id,interview.job_id
HAVING COUNT(*) = 5 AND AVG(interview.interview_grade) > 70.00) AND person.person_id = applicant.person_id;

# 13: Retreive the name, phone number, email address of the interviewees selected for all the jobs that they applied for
SELECT person.fname, person.lname, phone_num.phone_num, applicant.email
FROM person, applicant, phone_num
WHERE person.person_id IN (
SELECT interview.person_id
FROM interview
GROUP BY interview.person_id,interview.job_id
HAVING COUNT(*) = 5 AND AVG(interview.interview_grade) > 70.00) AND person.person_id NOT IN(SELECT interview.person_id
FROM interview
GROUP BY interview.person_id,interview.job_id
HAVING COUNT(*) != 5 OR AVG(interview.interview_grade) < 70.00) AND person.person_id = applicant.person_id AND phone_num.person_id = applicant.person_id;

# 14: Return the employee's name and id whose average monthly salary is highest in the company
SELECT person_id, fname, lname
FROM person
WHERE person_id = (
SELECT person_id
    FROM (SELECT Person_id, AVG(amount) 
        FROM monthly_salary
        GROUP BY person_id
    ORDER BY AVG(amount DESC)
WHERE ROWNUM = 1);

# 15: Return the ID and name of the vendor who supplies part 'Cup' and weight is less than 4 lbs and price is lowest amoung all vendors
SELECT vendor_id, vendor_name
FROM vendor
WHERE vendor_id = (
SELECT vendor_id
    FROM (SELECT vendor_id, MIN(part_cost) 
        FROM parts
        WHERE part_type = 'Cup' AND weight < 4.0
        GROUP BY vendor_id
    ORDER BY MIN(part_cost) ASC)
WHERE ROWNUM = 1);