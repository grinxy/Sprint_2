/*1*/ SELECT nombre FROM producto;
/*2*/ SELECT nombre, precio FROM producto;
/*3*/ SHOW COLUMNS FROM producto FROM tienda;
/*4*/ SELECT nombre, precio, precio * 1.08 FROM producto;
/*5*/ SELECT nombre as 'nombre de producto', precio as 'euros', precio * 1.08 as 'dolar Norte Americano' FROM producto;
/*6*/ SELECT UPPER(nombre), precio FROM producto;
/*7*/ SELECT LOWER(nombre), precio FROM producto;
/*8*/ SELECT nombre, UPPER(SUBSTR(nombre,1,2)) FROM fabricante;
/*9*/ SELECT nombre, ROUND(precio) FROM producto;
/*10*/ SELECT nombre, TRUNCATE(precio,0) FROM producto;
/*11*/ SELECT codigo_fabricante FROM producto;
/*12*/ SELECT DISTINCT codigo_fabricante FROM producto;
/*13*/ SELECT codigo_fabricante FROM producto ORDER BY codigo_fabricante ASC;
/*14*/ SELECT codigo_fabricante FROM producto ORDER BY codigo_fabricante DESC;
/*15*/ SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
/*16*/ SELECT * FROM fabricante LIMIT 5;
/*17*/ SELECT * FROM fabricante LIMIT 2 OFFSET 3;
/*18*/ SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
/*19*/ SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
/*20*/ SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante=2;
/*21*/ SELECT producto.nombre AS Porducto, producto.precio AS Precio, fabricante.nombre AS Fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*22*/ SELECT producto.nombre AS Porducto, producto.precio AS Precio, fabricante.nombre AS Fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY Fabricante ASC;
/*23*/ SELECT producto.codigo AS Codigo_Producto, producto.nombre AS Producto, fabricante.codigo AS Fabricante_Codigo, fabricante.nombre AS Fabricante FROM producto JOIN fabricante;
/*24*/ SELECT producto.nombre AS Porducto, producto.precio AS Precio, fabricante.nombre AS Fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio ASC LIMIT 1;
/*25*/ SELECT producto.nombre AS Porducto, producto.precio AS Precio, fabricante.nombre AS Fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio DESC LIMIT 1;
/*26*/ SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';
/*27*/ SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND precio>200;
/*28*/ SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus'OR fabricante.nombre ='Hewlett-Packard' OR fabricante.nombre= 'Seagate';
/*29*/ SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN('Asus', 'Hewlett-Packard', 'Seagate');
/*30*/ SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE SUBSTR(fabricante.nombre, -1) = 'e';
/*31*/ SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';
/*32*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;
/*33*/ SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
/*34*/ SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
/*35*/ SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.codigo IS NULL;
/*36*/ SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Lenovo');
/*37*/ SELECT * FROM producto WHERE precio = (SELECT MAX(producto.precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Lenovo'));
/*38*/ SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre ='Lenovo' ORDER BY precio DESC LIMIT 1;
/*39*/ SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%Hewlett%' ORDER BY precio ASC LIMIT 1;
/*40*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= (SELECT MAX(precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo');
/*41*/ SELECT * FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre ='Asus' AND producto.precio >=(SELECT AVG(precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre ='Asus');
