<div class="db-description">
<p>
Sakila — это пример базы данных, разработанный компанией MySQL, специально созданный для обучения и демонстрации возможностей систем управления базами данных (СУБД) на основе реляционной модели.
</p><p>
База данных Sakila содержит 16 основных таблиц, описывающих различные аспекты компании по прокату DVD-дисков.
</p><p>
Ниже приведен список этих таблиц:
</p>
<p>Таблица `actor`</p>
<ul class="table-columns">
    <li> `actor_id` - уникальный идентификатор для каждого актера.</li>
    <li> `first_name` - имя актера.</li>
    <li> `last_name` - фамилия актера.</li>
    <li> `last_update` - временная метка, указывающая, когда запись была обновлена в последний раз.</li> 
</ul>
  <table>
    <tr>
      <th>actor_id</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>last_update</th>
    </tr>
    <tr>
      <td>1</td>
      <td>John</td>
      <td>Doe</td>
      <td>2023-01-01 12:00:00</td>
    </tr>
  </table>
  <p>Table `language`</p>
  <ul class="table-columns">
      <li> `language_id` - уникальный идентификатор для каждого языка.</li>
      <li> `name` - название языка.</li>
      <li> `last_update` - временная метка, указывающая, когда запись была обновлена в последний раз.</li> 
  </ul>
  <table>
    <tr>
      <th>language_id</th>
      <th>name</th>
      <th>last_update</th>
    </tr>
    <tr>
      <td>1</td>
      <td>English</td>
      <td>2023-01-01 12:00:00</td>
    </tr>
  </table>
</div>