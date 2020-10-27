$subscriptionId = Read-Host 'Specify your Azure Subscription ID?';
$downloadDirectory = Read-Host 'Specify your download location (For Example:C:\Invoices)?'
 
Login-AzureRmAccount
$SubscriptionName = (Get-AzureRmSubscription -SubscriptionId:$subscriptionId).Name
if ($SubscriptionName) {
	Set-AzureRmContext -SubscriptionId $subscriptionId
	$invoices = Get-AzureRmBillingInvoice -GenerateDownloadUrl
	foreach($invoice in $invoices)
	{
		Invoke-WebRequest -Uri $invoice.DownloadUrl -OutFile ($downloadDirectory + '\' +  $SubscriptionNane + "-" + $invoice.InvoicePeriodStartDate.ToString("dd/MM/yyyy").Replace("/","") + "-" + $invoice.InvoicePeriodEndDate.ToString("dd/MM/yyyy").Replace("/","") + '.pdf');
	}
}