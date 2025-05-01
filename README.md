# README

## Avivas aplicación Web

En este documento se detallan los pasos a seguir para poner en funcionamiento la aplicación web de Avivas:  

## Implementación

No hay ninguna decisión anómala de diseño que valga la pena destacar.

La autenticación se realizó usando el generador que proveé rails a partir de la versión 8.  
Intenté utilizar SearchKick para la indexación y las búsqueda, pero no pude hacer funcionar ElasticSearch, por lo que me terminé inclinando por AlgoliaSearch, que no requiere tener en funcionamiento nada en el servidor local, sino que trabaja haciendo solicitudes a una API.
Utilice figaro para ocultar las credenciales: sin ellas la busqueda no funciona, y por tanto el seeder tampoco, asi que las envío adjuntas en el mail de confirmación, cualquier cosa pueden pedirmelas. Están en commits anteriores en la configuración de Algolia, antes de saber utilizar Figaro, pero si no me equivoco esas credenciales están vencidas. Para que funcionen hay que crear (debería crearse solo al ejecutar el bundle install) un archivo **application.yml** dentro del directorio **config** y completarlas con los nombres que están en *config/initializers/algoliasearch.rb*

La aplicación soporta internacionalización en inglés.

## Deployment

Teniendo configurado todo el entorno e instaladas las gemas, para poner en funcionamiento la aplicación es necesario ejecutar los siguientes comandos:
- rails db:create
- rails db:migrate
- rails db:seed
- bundle exec rails server -> Pone en funcionamiento la aplicación

## Funcionamiento
La página web puede usarse por cualquier usuario para ver los productos y realizar compras.
Para administrarla, es necesario iniciar sesión. En el seeder están las credenciales de los tres usuarios cargados, con tres roles distintos:
- **Admin**: lucianoganzero94@gmail.com; 123456
- **Gerente**: gerente@example.com; 123456
- **Empleado**: empleado@example.com; 123456

Las acciones de administración que puedan realizar estos perfiles se encuentran en el Dashboard, en la esquina superior derecha. En la pantalla de Dashboard cada uno tendrá acciones según el alcance de su perfil.  
En cuanto a las ventas, que son el apartado al que todos los perfiles pueden acceder, cada perfil puede agregar una venta nueva que repercutirá en los respectivos stocks y se le adjudicará a él. Pero además, y dado que los clientes pueden realizar ventas, hay ventas "sin adjudicar", que los empleados deben reclamar para sí. También pueden cancelarlas, en cuyo caso los stocks no se modificarán.