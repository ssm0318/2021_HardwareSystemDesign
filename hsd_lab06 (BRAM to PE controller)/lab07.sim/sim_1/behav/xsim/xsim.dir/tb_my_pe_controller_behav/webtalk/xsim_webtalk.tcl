webtalk_init -webtalk_dir /home/jaewon/Documents/lab07/lab07.sim/sim_1/behav/xsim/xsim.dir/tb_my_pe_controller_behav/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Fri Apr 23 14:04:05 2021" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2018.3 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2405991" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "LIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "eea52ec1-169f-4008-b2e7-8d1441f34238" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "81fc1e78fc7f4ebaaf72fc69bbc928c1" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "4" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Ubuntu" -context "user_environment"
webtalk_add_data -client project -key os_release -value "Ubuntu 20.04.1 LTS" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "3100.283 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "8.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key trace_waveform -value "true" -context "xsim\\usage"
webtalk_add_data -client xsim -key runtime -value "8 us" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "8" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.07_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "127124_KB" -context "xsim\\usage"
webtalk_transmit -clientid 660194150 -regid "" -xml /home/jaewon/Documents/lab07/lab07.sim/sim_1/behav/xsim/xsim.dir/tb_my_pe_controller_behav/webtalk/usage_statistics_ext_xsim.xml -html /home/jaewon/Documents/lab07/lab07.sim/sim_1/behav/xsim/xsim.dir/tb_my_pe_controller_behav/webtalk/usage_statistics_ext_xsim.html -wdm /home/jaewon/Documents/lab07/lab07.sim/sim_1/behav/xsim/xsim.dir/tb_my_pe_controller_behav/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
