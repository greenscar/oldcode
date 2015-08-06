<!--          

function FormValidation(ForceComplete)
	{       
	ThisForm = document.forms["DBForm"];
	var CompleteFlag = 1;  
	var index=0;
	var IncludedFields='';
	while (index<ThisForm.length)
		{
		IncludedFields += ThisForm.elements[index].name+' ';           
		if (ThisForm.elements[index].required==1)
			{
			if (ThisForm.elements[index].value=="")
        			{
        			ThisForm.elements[index].id="incomplete"; 
        			CompleteFlag=0;
        			} 
			else
				{
				ThisForm.elements[index].id="complete";
				}
			}
		index++;
		}

	ThisForm.Complete.value=CompleteFlag;     
	ThisForm.IncludedFields.value=IncludedFields;

	if (document.SpecialPageScripts != '')
		{eval(document.SpecialPageScripts);}
                                  
	if (CompleteFlag || !ForceComplete)
		{
		ThisForm.submit();
		return true; 
		}
	else
		{
		alert("Please complete the highlighted items.");
		return false;
		}
	}  

function Y2K(Year)
	{ 
	if (Year<100) 
		{alert('Please enter a 4-digit year');}
	}

function SumFields(FieldArray)
	{                              
	ThisForm = document.forms["DBForm"];
	var Index = 0;
	var Total = 0;   
	while (Index < FieldArray.length)
		{
		Total += isNaN(ThisForm[FieldArray[Index]].value)?0:Number(ThisForm[FieldArray[Index]].value);
		Index++;
		}  
	return Total;     
	}     

function SumColumn(ColumnName)
	{                              
	ThisForm = document.forms["DBForm"];
        var ColumnTotal=0; 
	var i = 1;
      	while (eval("ThisForm['"+ColumnName+i+"']"))
		{
		ColumnTotal+=Number(eval("ThisForm['"+ColumnName+i+"'].value"));
		i++;
		}   
	return ColumnTotal;
	}

function EmptyZero(Field)
	{Field.value = (Field.value=='')?0:Field.value;}

function LessValue(Field)
	{Field.value = -Math.abs(Field.value);}
//-->