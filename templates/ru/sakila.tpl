<style>
table {
  border-collapse: collapse;
  width: 100%;
  font-size: smaller;
}

th, td {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}
.db-description {
    padding: 12px;
}
</style>
<div class="db-description">
<p>
Sakila — это пример базы данных, разработанный компанией MySQL, специально созданный для обучения и демонстрации возможностей систем управления базами данных (СУБД) на основе реляционной модели.
</p><p>
База данных Sakila содержит 16 основных таблиц, описывающих различные аспекты компании по прокату DVD-дисков.
</p><p>
Ниже приведен список этих таблиц:</p>
<p>Actor Table</p>
<ul class="table-columns">
    <li> actor_id: Unique identifier for each actor.</li>
    <li> first_name: First name of the actor.</li>
    <li> last_name: Last name of the actor.</li>
    <li> last_update: Timestamp indicating when the record was last updated.</li> 
</ul>
  <table>
    <tr>
      <th>actor_id</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>last_update</th>
    </tr>
    <!-- Sample Data Rows -->
    <tr>
      <td>1</td>
      <td>John</td>
      <td>Doe</td>
      <td>2023-01-01 12:00:00</td>
    </tr>
    <!-- More rows go here -->
  </table>
  <p>Address Table</p>
  <table>
    <!-- Similar structure as Actor Table -->
  </table>
  <p>Category Table</p>
  <table>
    <!-- Similar structure as Actor Table -->
  </table>
  <p>City Table</p>
  <table>
    <!-- Similar structure as Actor Table -->
  </table>
  <p>Country Table</p>
  <table>
    <!-- Similar structure as Actor Table -->
  </table>
  <p>Customer Table</p>
  <table>
    <!-- Similar structure as Actor Table -->
  </table>
</div>