# FUDO CHALLENGE

Requisitos Previos:
* Ruby 3.1.4
* PostgreSQL 14
* Redis 7
* Docker y Docker Compose (opcional)
---
Pasos para instalar localmente el proyecto:
- 1: Clonar via HTTPS o SSH al destino deseado
- 2: Instalar PostgreSQL en el caso que no se tenga
- 3: Una vez dentro del proyecto, instalar dependencias: `bundle install`
- 4 (opcional): Configurar variables de entorno (RAILS_ENV, REDIS_URL, DBUSER, DBPASS, DBHOST)
- 5: Configurar una JWT Secret Key:
  * Ejecutar en la terminal `EDITOR="code --wait" bin/rails credentials:edit`
  * Agregar en el editor: `jwt_secret_key: <clave_generada>`
- 6: Crear y migrar la base de datos:
  * `rails db:create`
  * `rails db:migrate`
- 7:Iniciar redis y sidekiq:
  * `redis-server`
  * `bundle exec sidekiq`
- 8 (opcional): `rails db:seed` para precargar users
- 9: Asegurarse que pase todos los tests: `bundle exec rspec`
- 10: Iniciar el servidor: `rails s`
---
Ademas se puede ejecutar en docker:
 - 1: `docker compose build`
 - 2: `docker-compose run api bundle exec rails db:create db:migrate db:seed`
 - 3: `docker compose up`
---
Link a postman para probar los endpoints:
[postman requests](https://www.postman.com/speeding-shuttle-182691/workspace/public/collection/21763381-77a1a1c4-8273-4ddd-be38-6ac68013b331?action=share&creator=21763381&active-environment=21763381-5b4d140c-eb6d-4fed-be0e-497d170a039c)
