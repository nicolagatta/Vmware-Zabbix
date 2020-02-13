This is an short and dirty zabbix template with a powershell script to get performance metric

The template is designed with these assumptions
- a single host managed by a virtual center
- there are three datastores

The script is designed to 
- it connects to the vcenter with powercli and stay connected for performance reasons (no need to run many Connect-VIServer)
- it listens on localhost:port 
- it accepts GET /ESXhostname 
- Each GET request takes around 3 seconds to run on my systems:. Since the script it's not multithreaded, running multiple requests at the same time can result in some wait
- it outputs the Performance metric in a JSON format like this:
	
[
  {
    "PowerState": 1,
    "Version": "6.7.0",
    "CpuUsageMhz": "7691",
    "CpuTotalMhz": "28788",
    "MemoryUsageGB": "192.71875",
    "MemoryTotalGB": "319.906497955322265625",
    "VMCount": "16",
    "OverAllStatus": 1,
    "DatastoreCount": "3",
    "NumCpuPackages": "2",
    "NumCpucores": "12",
    "NumCpuThreads": "24",
    "Hz": "2399997945",
    "TotalVCPU": "46",
    "CPUWait": "1033",
    "mem_swapin_average": "0",
    "mem_swapused_average": "0",
    "mem_vmmemctl_average": "0",
    "mem_granted_average": "197637440",
    "mem_usage_average": "60.24",
    "mem_swapout_average": "0",
    "mem_active_average": "25525228",
    "volume_3_FreeSpaceGB": "8108.119140625",
    "volume_3_CapacityGB": "9215.75",
    "volume_3_VMFSVersion": "6.82",
    "volume_3_disk_devicelatency_average": "1",
    "volume_3_disk_busresets_summation": "0",
    "volume_3_disk_commandsaborted_summation": "0",
    "volume_3_disk_queuelatency_average": "0",
    "volume_3_disk_kernellatency_average": "0",
    "volume_2_FreeSpaceGB": "3110.8203125",
    "volume_2_CapacityGB": "10035",
    "volume_2_VMFSVersion": "5.61",
    "volume_2_disk_commandsaborted_summation": "0",
    "volume_2_disk_busresets_summation": "0",
    "volume_2_disk_devicelatency_average": "0",
    "volume_2_disk_kernellatency_average": "0",
    "volume_2_disk_queuelatency_average": "0",
    "volume_1_FreeSpaceGB": "2392.5029296875",
    "volume_1_CapacityGB": "9420.75",
    "volume_1_VMFSVersion": "5.61",
    "volume_1_disk_busresets_summation": "0",
    "volume_1_disk_commandsaborted_summation": "0",
    "volume_1_disk_devicelatency_average": "1",
    "volume_1_disk_kernellatency_average": "0",
    "volume_1_disk_queuelatency_average": "0"
  }
]

 
  
The zabbix template uses an external command like a shell script that executes "wget -qO - http://localhost:port/esxhostname" to get the JSON output.
Then it populates the items using JSON preprocessing
For performance metrics I tried to use metrics and thresholds according to some great articles
- http://www.yellow-bricks.com/esxtop/
- http://www.lucd.info/2010/01/13/powercli-vsphere-statistics-part-3-instances/

There are some metrics missing that I'm currently working on
  
