<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    {* The landing page /es/database/sakila has its own intro and ER diagram: only the table list there *}
    {if ($Action|default:'') != 'database'}
    <h2>Base de datos Sakila: estructura de tablas y visión general del esquema</h2>
    <p>Sakila es una base de datos relacional de muestra diseñada por MySQL para aprender y demostrar las capacidades de SQL y de los sistemas de gestión de bases de datos relacionales (RDBMS).</p>
    <p>Esta página presenta la estructura de las tablas de Sakila, las columnas clave y las restricciones comúnmente utilizadas en consultas SQL educativas.</p>
    <p>La base de datos Sakila contiene 15 tablas principales que describen varios aspectos de una empresa de alquiler de DVD.</p>
    <p>
        <a href="/{$Lang}/erd/Sakila" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir el diagrama ER de la base de datos Sakila en una nueva ventana">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER de la base de datos Sakila mostrando las relaciones entre tablas" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Diagrama ER de la base de datos Sakila
        </a>
    </p>
    <p><a href="/{$Lang}/database/sakila">Más sobre la base de datos Sakila: esquema, consultas de ejemplo y todos los ejercicios →</a></p>
    {/if}
    <h3>La lista de tablas</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>actor</span> - tabla de actores.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>first_name</span>nombre del actor</li>
            <li> <span class='sql'>last_name</span>apellido del actor</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">actor_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (actor_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>address</span> - direcciones de clientes y personal.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>address</span>dirección postal</li>
            <li> <span class='sql'>address2</span>dirección adicional</li>
            <li> <span class='sql'>district</span>distrito o región</li>
            <li> <span class='sql'>city_id</span>identificador de la ciudad (FK)</li>
            <li> <span class='sql'>postal_code</span>código postal</li>
            <li> <span class='sql'>phone</span>número de teléfono</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">address_id</th>
                <th scope="col">address</th>
                <th scope="col">address2</th>
                <th scope="col">district</th>
                <th scope="col">city_id</th>
                <th scope="col">postal_code</th>
                <th scope="col">phone</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>123 Main St</td>
                <td>[null]</td>
                <td>Downtown</td>
                <td>1</td>
                <td>12345</td>
                <td>+1234567890</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (address_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (city_id) REFERENCIAS city(city_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>category</span> - categorías de películas.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>name</span>nombre de la categoría</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">category_id</th>
                <th scope="col">name</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>Acción</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (category_id)</li>
        </ul>    
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>city</span> - tabla de ciudades.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>city</span>nombre de la ciudad</li>
            <li> <span class='sql'>country_id</span>identificador del país (FK)</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">city_id</th>
                <th scope="col">city</th>
                <th scope="col">country_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>Metropolis</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (city_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (country_id) REFERENCIAS country(country_id)</li>
        </ul>
    </div>    
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>country</span> - tabla de países.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>country</span>nombre del país</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">country_id</th>
                <th scope="col">country</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>Estados Unidos</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (country_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>customer</span> - tabla de clientes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>store_id</span>identificador de la tienda (FK)</li>
            <li> <span class='sql'>first_name</span>nombre del cliente</li>
            <li> <span class='sql'>last_name</span>apellido del cliente</li>
            <li> <span class='sql'>email</span>dirección de correo electrónico del cliente</li>
            <li> <span class='sql'>address_id</span>identificador de la dirección (FK)</li>
            <li> <span class='sql'>active</span>indicador de actividad del cliente (0/1)</li>
            <li> <span class='sql'>create_date</span>fecha y hora en que se agregó el cliente a la base de datos</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">customer_id</th>
                <th scope="col">store_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">email</th>
                <th scope="col">address_id</th>
                <th scope="col">active</th>
                <th scope="col">create_date</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (customer_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (store_id) REFERENCIAS store(store_id)</li>
            <li>CLAVE FORÁNEA (address_id) REFERENCIAS address(address_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>film</span> - tabla de películas.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 13rem;">film_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql' style="min-width: 13rem;">title</span>título de la película</li>
            <li> <span class='sql' style="min-width: 13rem;">description</span>breve descripción o trama de la película</li>
            <li> <span class='sql' style="min-width: 13rem;">release_year</span>año en que se lanzó la película</li>
            <li> <span class='sql' style="min-width: 13rem;">language_id</span>identificador del idioma de la película (FK)</li>
            <li> <span class='sql' style="min-width: 13rem;">original_language_id</span>identificador del idioma original de la película en caso de que esté doblada a un nuevo idioma</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_duration</span>duración del período de alquiler en días</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_rate</span>costo de alquilar la película por la duración especificada en la columna rental_duration</li>
            <li> <span class='sql' style="min-width: 13rem;">length</span>duración de la película en minutos</li>
            <li> <span class='sql' style="min-width: 13rem;">replacement_cost</span>monto de penalización por pérdida o daño del disco</li>
            <li> <span class='sql' style="min-width: 13rem;">rating</span>calificación asignada a la película. Puede ser una de: G, PG, PG-13, R, o NC-17</li>
            <li> <span class='sql' style="min-width: 13rem;">special_features</span>lista de características especiales incluidas en el DVD. Puede ser cero o más de: Tráilers, Comentarios, Escenas eliminadas, Detrás de cámaras</li>
            <li> <span class='sql' style="min-width: 13rem;">last_update</span>fecha y hora de la última actualización</li>
          </ul>
          <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">film_id</th>
                <th scope="col">title</th>
                <th scope="col">description</th>
                <th scope="col">release_year</th>
                <th scope="col">language_id</th>
                <th scope="col">original_language_id</th>
                <th scope="col">rental_duration</th>
                <th scope="col">rental_rate</th>
                <th scope="col">length</th>
                <th scope="col">replacement_cost</th>
                <th scope="col">rating</th>
                <th scope="col">special_features</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>Título de la película</td>
                <td>Una breve descripción de la película.</td>
                <td>2000</td>
                <td>1</td>
                <td>2</td>
                <td>5</td>
                <td>4.99</td>
                <td>120</td>
                <td>19.99</td>
                <td>PG-13</td>
                <td>Tráilers, Comentarios</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (film_id)</li>
          </ul>
                    <ul class="table-columns">
                        <li>CLAVE FORÁNEA (language_id) REFERENCIAS language(language_id)</li>
                        <li>CLAVE FORÁNEA (original_language_id) REFERENCIAS language(language_id)</li>
                    </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>film_actor</span> - relación actores a películas.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identificador del actor (FK)</li>
            <li> <span class='sql'>film_id</span>identificador de la película (FK)</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li>
          </ul>
          <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">actor_id</th>
                <th scope="col">film_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (actor_id, film_id)</li>
                    </ul>
                    <ul class="table-columns">
                        <li>CLAVE FORÁNEA (actor_id) REFERENCIAS actor(actor_id)</li>
                        <li>CLAVE FORÁNEA (film_id) REFERENCIAS film(film_id)</li>
                    </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>film_category</span> - relación películas a categorías.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>film_id</span>identificador de la película (FK)</li>
            <li> <span class='sql'>category_id</span>identificador de la categoría (FK)</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li>
          </ul>
          <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">film_id</th>
                <th scope="col">category_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
              <li>CLAVE PRIMARIA, btree (film_id, category_id)</li>
          </ul>
          <ul class="table-columns">
              <li>CLAVE FORÁNEA (film_id) REFERENCIAS film(film_id)</li>
              <li>CLAVE FORÁNEA (category_id) REFERENCIAS category(category_id)</li>
          </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>inventory</span> - inventario de discos en las tiendas.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>inventory_id</span>identificador único del registro (PK)</li>
            <li><span class='sql'>film_id</span>identificador de la película (FK)</li>
            <li><span class='sql'>store_id</span>identificador de la tienda donde se encuentra el disco (FK)</li>
            <li><span class='sql'>last_update</span>fecha y hora de la última actualización</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                    <th scope="col">inventory_id</th>
                    <th scope="col">film_id</th>
                    <th scope="col">store_id</th>
                    <th scope="col">last_update</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>1</td>
                    <td>23</td>
                    <td>2</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (inventory_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (film_id) REFERENCIAS film(film_id)</li>
            <li>CLAVE FORÁNEA (store_id) REFERENCIAS store(store_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>language</span> - idiomas de las películas.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>language_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>name</span>nombre del idioma</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                    <th scope="col">language_id</th>
                    <th scope="col">name</th>
                    <th scope="col">last_update</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>1</td>
                    <td>English</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (language_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>payment</span> - pagos de los clientes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">payment_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql' style="min-width: 8rem;">customer_id</span>identificador del cliente (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">staff_id</span>identificador del empleado que recibió el pago (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">rental_id</span>identificador del alquiler (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">amount</span>importe del pago</li>
            <li> <span class='sql' style="min-width: 8rem;">payment_date</span>fecha y hora del pago</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>fecha y hora de la última actualización</li>
        </ul>
        <div class="table-wrapper">
        <table>
                <thead>
                    <tr>
                <th scope="col">payment_id</th>
                <th scope="col">customer_id</th>
                <th scope="col">staff_id</th>
                <th scope="col">rental_id</th>
                <th scope="col">amount</th>
                <th scope="col">payment_date</th>
                <th scope="col">last_update</th>
            </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>4.99</td>
                <td>2023-01-01 12:13:14</td>
                <td>2023-01-01 12:14:15</td>
            </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (payment_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (customer_id) REFERENCIAS customer(customer_id)</li>
            <li>CLAVE FORÁNEA (staff_id) REFERENCIAS staff(staff_id)</li>
            <li>CLAVE FORÁNEA (rental_id) REFERENCIAS rental(rental_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>rental</span> - alquileres de los clientes.
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class='sql'>rental_id</span>identificador único del registro (PK)</li>
        <li> <span class='sql'>rental_date</span>fecha de inicio del alquiler</li>
        <li> <span class='sql'>inventory_id</span>identificador del disco (FK)</li>
        <li> <span class='sql'>customer_id</span>identificador del cliente (FK)</li>
        <li> <span class='sql'>return_date</span>fecha de devolución de la película</li>
        <li> <span class='sql'>staff_id</span>identificador del empleado que entregó el disco (FK)</li>
        <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li>
        </ul>
        <div class="table-wrapper">
        <table>
                <thead>
                    <tr>
                <th scope="col">rental_id</th>
                <th scope="col">rental_date</th>
                <th scope="col">inventory_id</th>
                <th scope="col">customer_id</th>
                <th scope="col">return_date</th>
                <th scope="col">staff_id</th>
                <th scope="col">last_update</th>
            </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>2023-01-01 16:15:21</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-10 09:12:36</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (rental_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (inventory_id) REFERENCIAS inventory(inventory_id)</li>
            <li>CLAVE FORÁNEA (customer_id) REFERENCIAS customer(customer_id)</li>
            <li>CLAVE FORÁNEA (staff_id) REFERENCIAS staff(staff_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>staff</span> - empleados de la empresa.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>staff_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql'>first_name</span>nombre del empleado</li>
            <li> <span class='sql'>last_name</span>apellido del empleado</li>
            <li> <span class='sql'>address_id</span>identificador de la dirección (FK)</li>
            <li> <span class='sql'>picture</span>foto del empleado</li>
            <li> <span class='sql'>email</span>dirección de correo electrónico del empleado</li>
            <li> <span class='sql'>store_id</span>identificador de la tienda (FK)</li>
            <li> <span class='sql'>active</span>indicador de actividad del empleado (0/1)</li>
            <li> <span class='sql'>username</span>nombre de usuario para iniciar sesión</li>
            <li> <span class='sql'>password</span>contraseña para iniciar sesión</li>
            <li> <span class='sql'>last_update</span>fecha y hora de la última actualización</li>
        </ul>
        <div class="table-wrapper">
        <table>
                <thead>
                    <tr>
                <th scope="col">staff_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">address_id</th>
                <th scope="col">picture</th>
                <th scope="col">email</th>
                <th scope="col">store_id</th>
                <th scope="col">active</th>
                <th scope="col">username</th>
                <th scope="col">password</th>
                <th scope="col">last_update</th>
            </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>1</td>
                <td>[null]</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>johndoe</td>
                <td>********</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (staff_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (address_id) REFERENCIAS address(address_id)</li>
            <li>CLAVE FORÁNEA (store_id) REFERENCIAS store(store_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span class='sql'>store</span> - tiendas de la empresa.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 11rem;">store_id</span>identificador único del registro (PK)</li>
            <li> <span class='sql' style="min-width: 11rem;">manager_staff_id</span>identificador del gerente de la tienda (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">address_id</span>identificador de la dirección (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">last_update</span>fecha y hora de la última actualización</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                  <th scope="col">store_id</th>
                  <th scope="col">manager_staff_id</th>
                  <th scope="col">address_id</th>
                  <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                  <td>1</td>
                  <td>1</td>
                  <td>1</td>
                  <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (store_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (manager_staff_id) REFERENCIAS staff(staff_id)</li>
            <li>CLAVE FORÁNEA (address_id) REFERENCIAS address(address_id)</li>
        </ul>
    </div>
</div>
