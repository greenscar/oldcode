<%         

{
package LinkTable;
@ISA = ('SQLTable');
}
     
$LinkTable =LinkTable->new(); 
$LinkTable->TableName('LinkTable');
$LinkTable->PrimaryIndex('ID');
$LinkTable->FieldData(
	{
        'ID'=>
		{
		'type'=>'adVarWChar',
		'size'=>'8',
		'value'=>[]		
		}, 
        'Title'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		}, 
        'Description'=>
		{
		'type'=>'adVarWChar',
		'size'=>'240',
		'value'=>[]		
		}, 
        'Address'=>
		{
		'type'=>'adVarWChar',
		'size'=>'80',
		'value'=>[]		
		}, 
        'Profile'=>
		{
		'type'=>'adVarWChar',
		'size'=>'60',
		'value'=>[]		
		}
	}); 
%>
