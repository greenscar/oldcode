//  Common Printable Version
//
//
//  DESCRIPTION
//  --------------------
//	
//	This function will be used by selected myHoldings pages in capturing the the table-data
//	information that will be used by gblComPrintVersion.asp as model results table.
//	**************************************************************************************
//	*  CR XRef:			Date:		Modified By:    Release/Description:
//	* CRPB174 & ARMA1245		Oct-11-02	Rodel Ocfemia	R7 Created javascript.
//	**************************************************************************************


function GetTableData(vTblID)
{
	frmCPP.txtCPP.value = vTblID.innerHTML;
	frmCPP.submit();
}
