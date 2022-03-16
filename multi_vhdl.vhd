LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY multi_vhdl IS
	PORT (
		MAX10_CLK1_50 : IN STD_LOGIC;
		RESET : IN STD_LOGIC
	);
END multi_vhdl;

ARCHITECTURE multi OF multi_vhdl IS


	component soc is
		port (
			clk_clk       : in std_logic := 'X'; -- clk
			reset_reset_n : in std_logic := 'X'  -- reset_n
		);
	end component soc;

	
begin

	u0 : component soc
		port map (
			clk_clk       => MAX10_CLK1_50,       --   clk.clk
			reset_reset_n => RESET  -- reset.reset_n
		);
	
END multi;