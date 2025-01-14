function Set-CIPPHideFromGAL {
    [CmdletBinding()]
    param (
        $userid,
        $tenantFilter,
        [bool]$HideFromGAL,
        $ExecutingUser
    )

    try {
        $body = @{
            showInAddressList = [bool]$HideFromGAL
        } | ConvertTo-Json -Compress -Depth 1
        $HideRequest = New-GraphPostRequest -uri "https://graph.microsoft.com/v1.0/users/$($userid)" -tenantid $tenantFilter -type PATCH -body $body -verbose
        Write-LogMessage -user $ExecutingUser -API "Hide From Address List"  -message "Hid $($userid) from address list" -Sev "Info"  -tenant $TenantFilter
        return "Hidden $($userid) from address list"
    }
    catch {
        Write-LogMessage -user $ExecutingUser -API "Hide From Address List"  -message "Could not hide $($userid) from address list" -Sev "Error" -tenant $TenantFilter
        return "Could not hide $($userid) from address list. Error: $($_.Exception.Message)"
    }
}
