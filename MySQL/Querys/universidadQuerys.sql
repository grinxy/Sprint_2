/*1*/ SELECT nombre, apellido1, apellido2 FROM persona ORDER BY apellido1, apellido2, nombre ASC;
/*2*/ SELECT nombre, apellido1, apellido2 FROM persona WHERE telefono IS NULL;
/*3*/ SELECT * FROM persona WHERE YEAR(fecha_nacimiento) = 1999;
/*4*/ SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND RIGHT(nif, 1) = 'k';
/*5*/ SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso=3 AND id_grado=7;
/*6*/ SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;
/*7*/ SELECT persona.nif, asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id WHERE persona.nif = '26902806M';
/*8*/ SELECT departamento.nombre, asignatura.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
/*9*/ SELECT CONCAT(persona.nombre, ' ', persona.apellido1, ' ', persona.apellido2) AS "alumno/a", asignatura.nombre, curso_escolar.anyo_inicio FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;

-- LEFT JOIN & RIGHT JOIN
/*1*/ SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
/*2*/ SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE departamento.nombre IS NULL;
/*3*/ SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_profesor IS NULL;
/*4*/ SELECT persona.nombre, persona.tipo, asignatura.id AS Asignatura FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL;
/*5*/ SELECT asignatura.nombre AS Asignatura, profesor.id_profesor FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE profesor.id_profesor IS NULL;
/*6*/ SELECT DISTINCT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL;

-- Consultas resumen
/*1*/ SELECT COUNT(id) FROM persona WHERE tipo ='alumno';
/*2*/ SELECT COUNT(id) FROM persona WHERE tipo ='alumno' AND YEAR(fecha_nacimiento) = 1999;
/*3*/ SELECT departamento.nombre, COUNT(profesor.id_profesor) AS Num_Profesores FROM departamento RIGHT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre  ORDER BY Num_Profesores DESC;
/*4*/ SELECT departamento.nombre, COUNT(profesor.id_profesor) AS Num_Profesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre  ORDER BY Num_Profesores DESC;
/*5*/ SELECT grado.nombre, COUNT(asignatura.id) AS Total_Asignaturas FROM grado  LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY Total_Asignaturas DESC;
/*6*/ SELECT grado.nombre, COUNT(asignatura.id) AS Total_Asignaturas FROM grado  LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING Total_Asignaturas > 40 ORDER BY Total_Asignaturas DESC;
/*7*/ SELECT grado.nombre, asignatura.tipo, COUNT(asignatura.creditos) AS Total_Creditos FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;
/*8*/ SELECT curso_escolar.anyo_inicio, COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno) AS Alumnos_Matriculados FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;  -- la id alumno puede haberse matriculado en varias asignaturas por curso.
/*9*/ SELECT profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS Total_asignaturas  FROM profesor INNER JOIN persona ON profesor.id_profesor = persona.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY profesor.id_profesor ORDER BY Total_asignaturas DESC;
/*1*/ SELECT * FROM persona WHERE tipo='alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
/*11*/ SELECT  persona.nombre, profesor.id_departamento, asignatura.id FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND profesor.id_departamento IS NOT NULL ;
