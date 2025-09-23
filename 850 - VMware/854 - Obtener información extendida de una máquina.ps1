get-vm SKYNET | select name, @{Name="Nombre de la Propiedad"; Expression={$_.La.propiedad.deseada.de.la.tabla.de.abajo}}

# Tabla de propiedades disponibles
| **Nombre**        | **Propiedad**                          |
| ----------------- | -------------------------------------- |
| Nombre            | `$_.Name`                              |
| Nombre DNS        | `$_.Guest.HostName`                    |
| MoRef             | `$_.Id`                                |
| UUID              | `$_.ExtensionData.Config.InstanceUuid` |
| vCenter           | `$_.Uid.Split(" | ")[0].Split("@")[1]` |
| Cluster           | `$_.VMHost.Parent.Name`                |
| Host              | `$_.VMHost.Name`                       |
| Folder            | `$_.Folder.Name`                       |
| Tools Status      | `$_.Guest.ExtensionData.ToolsStatus`   |
| Tools Version     | `$_.Guest.ExtensionData.ToolsVersion`  |
| Direcciones IP    | `$_.Guest.IPAddress`                   |
| Custom Fields     | `$_.CustomFields`                      |
| Notas             | `$_.Notes`                             |
| Sistema Operativo | `$_.Guest.OSFullName`                  |
| Version Hardware  | `$_.HardwareVersion`                   |
| Cores CPU         | `$_.NumCpu`                            |
| Memoria RAM       | `$_.MemoryGB`                          |
| Espacio Ocupado   | `$_.UsedSpaceGB`                       |
| Fecha creación    | `$_.CreateDate`                        |

# Ejemplo:
PS C:\Users\espinete> get-vm SKYNET | select name, @{Name="Fecha"; Expression={$_.CreateDate}}

Name                Fecha
----                -----
SKYNET              05/08/2025 10:52:50

# Para ver todos los tipos de propiedades de tu vCenter:
$vm = get-vm SKYNET
$vm | get-member -MemberType Property

# Ejemplo:
PS C:\Users\espinete> $vm | get-member -MemberType Property


   TypeName: VMware.VimAutomation.ViCore.Impl.V1.VM.UniversalVirtualMachineImpl

Name                    MemberType Definition
----                    ---------- ----------
BootDelayMillisecond    Property   long BootDelayMillisecond {get;}
CoresPerSocket          Property   int CoresPerSocket {get;}
CpuHotAddEnabled        Property   System.Nullable[bool] CpuHotAddEnabled {get;}
CpuHotRemoveEnabled     Property   System.Nullable[bool] CpuHotRemoveEnabled {get;}
CreateDate              Property   System.Nullable[datetime] CreateDate {get;}
CustomFields            Property   System.Collections.Generic.IDictionary[string,string] CustomFields {get;}
DatastoreIdList         Property   string[] DatastoreIdList {get;}
DrsAutomationLevel      Property   System.Nullable[VMware.VimAutomation.ViCore.Types.V1.Cluster.DrsAutomationLevel] DrsAutomationLevel {get;}
ExtensionData           Property   System.Object ExtensionData {get;}
Folder                  Property   VMware.VimAutomation.ViCore.Types.V1.Inventory.Folder Folder {get;}
FolderId                Property   string FolderId {get;}
Guest                   Property   VMware.VimAutomation.ViCore.Types.V1.VM.Guest.VMGuest Guest {get;}
GuestId                 Property   string GuestId {get;}
HAIsolationResponse     Property   System.Nullable[VMware.VimAutomation.ViCore.Types.V1.Cluster.HAIsolationResponse] HAIsolationResponse {get;}
HardwareVersion         Property   string HardwareVersion {get;}
HARestartPriority       Property   System.Nullable[VMware.VimAutomation.ViCore.Types.V1.Cluster.HARestartPriority] HARestartPriority {get;}
Id                      Property   string Id {get;}
MemoryGB                Property   decimal MemoryGB {get;}
MemoryHotAddEnabled     Property   System.Nullable[bool] MemoryHotAddEnabled {get;}
MemoryHotAddIncrement   Property   System.Nullable[long] MemoryHotAddIncrement {get;}
MemoryHotAddLimit       Property   System.Nullable[long] MemoryHotAddLimit {get;}
MemoryMB                Property   decimal MemoryMB {get;}
MigrationEncryption     Property   System.Nullable[VMware.VimAutomation.ViCore.Types.V1.VM.VMMigrationEncryptionMode] MigrationEncryption {get;}
Name                    Property   string Name {get;}
Notes                   Property   string Notes {get;}
NumCpu                  Property   int NumCpu {get;}
PersistentId            Property   string PersistentId {get;}
PowerState              Property   VMware.VimAutomation.ViCore.Types.V1.Inventory.PowerState PowerState {get;}
ProvisionedSpaceGB      Property   decimal ProvisionedSpaceGB {get;}
ResourcePool            Property   VMware.VimAutomation.ViCore.Types.V1.Inventory.ResourcePool ResourcePool {get;}
ResourcePoolId          Property   string ResourcePoolId {get;}
SEVEnabled              Property   System.Nullable[bool] SEVEnabled {get;}
Uid                     Property   string Uid {get;}
UsedSpaceGB             Property   decimal UsedSpaceGB {get;}
VApp                    Property   VMware.VimAutomation.ViCore.Types.V1.Inventory.VApp VApp {get;}
Version                 Property   VMware.VimAutomation.ViCore.Types.V1.VM.VMVersion Version {get;}
VMHost                  Property   VMware.VimAutomation.ViCore.Types.V1.Inventory.VMHost VMHost {get;}
VMHostId                Property   string VMHostId {get;}
VMResourceConfiguration Property   VMware.VimAutomation.ViCore.Types.V1.VM.VMResourceConfiguration VMResourceConfiguration {get;}
VMSwapfilePolicy        Property   System.Nullable[VMware.VimAutomation.ViCore.Types.V1.VMSwapfilePolicy] VMSwapfilePolicy {get;}

# Que podemos verlo de esta forma, por ejemplo:
PS C:\Users\espinete> $vm.GuestId
ubuntu64Guest
PS C:\Users\espinete> $vm.HardwareVersion
vmx-19
PS C:\Users\espinete> $vm.CreateDate
lunes, 30 de diciembre de 2024 9:37:09
PS C:\Users\espinete> $vm.MemoryGB
4
