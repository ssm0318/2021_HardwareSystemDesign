
O
*Debug cores have already been implemented
153*	chipscopeZ16-240h px� 
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
42default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2546.8552default:default2
0.0002default:default2
11142default:default2
26182default:defaultZ17-722h px� 
[
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 12c732344
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.01 ; elapsed = 00:00:00.04 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1113 ; free virtual = 26182default:defaulth px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:00.012default:default2
2546.8552default:default2
0.0002default:default2
11112default:default2
26192default:defaultZ17-722h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: f3fa9951
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:03 ; elapsed = 00:00:02 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1180 ; free virtual = 26572default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 11ef381d4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:05 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1196 ; free virtual = 26362default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 11ef381d4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:05 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1196 ; free virtual = 26362default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 11ef381d4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:05 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1196 ; free virtual = 26372default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px� 
B
-Phase 2.1 Floorplanning | Checksum: fafb055b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:10 ; elapsed = 00:00:06 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1187 ; free virtual = 26292default:defaulth px� 


Phase %s%s
101*constraints2
2.2 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px� 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
0No setup violation found.  %s was not performed.344*physynth2-
DSP Register Optimization2default:defaultZ32-670h px� 
�
0No setup violation found.  %s was not performed.344*physynth2/
Shift Register Optimization2default:defaultZ32-670h px� 
�
0No setup violation found.  %s was not performed.344*physynth2.
BRAM Register Optimization2default:defaultZ32-670h px� 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:00.012default:default2
2546.8552default:default2
0.0002default:default2
10622default:default2
26682default:defaultZ17-722h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization                  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Very High Fanout              |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                  |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  Shift Register                |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  BRAM Register                 |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  HD Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                         |            0  |              0  |                     0  |           0  |           2  |  00:00:00  |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
R
=Phase 2.2 Physical Synthesis In Placer | Checksum: 17c9fe074
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:29 ; elapsed = 00:00:15 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1060 ; free virtual = 26682default:defaulth px� 
D
/Phase 2 Global Placement | Checksum: 196bef3f6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:30 ; elapsed = 00:00:16 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1113 ; free virtual = 26892default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 196bef3f6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:31 ; elapsed = 00:00:16 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1110 ; free virtual = 26872default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 16c6f7f10
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:34 ; elapsed = 00:00:18 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1057 ; free virtual = 26332default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 20c1b52e0
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:34 ; elapsed = 00:00:18 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1057 ; free virtual = 26332default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 11569be3d
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:34 ; elapsed = 00:00:18 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1057 ; free virtual = 26332default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 13a7d6690
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:37 ; elapsed = 00:00:21 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1082 ; free virtual = 26292default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
G
2Phase 3.6 Re-assign LUT pins | Checksum: a1e3cadd
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:38 ; elapsed = 00:00:21 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1092 ; free virtual = 26362default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 13af9ab3e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:38 ; elapsed = 00:00:21 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1088 ; free virtual = 26352default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 13af9ab3e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:38 ; elapsed = 00:00:21 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1085 ; free virtual = 26322default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 1de08ccda
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s bufg driver replicated, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason40*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-46h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 1de08ccda
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:42 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1090 ; free virtual = 26252default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
3.2772default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 12db58815
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1084 ; free virtual = 26212default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 12db58815
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1081 ; free virtual = 26182default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 12db58815
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1072 ; free virtual = 26162default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 12db58815
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1068 ; free virtual = 26142default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
2546.8552default:default2
0.0002default:default2
10702default:default2
26162default:defaultZ17-722h px� 
L
7Phase 4.4 Final Placement Cleanup | Checksum: edcd4358
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1061 ; free virtual = 26082default:defaulth px� 
[
FPhase 4 Post Placement Optimization and Clean-Up | Checksum: edcd4358
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1060 ; free virtual = 26072default:defaulth px� 
=
(Ending Placer Task | Checksum: c3906399
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:43 ; elapsed = 00:00:24 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1070 ; free virtual = 26172default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
792default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
place_design: 2default:default2
00:00:462default:default2
00:00:262default:default2
2546.8552default:default2
0.0002default:default2
10692default:default2
26152default:defaultZ17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
2546.8552default:default2
0.0002default:default2
10702default:default2
26182default:defaultZ17-722h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.022default:default2
00:00:00.012default:default2
2546.8552default:default2
0.0002default:default2
10592default:default2
26182default:defaultZ17-722h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:032default:default2
00:00:00.992default:default2
2546.8552default:default2
0.0002default:default2
10522default:default2
26182default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2]
I/home/jaewon/Documents/lab07/lab07.runs/impl_1/one_sec_checker_placed.dcp2default:defaultZ17-1381h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2&
write_checkpoint: 2default:default2
00:00:062default:default2
00:00:052default:default2
2546.8552default:default2
0.0002default:default2
10122default:default2
26372default:defaultZ17-722h px� 
j
%s4*runtcl2N
:Executing : report_io -file one_sec_checker_io_placed.rpt
2default:defaulth px� 
�
�report_io: Time (s): cpu = 00:00:00.13 ; elapsed = 00:00:00.18 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1001 ; free virtual = 2624
*commonh px� 
�
%s4*runtcl2�
vExecuting : report_utilization -file one_sec_checker_utilization_placed.rpt -pb one_sec_checker_utilization_placed.pb
2default:defaulth px� 
�
%s4*runtcl2k
WExecuting : report_control_sets -verbose -file one_sec_checker_control_sets_placed.rpt
2default:defaulth px� 
�
�report_control_sets: Time (s): cpu = 00:00:00.10 ; elapsed = 00:00:00.13 . Memory (MB): peak = 2546.855 ; gain = 0.000 ; free physical = 1011 ; free virtual = 2634
*commonh px� 


End Record