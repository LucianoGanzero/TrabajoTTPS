# README

## Avivas aplicación Web

En este documento se detallan los pasos a seguir para poner en funcionamiento la aplicación web de Avivas:  

No hay ninguna decisión anómala de diseño que valga la pena destacar.  

La autenticación se realizó usando el generador que proveé rails a partir de la versión 8.  
Intenté utilizar SearchKick para la indexación y las búsqueda, pero no pude hacer funcionar ElasticSearch, por lo que me terminé inclinando por AlgoliaSearch, que no requiere tener en funcionamiento nada en el servidor local, sino que trabaja haciendo solicitudes a una API.
Utilice figaro para ocultar las credenciales. Entiendo que sin ellas la busqueda no funciona, asi que cualquier cosa pueden pedirmelas. De todas maneras están en commits anteriores en la configuración de Algolia.

La aplicación soporta internacionalización en inglés.

Para poner en funcionamiento la aplicación es necesario ejecutar los siguientes comandos:
- rails db:create
- rails db:migrate
- rails db:seed
- bundle exec rails server -> Pone en funcionamiento la aplicación