```bash
SW1-SWITCHFAKE# sh loop-protect

**********************************************
EJEMPLOD DE SALIDA DEL COMANDO
**********************************************

SW1-SWITCHFAKE# sh loop-protect

 Status and Counters - Loop Protection Information

  Transmit Interval (sec)     : 5
  Port Disable Timer (sec)    : 7200
  Loop Detected Trap          : Disabled
  Loop Protect Mode           : Port
  Loop Protect Enabled VLANs  :


         Loop    Loop     Detected  Loop   Time Since  Rx            Port
  Port   Protect Detected on VLAN   Count  Last Loop   Action        Status
  ------ ------- -------- --------- ------ ----------- ------------- --------
  1/1    Yes     No       NA        0                  send-disable  Down
  1/2    Yes     No       NA        0                  send-disable  Up
  1/3    Yes     No       NA        0                  send-disable  Up
  1/4    Yes     No       NA        0                  send-disable  Up
  1/5    Yes     No       NA        0                  send-disable  Up
  1/6    Yes     Yes      NA        0      1h 23m 14s  send-disable  Down
  1/7    Yes     No       NA        0                  send-disable  Down
  1/8    Yes     No       NA        0                  send-disable  Up

