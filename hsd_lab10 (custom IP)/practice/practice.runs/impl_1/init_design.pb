
>
Refreshing IP repositories
234*coregenZ19-234h px� 
�
 Loaded user IP repository '%s'.
1135*coregen2>
*/home/jaewon/Documents/lab10/lab10_ip_repo2default:defaultZ19-1700h px� 
�
"Loaded Vivado IP repository '%s'.
1332*coregen27
#/tools/Xilinx/Vivado/2018.3/data/ip2default:defaultZ19-2313h px� 
|
Command: %s
53*	vivadotcl2K
7link_design -top design_1_wrapper -part xc7z020clg484-12default:defaultZ4-113h px� 
g
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_12default:defaultZ12-437h px� 
j
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_12default:defaultZ12-434h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_0/design_1_axi_bram_ctrl_0_0.dcp2default:default2.
design_1_i/axi_bram_ctrl_02default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0.dcp2default:default2,
design_1_i/blk_mem_gen_02default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
t/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_myip_0_0/design_1_myip_0_0.dcp2default:default2%
design_1_i/myip_02default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.dcp2default:default23
design_1_i/processing_system7_02default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_rst_ps7_0_50M_0/design_1_rst_ps7_0_50M_0.dcp2default:default2,
design_1_i/rst_ps7_0_50M2default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
p/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_xbar_0/design_1_xbar_0.dcp2default:default24
 design_1_i/axi_mem_intercon/xbar2default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
v/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_0/design_1_auto_pc_0.dcp2default:default2D
0design_1_i/axi_mem_intercon/m01_couplers/auto_pc2default:defaultZ1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2�
v/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_1/design_1_auto_pc_1.dcp2default:default2D
0design_1_i/axi_mem_intercon/s00_couplers/auto_pc2default:defaultZ1-454h px� 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
552default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2018.32default:defaultZ1-479h px� 
V
Loading part %s157*device2#
xc7z020clg484-12default:defaultZ21-403h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
�
NRemoving redundant IBUF since it is not being driven by a top-level port. %s 
32*opt2]
Idesign_1_i/myip_0/inst/myip_v1_0_S00_AXI_inst/u_clk_180/inst/clkin1_ibufg2default:defaultZ31-32h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2 
IBUF_LOW_PWR2default:default24
design_1_i/myip_0/s00_axi_aclk2default:default2 
IBUF_LOW_PWR2default:default8Z18-550h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
|/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_myip_0_0/src/clk_wiz_0_4/clk_wiz_0.xdc2default:default2R
<design_1_i/myip_0/inst/myip_v1_0_S00_AXI_inst/u_clk_180/inst	2default:default8Z20-848h px� 
�
%Done setting XDC timing constraints.
35*timing2�
|/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_myip_0_0/src/clk_wiz_0_4/clk_wiz_0.xdc2default:default2
572default:default8@Z38-35h px� 
�
Deriving generated clocks
2*timing2�
|/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_myip_0_0/src/clk_wiz_0_4/clk_wiz_0.xdc2default:default2
572default:default8@Z38-2h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
get_clocks: 2default:default2
00:00:072default:default2
00:00:072default:default2
2099.3092default:default2
495.5782default:default2
1542default:default2
46822default:defaultZ17-722h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
|/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_myip_0_0/src/clk_wiz_0_4/clk_wiz_0.xdc2default:default2R
<design_1_i/myip_0/inst/myip_v1_0_S00_AXI_inst/u_clk_180/inst	2default:default8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc2default:default2:
$design_1_i/processing_system7_0/inst	2default:default8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc2default:default2:
$design_1_i/processing_system7_0/inst	2default:default8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_rst_ps7_0_50M_0/design_1_rst_ps7_0_50M_0_board.xdc2default:default21
design_1_i/rst_ps7_0_50M/U0	2default:default8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_rst_ps7_0_50M_0/design_1_rst_ps7_0_50M_0_board.xdc2default:default21
design_1_i/rst_ps7_0_50M/U0	2default:default8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_rst_ps7_0_50M_0/design_1_rst_ps7_0_50M_0.xdc2default:default21
design_1_i/rst_ps7_0_50M/U0	2default:default8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�/home/jaewon/Documents/lab10/practice/practice.srcs/sources_1/bd/design_1/ip/design_1_rst_ps7_0_50M_0/design_1_rst_ps7_0_50M_0.xdc2default:default21
design_1_i/rst_ps7_0_50M/U0	2default:default8Z20-847h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
}
6Generating merged BMM file for the design top '%s'...
58*memdata2$
design_1_wrapper2default:defaultZ28-58h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:00.012default:default2
2244.3792default:default2
0.0002default:default2
1442default:default2
46562default:defaultZ17-722h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
202default:default2
22default:default2
02default:default2
02default:defaultZ4-41h px� 
]
%s completed successfully
29*	vivadotcl2
link_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2!
link_design: 2default:default2
00:00:162default:default2
00:00:172default:default2
2244.3792default:default2
885.6132default:default2
1442default:default2
46562default:defaultZ17-722h px� 


End Record