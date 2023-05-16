-- ----------------------------------------------------------------------------------------------------------------------------------------
-- Exercício 2
-- ----------------------------------------------------------------------------------------------------------------------------------------

SELECT Student.Roll_No, Student.Nome, Address.Street
FROM trabalho_m1.Student
INNER JOIN trabalho_m1.Address ON Student.Address_ID = Address.Address_ID
INNER JOIN trabalho_m1.Student_Phone ON Student.Roll_No = Student_Phone.Roll_No
WHERE Address.City = 'Ulm';