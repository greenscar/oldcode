
function verify(recipe)
{
    return confirm("Are you sure you want to delete " + recipe + "?");
}

function submitform()
{
 if(document.myform.onsubmit())
 {//this check triggers the validations
    document.myform.submit();
 }
}
