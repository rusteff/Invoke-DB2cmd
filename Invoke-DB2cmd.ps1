<# 
 .Synopsis
  Function to scedule downtime for host in Nagios

 .Description
  Recursive function that will display all dependencies of any service or all services
  
 .Parameter Verbose
  Provides Verbose output which is useful for troubleshooting

 .Parameter Query
  Specifies one or more queries to be run.

 .Example
  Invoke-DB2cmd -query ""call reorgchk_tb_stats('T', 'ALL')  
 
#>

function Invoke-DB2cmd {
    param (
    [string]$Query
    )
    try {
    $cn = new-object system.data.OleDb.OleDbConnection("Provider=IBMDADB2;DSN=TSMDB1;User Id=;Password=;");
    $ds = new-object "System.Data.DataSet" "dtEmployee"
    $da = new-object "System.Data.OleDb.OleDbDataAdapter" ($Query, $cn)
    $da = $da.Fill($ds)
    $result = new-object "System.Data.DataTable" "dtEmployee"
    $result = $ds.Tables[0]
    return $result
    }
    catch {
    write-Error -Message ($Error[0].ToString() + "`n" + $Query)
    }
}