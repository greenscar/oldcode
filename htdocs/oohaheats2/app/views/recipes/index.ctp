<?php
    $this->pageTitle = "Category List";
?>
<h1>Recipes</h1>
<table>
<tr>
    <th>ID</th>
    <th>NAME</th>
    <th>category</th>
</tr>
<?php foreach($recipes as $rec): ?>
<tr>
    <td><?php echo $rec['Recipe']['id']; ?></td>
    <td><?php echo $rec['Recipe']['name']; ?></td>
    <td><?php echo $rec['Category']['name']; ?></td>
    <td>
    <table>
        <?php foreach($rec['Ingredients'] as $ingredient): ?>
        <tr>
        <td>
        <?php
        foreach($ingredient as $key=>$val)
        {
            echo("$key => $val<br>");
        }
        ?>
            <td><?php echo $ingredient['quantity']; ?></td>
            <td><?php echo $ingredient['measurement_id']; ?></td>
            <td><?php echo $ingredient['Item']['name']; ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
    </td>
    <td>
    <table>
        <?php foreach($rec['Steps'] as $step): ?>
        <tr>
            <td><?php echo $step['order_num']; ?></td>
            <td><?php echo $step['descr']; ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
    </td>
</tr>
<?php endforeach; ?>
</table>
