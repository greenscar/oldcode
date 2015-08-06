<!-- File: /app/views/posts/index.ctp -->
<h1>Blog posts</h1>
<table>
<tr>
<th>Id</th>
<th>Title</th>
<th>Edit / Delete</th>
<th>Created</th>
</tr>
<!-- Here is where we loop through our $posts array, printing out post info -->
<?php foreach ($posts as $post): ?>
    <tr>
        <td><?php echo $post['Post']['id']; ?></td>
        <td>
            <?php echo $html->link($post['Post']['title'], "/posts/view/".$post['Post']['id']); ?>
        </td>
        <!--
            This view code also uses the HtmlHelper to prompt the user with a JavaScript confirmation dialog before they attempt to delete a post.
        -->
        <td>
            <?php echo $html->link('Edit', array('action'=>'edit', 'id'=>$post['Post']['id']));?>
            <?php echo $html->link('Delete', array('action' => 'delete', 'id' => $post['Post']['id']), null, 'Are you sure?' )?>
        </td>
        <td><?php echo $post['Post']['created']; ?></td>
    </tr>
<?php endforeach; ?>
<?php echo $html->link('Add Post',array('controller' => 'posts', 'action' => 'add'))?>
</table>

