CREATE TABLE
  patients (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  medical_histories (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    status VARCHAR(50),
    patient_id INT,
    admitted_at TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id) REFERENCES patients (id)
  );

CREATE TABLE
  invoices (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
  );

CREATE TABLE
  treatments (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    type varchar(50),
    name varchar(50)
  );

CREATE TABLE
  invoice_items (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (invoice_id) REFERENCES invoices (id),
    FOREIGN KEY (treatment_id) REFERENCES treatments (id)
  );

CREATE TABLE
  medical_histories_treatments (
    medical_history_id INT,
    treatment_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id),
    FOREIGN KEY (treatment_id) REFERENCES treatments (id)
  );

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON medical_histories_treatments (medical_history_id);
CREATE INDEX ON medical_histories_treatments (treatment_id);