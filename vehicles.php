
<?php 

// Conectarse a y seleccionar una base de datos de MySQL llamada mi_empresa
// Nombre de host: 127.0.0.1, nombre de usuario: tu_usuario, contraseña: tu_contraseña, bd: mi_empresa

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$mysqli = new mysqli('localhost', 'root', '', 'Empresa');


if ($mysqli->connect_errno) {
    echo "Lo sentimos, este sitio web está experimentando problemas.";
    echo "Error: Fallo al conectarse a MySQL debido a: \n";
    echo "Errno: " . $mysqli->connect_errno . "\n";
    echo "Error: " . $mysqli->connect_error . "\n";
    exit;
}
$mysqli->set_charset("utf8");
?>
<!doctype html>
<html lang="es">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />    <title>Listado vehículos</title>
  </head>
  <body>
  <div class="container">
		<h1>Mi tienda de vehículos</h1>
		<div class="row">		
		
			<?php $sql = "SELECT * FROM vehicles";
			// Contectamos la sql con nuestra base de datos
			if ($resultado = mysqli_query($mysqli, $sql)) {
				//realizamos un bucle de nuestra tabla de vehiculos (si tiene 3 registros, se ejecutara 3 veces)
				while ($columnas = mysqli_fetch_assoc($resultado)) {?>
				
				<div class="col-md-6 mb-2">
					
					<div class="row g-0 border">
						
						<div class="col-sm-6 car-image-block">
							<a href="#"><img class="img-fluid" src="<?php echo $columnas['url_foto']; ?>"></a>
						</div>
						<div class="col-sm-6 card-body">
							<a href="#"><h3><?php echo $columnas['marca']." ".$columnas['model']; ?></h3> </a>
							<ul class="list-inline">
								<li class="list-inline-item"><i class="fas fa-tachometer-alt"></i> <?php echo $columnas['cv']; ?>CV</li>
								 <li class="list-inline-item"><i class="fas fa-user"></i> <?php echo $columnas['places']; ?> plazas</li>
								 <li class="list-inline-item"><i class="far fa-clock"></i> <?php echo $columnas['any']; ?></li>
							</ul>
							<p><?php echo $columnas['descripcio']; ?></p>
							<button type="button" class="btn btn-outline-danger">Comprar</button>
						</div>
								
					</div>

				</div>
			
				<?php } 		
			}else echo "Error"; ?>

		</div>
	</div>	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  </body>
</html>