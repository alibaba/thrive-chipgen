// Ref Model
`define NOISA

// Path Define
// Top 
`define TB                      tb_top
`define DUT                     `TB.dut
`define SHELL                   `DUT.shell
`define PCI_EP                  `SHELL.qdma_pcie_sys.qdma_0.inst

// PE_0_0
`define PE_0_0 `DUT.x_pe_array_top.x_pe_0_0_pe_top
`define PE_0_0_SPM `PE_0_0.x_mem_sub_sys_top
`define PE_0_0_DPSRAM_0 `PE_0_0.x_mem_sub_sys_top.x_axi_uram_0.x_axi_uram.x_fpga_ram
`define PE_0_0_DPSRAM_1 `PE_0_0.x_mem_sub_sys_top.x_axi_uram_1.x_axi_uram.x_fpga_ram
`define PE_0_0_DPSRAM_2 `PE_0_0.x_mem_sub_sys_top.x_axi_uram_2.x_axi_uram.x_fpga_ram
`define PE_0_0_DPSRAM_3 `PE_0_0.x_mem_sub_sys_top.x_axi_uram_3.x_axi_uram.x_fpga_ram
`define PE_0_0_RV_0 `PE_0_0.x_rv_cluster_top.x_dispatcher_rv_wrapper
`define PE_0_0_RV_0_AHB `PE_0_0_RV_0.x_dispatcher_cpu_sub_system_ahb
`define PE_0_0_RV_1 `PE_0_0.x_rv_cluster_top.x_regular_0_rv_wrapper
`define PE_0_0_RV_1_AHB `PE_0_0_RV_1.x_regular_0_cpu_sub_system_ahb
`define PE_0_0_RV_2 `PE_0_0.x_rv_cluster_top.x_regular_1_rv_wrapper
`define PE_0_0_RV_2_AHB `PE_0_0_RV_2.x_regular_1_cpu_sub_system_ahb
// PE_1_0
`define PE_1_0 `DUT.x_pe_array_top.x_pe_1_0_pe_top
`define PE_1_0_SPM `PE_1_0.x_mem_sub_sys_top
`define PE_1_0_DPSRAM_0 `PE_1_0.x_mem_sub_sys_top.x_axi_uram_0.x_axi_uram.x_fpga_ram
`define PE_1_0_DPSRAM_1 `PE_1_0.x_mem_sub_sys_top.x_axi_uram_1.x_axi_uram.x_fpga_ram
`define PE_1_0_DPSRAM_2 `PE_1_0.x_mem_sub_sys_top.x_axi_uram_2.x_axi_uram.x_fpga_ram
`define PE_1_0_DPSRAM_3 `PE_1_0.x_mem_sub_sys_top.x_axi_uram_3.x_axi_uram.x_fpga_ram
`define PE_1_0_RV_0 `PE_1_0.x_rv_cluster_top.x_dispatcher_rv_wrapper
`define PE_1_0_RV_0_AHB `PE_1_0_RV_0.x_dispatcher_cpu_sub_system_ahb
`define PE_1_0_RV_1 `PE_1_0.x_rv_cluster_top.x_regular_0_rv_wrapper
`define PE_1_0_RV_1_AHB `PE_1_0_RV_1.x_regular_0_cpu_sub_system_ahb
`define PE_1_0_RV_2 `PE_1_0.x_rv_cluster_top.x_regular_1_rv_wrapper
`define PE_1_0_RV_2_AHB `PE_1_0_RV_2.x_regular_1_cpu_sub_system_ahb
// PE_0_1
`define PE_0_1 `DUT.x_pe_array_top.x_pe_0_1_pe_top
`define PE_0_1_SPM `PE_0_1.x_mem_sub_sys_top
`define PE_0_1_DPSRAM_0 `PE_0_1.x_mem_sub_sys_top.x_axi_uram_0.x_axi_uram.x_fpga_ram
`define PE_0_1_DPSRAM_1 `PE_0_1.x_mem_sub_sys_top.x_axi_uram_1.x_axi_uram.x_fpga_ram
`define PE_0_1_DPSRAM_2 `PE_0_1.x_mem_sub_sys_top.x_axi_uram_2.x_axi_uram.x_fpga_ram
`define PE_0_1_DPSRAM_3 `PE_0_1.x_mem_sub_sys_top.x_axi_uram_3.x_axi_uram.x_fpga_ram
`define PE_0_1_RV_0 `PE_0_1.x_rv_cluster_top.x_dispatcher_rv_wrapper
`define PE_0_1_RV_0_AHB `PE_0_1_RV_0.x_dispatcher_cpu_sub_system_ahb
`define PE_0_1_RV_1 `PE_0_1.x_rv_cluster_top.x_regular_0_rv_wrapper
`define PE_0_1_RV_1_AHB `PE_0_1_RV_1.x_regular_0_cpu_sub_system_ahb
`define PE_0_1_RV_2 `PE_0_1.x_rv_cluster_top.x_regular_1_rv_wrapper
`define PE_0_1_RV_2_AHB `PE_0_1_RV_2.x_regular_1_cpu_sub_system_ahb
// PE_1_1
`define PE_1_1 `DUT.x_pe_array_top.x_pe_1_1_pe_top
`define PE_1_1_SPM `PE_1_1.x_mem_sub_sys_top
`define PE_1_1_DPSRAM_0 `PE_1_1.x_mem_sub_sys_top.x_axi_uram_0.x_axi_uram.x_fpga_ram
`define PE_1_1_DPSRAM_1 `PE_1_1.x_mem_sub_sys_top.x_axi_uram_1.x_axi_uram.x_fpga_ram
`define PE_1_1_DPSRAM_2 `PE_1_1.x_mem_sub_sys_top.x_axi_uram_2.x_axi_uram.x_fpga_ram
`define PE_1_1_DPSRAM_3 `PE_1_1.x_mem_sub_sys_top.x_axi_uram_3.x_axi_uram.x_fpga_ram
`define PE_1_1_RV_0 `PE_1_1.x_rv_cluster_top.x_dispatcher_rv_wrapper
`define PE_1_1_RV_0_AHB `PE_1_1_RV_0.x_dispatcher_cpu_sub_system_ahb
`define PE_1_1_RV_1 `PE_1_1.x_rv_cluster_top.x_regular_0_rv_wrapper
`define PE_1_1_RV_1_AHB `PE_1_1_RV_1.x_regular_0_cpu_sub_system_ahb
`define PE_1_1_RV_2 `PE_1_1.x_rv_cluster_top.x_regular_1_rv_wrapper
`define PE_1_1_RV_2_AHB `PE_1_1_RV_2.x_regular_1_cpu_sub_system_ahb

// Used in "tb_finish_mnt.sv"
`define MAX_RUN_TIME 8000000000
`define LAST_CYCLE 500000

// for cpu finish control and printf
`define MAILBOX_ADDR 32'hc00001f8 // finish address
`define PASS_FLAG	32'hffff
`define FAIL_FLAG	32'hdead
