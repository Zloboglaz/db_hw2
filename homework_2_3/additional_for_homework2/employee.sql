CREATE TABLE IF NOT EXISTS department (
	department_id SERIAL PRIMARY KEY,
	department_name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS employee (
	employee_id SERIAL PRIMARY KEY,
	department_id INTEGER NOT NULL REFERENCES department(department_id),
	head_id INTEGER NULL REFERENCES employee(employee_id)
);