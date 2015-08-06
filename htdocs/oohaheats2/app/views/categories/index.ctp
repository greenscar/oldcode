<?php
    $this->pageTitle = "Category List";
?>
<h1>Categories</h1>
<table>
<tr>
    <th>ID</th>
    <th>NAME</th>
</tr>
<?php foreach($categories as $cat): ?>
<tr>
    <td><?php echo $cat['Category']['id']; ?></td>
    <td><?php echo $cat['Category']['name']; ?></td>
</tr>
<?php endforeach; ?>
</table>
